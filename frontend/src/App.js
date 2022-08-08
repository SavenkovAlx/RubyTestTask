import React from 'react';
import { useQuery, gql } from '@apollo/client';

export default function App() {
  return (
      <div>
          <LoginForm />
      </div>
  );
}

const GET_REPOS= gql`
  query github($login : String!) {
  github(login: $login){
    username
    repos
  }
}
`;

class LoginForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {value: '', submited: false};

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleChange(event) {
        this.setState({value: event.target.value});
    }

    handleSubmit(event) {
        event.preventDefault();
        this.setState({submit: true});
    }

    render() {
        if (this.state.submit) {
            return (
            <DisplayRepos login={this.state.value } />

        );
        } else {
            return (
            <form onSubmit={this.handleSubmit}>
                <label>
                    Enter github login:
                    <input type="text" value={this.state.value} onChange={this.handleChange} />
                </label>
                <input type="submit" value="send" />
            </form>
        );}

    }
}

function DisplayRepos(login) {
    const { loading, error, data } = useQuery(GET_REPOS, {
        variables: {
            login: login["login"]
        }});

    if (loading) return <p>Loading...</p>;
    if (error) return <p>`Error ${error.message}`</p>;

    return (
        <div className="container">
            <h3>{data.github.username}</h3>
            <ul>
                {data.github.repos.map((item, index) => {
                    return <li key={index}>{item}</li>;
                })}
            </ul>
            <button onClick={() => { window.location.reload()}}>Refresh</button>
        </div>
    );
}