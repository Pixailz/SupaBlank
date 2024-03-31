#include "template.h"

void	test_include()
{
	ft_printf("Hello World! from mandatory\n");
	ft_utils_1();
	ft_utils_2();
	ft_utils_3();
	ft_utils_4();
	ft_utils_5();
}

void	test_define()
{
	ft_printf("prog_name  %s\n", PROG_NAME);
	ft_printf("pwd        %s\n", PWD);
	ft_printf("debug      %d\n", DEBUG);
	ft_printf("debug_fd   %d\n", DEBUG_FD);
	ft_printf("version    %s\n", VERSION);
}

int main(void)
{
	test_include();
	test_define();
	return (0);
}
