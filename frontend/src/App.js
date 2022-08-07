import { useQuery, gql } from '@apollo/client';

export default function App() {
  return (
      <div>
          <DisplayRepos />
      </div>
  );
}

const GET_REPOS= gql`
  query{
  github(login: "SavenkovAlx") {
    username
    repos
  }
}
`;

function DisplayRepos() {
    const { loading, error, data } = useQuery(GET_REPOS);

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
        </div>
    );
}