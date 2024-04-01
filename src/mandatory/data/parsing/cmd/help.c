/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   help.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: brda-sil <brda-sil@students.42angouleme    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/10/27 01:38:28 by brda-sil          #+#    #+#             */
/*   Updated: 2024/04/01 04:32:42 by brda-sil         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "template.h"

void	help_header(void)
{
	ft_putendl_fd("Usage: " PROG_NAME " [OPTION...] ARGS", 1);
}

void	help_part_1(void)
{
	ft_putendl_fd("\
 Options valid for --echo requests:\n\n\
  -?, --help                 give this help list\n\
      --usage                give a short usage message\n\
  -V, --version              print program version\n\
  -v, --verbose              verbose output\n\
", 1);
}

void	help_footer(void)
{
	ft_putendl_fd("Report bugs to <pixailz1@gmail.com>.", 1);
}

t_bin	help(void)
{
	help_header();
	help_part_1();
	help_footer();
	return (0);
}
