Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2009 10:25:12 +0100 (BST)
Received: from mx1.moondrake.net ([212.85.150.166]:33532 "EHLO
	mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20023644AbZE0JZD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2009 10:25:03 +0100
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id EA9B2274001; Wed, 27 May 2009 11:25:02 +0200 (CEST)
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id B62DC274002;
	Wed, 27 May 2009 11:25:00 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id 72CA38281C;
	Wed, 27 May 2009 11:30:14 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id B9014FF855;
	Wed, 27 May 2009 11:27:58 +0200 (CEST)
From:	Arnaud Patard <apatard@mandriva.com>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: Re: [loongson-PATCH-v2 06/23] replace tons of magic numbers by understandable symbols
References: <cover.1243362545.git.wuzj@lemote.com>
	<943d884878d1e8ccec9c11732669c5ec35913314.1243362545.git.wuzj@lemote.com>
Organization: Mandriva
Date:	Wed, 27 May 2009 11:27:58 +0200
In-Reply-To: <943d884878d1e8ccec9c11732669c5ec35913314.1243362545.git.wuzj@lemote.com> (wuzhangjin@gmail.com's message of "Wed, 27 May 2009 03:04:58 +0800")
Message-ID: <m3y6siopy9.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

wuzhangjin@gmail.com writes:
Hi,

[...]

> diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
> new file mode 100644
> index 0000000..5f2cd3a
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson/machine.h
> @@ -0,0 +1,27 @@
> +/*
> + * board-specific header file
> + *
> + * Copyright (c) 2009 Wu Zhangjin <wuzj@lemote.com>
> + *
> + * This program is free software; you can redistribute it
> + * and/or modify it under the terms of the GNU General
> + * Public License as published by the Free Software
> + * Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#ifndef __MACHINE_H
> +#define __MACHINE_H
> +
> +#define MACH_NAME			"lemote-fuloong(2e)"
> +
> +#define LOONGSON_UART_BASE		0x1fd003f8

Why not using LOONGSON_PCIIO_BASE+0x3f8 ?

Arnaud
