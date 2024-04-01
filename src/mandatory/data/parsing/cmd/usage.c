/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   usage.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: brda-sil <brda-sil@students.42angouleme    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/10/28 06:02:30 by brda-sil          #+#    #+#             */
/*   Updated: 2024/04/01 04:31:18 by brda-sil         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "template.h"

t_bin	usage(void)
{
	ft_dprintf(1, "\
Usage: %s [--verbose] [--help] [--usage] [--version] ARGS ...\n", PROG_NAME);
	return (0);
}
