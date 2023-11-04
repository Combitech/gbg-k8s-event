#include <cstdlib>      /* getenv */
#include <filesystem>   
#include <iostream>     /* cout */
#include <stdio.h>      /* snprintf */
#include <string>       
#include <time.h>       /* time_t, struct tm, time, gmtime */
#include <unistd.h>     /* sleep */
#include <vector>

namespace fs = std::filesystem;

std::string getEnvString(const char* const varName);
std::string getNowString();
std::string listFilesInDir(const char* const dirName);

int main(int argc, char** argv)
{
  const std::string pwd = fs::current_path();
  while(true)
  {
    std::cout
      << getNowString() 
      << ", HOSTNAME=" << getEnvString("HOSTNAME")
      << ", MY_VAR=" << getEnvString("MY_VAR")
      << ", Files in current directory (" << pwd << "):\n---\n  " <<  listFilesInDir(pwd.c_str()) << "\n---\n" 
      << std::endl;

    sleep(5);
  }
	return 0;
}

// Helper for getting the current time in UTC as string
std::string getNowString()
{
  time_t rawtime;
  time(&rawtime); // Get number of seconds since 00:00 UTC Jan, 1, 1970
  struct tm *ptm = gmtime(&rawtime); // UTC struct tm
  char strbuf[10]; // formatted UTC string
  snprintf (strbuf, 10, "%2d:%02d:%02d", ptm->tm_hour, ptm->tm_min, ptm->tm_sec);
  return std::string(strbuf);
}

// Helper for reading environment variables and return empty string ("") for unset ones
std::string getEnvString(const char* const varName)
{
  char const* temp = std::getenv(varName);
  if (temp == NULL)
    return std::string("");

  return std::string(temp);
}

// Helper for listing all files in a directory (as comma separated single string)
std::string listFilesInDir(const char* const dirName)
{
  std::vector<std::string> files;
  for (const auto & entry : fs::directory_iterator(dirName))
    files.push_back(entry.path().filename());
    
  std::string result;
  for (int i = 0; i < files.size(); i++)
  {
    result.append(files[i]);
    if (i < files.size() - 1)
      result.append(", ");
  }

  return result;
}
