/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: brda-sil <brda-sil@students.42angouleme    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/01 03:26:32 by brda-sil          #+#    #+#             */
/*   Updated: 2024/04/01 04:42:17 by brda-sil         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "template.h"

void	test_define()
{
	ft_printf("prog_name  %s\n", PROG_NAME);
	ft_printf("pwd        %s\n", PWD);
	ft_printf("debug      %d\n", DEBUG);
	ft_printf("debug_fd   %d\n", DEBUG_FD);
	ft_printf("version    %s\n", VERSION);
}

t_bin	run(int ac, char **av)
{
	int	ret;

	ret = parse_opts(ac, av);
	if (ret == BIT_01)
		return (ft_opt_exec_cmd());
	else if (ret != 0)
		return (ret);
	return (ret);
}

int	main(int ac, char **av)
{
	char	ret = 0;

	// test_define();
	ret = run(ac, av);
	ft_free_opts();
	return (ret);
}
