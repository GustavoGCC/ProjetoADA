#include <dirent.h>
#include <sys/stat.h>

#include <string.h>
#include <stdio.h>
#include <iostream>
#include <string>
using namespace std;

void explore(char *dir_name) {
	DIR *dir; //pointer to an open director
	struct dirent *entry;	//stuff in the directory
	struct stat info;	//information about each entry

	//1 open
	dir = opendir(dir_name);
	if (!dir) {
		cout << "Directory was not found\n" << endl;
		return;
	}

	//2 read
	while ((entry = readdir(dir)) != NULL) {
		if (entry->d_name[0] != '.') {
			
			string path = string(dir_name) + "/" + string(entry->d_name);
			cout << "Entry = " << path << endl;
			stat(path.c_str(),&info);
			if(S_ISDIR(info.st_mode)) {
				explore((char*)path.c_str());
			}
		}
	}

	//3 close
	closedir(dir);
}
int main() {

	explore((char*)"."); 
	return 0;
}
