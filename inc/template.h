/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   template.h                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: brda-sil <brda-sil@students.42angouleme    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/07/29 21:14:17 by brda-sil          #+#    #+#             */
/*   Updated: 2024/04/01 02:17:31 by brda-sil         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef TEMPLATE_H
# define TEMPLATE_H

# include "libft.h"

/* ########################################################################## */
/* FILES */
/* ##### */

// data/parsing/cmd/help.c
void		help_header(void);
void		help_part_1(void);
void		help_footer(void);
t_bin		help(void);

// data/parsing/cmd/usage.c
t_bin		usage(void);

// data/parsing/parse.c
t_bin		parse_opts(int ac, char **av);

// main.c
void		test_define();
t_bin		run(int ac, char **av);
int			main(int ac, char **av);

/* ########################################################################## */

#endif //TEMPLATE_H
