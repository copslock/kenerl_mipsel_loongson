Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 May 2008 23:43:51 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:20353 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S28578045AbYEZWnt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 May 2008 23:43:49 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m4QMhkno031008;
	Mon, 26 May 2008 23:43:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m4QMhgDs030956;
	Mon, 26 May 2008 23:43:42 +0100
Date:	Mon, 26 May 2008 23:43:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <adrian.bunk@movial.fi>
Cc:	Chris Dearman <chris@mips.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] MIPS SEAD compile fix
Message-ID: <20080526224342.GA28360@linux-mips.org>
References: <20080525180316.GF1791@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080525180316.GF1791@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 25, 2008 at 09:03:16PM +0300, Adrian Bunk wrote:

> This patch fixes the following compile error caused by
> commit 39b8d5254246ac56342b72f812255c8f7a74dca9
> ([MIPS] Add support for MIPS CMP platform.):
> 
> <--  snip  -->
> 
> ...
>   CC      arch/mips/mips-boards/generic/time.o
> cc1: warnings being treated as errors
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/mips-boards/generic/time.c:63: error: 'ledbitmask' defined but not used
> make[2]: *** [arch/mips/mips-boards/generic/time.o] Error 1
> 
> <--  snip  -->
> 
> Signed-off-by: Adrian Bunk <adrian.bunk@movial.fi>
> 
> ---
> a6622e47dd128da338d6dbae457ec1b043604814 diff --git a/arch/mips/mips-boards/generic/time.c b/arch/mips/mips-boards/generic/time.c
> index 008fd82..df23558 100644
> --- a/arch/mips/mips-boards/generic/time.c
> +++ b/arch/mips/mips-boards/generic/time.c

[...]

> +#if defined(CONFIG_MIPS_MALTA) || defined(CONFIG_MIPS_ATLAS)

Generic code thanks to #ifdef ;-)  Not really the way to go.  I just blew
away the original offending change.

  Ralf
