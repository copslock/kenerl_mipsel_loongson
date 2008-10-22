Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2008 19:56:02 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:44755 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S22150821AbYJVSz6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Oct 2008 19:55:58 +0100
Received: from lagash (p549AE91D.dip.t-dialin.net [84.154.233.29])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 644EB48916;
	Wed, 22 Oct 2008 20:55:55 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1Ksis6-0004I2-Ft; Wed, 22 Oct 2008 20:55:54 +0200
Date:	Wed, 22 Oct 2008 20:55:54 +0200
From:	Thiemo Seufer <ths@networkno.de>
To:	Zhang Le <r0bertz@gentoo.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] defined a macro for lemote 2e box IO base
Message-ID: <20081022185554.GA13842@networkno.de>
References: <1224722939-18557-1-git-send-email-r0bertz@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1224722939-18557-1-git-send-email-r0bertz@gentoo.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Zhang Le wrote:
> ---
>  arch/mips/include/asm/lemote/pci.h |   31 +++++++++++++++++++++++++++++++
>  arch/mips/lemote/lm2e/setup.c      |    9 ++-------
>  2 files changed, 33 insertions(+), 7 deletions(-)
>  create mode 100644 arch/mips/include/asm/lemote/pci.h
> 
> diff --git a/arch/mips/include/asm/lemote/pci.h b/arch/mips/include/asm/lemote/pci.h
> new file mode 100644
> index 0000000..8e5c9c3
> --- /dev/null
> +++ b/arch/mips/include/asm/lemote/pci.h
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright (c) 2008 Zhang Le <r0bertz@gentoo.org>
> + *
> + *     This program is free software; you can redistribute it
> + *     and/or modify it under the terms of the GNU General
> + *     Public License as published by the Free Software
> + *     Foundation; either version 2 of the License, or (at your
> + *     option) any later version.
> + *
> + *     This program is distributed in the hope that it will be
> + *     useful, but WITHOUT ANY WARRANTY; without even the implied
> + *     warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
> + *     PURPOSE.  See the GNU General Public License for more
> + *     details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this program; if not, write to the Free
> + *     Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
> + *     02139, USA.
> + */
> +
> +#ifndef _LEMOTE_PCI_H_
> +#define _LEMOTE_PCI_H_
> +
> +#ifdef CONFIG_64BIT
> +#define LEMOTE_IO_PORT_BASE 0xffffffffbfd00000
> +#else
> +#define LEMOTE_IO_PORT_BASE 0xbfd00000
> +#endif

Why not "((const long)0xbfd00000)" instead? AFAICS it is never used in
assembly code.


Thiemo
