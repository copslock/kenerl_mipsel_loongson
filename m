Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Oct 2002 16:58:34 +0100 (CET)
Received: from p508B539B.dip.t-dialin.net ([80.139.83.155]:7661 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122117AbSJ3P6e>; Wed, 30 Oct 2002 16:58:34 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g9UFwMv22556;
	Wed, 30 Oct 2002 16:58:22 +0100
Date: Wed, 30 Oct 2002 16:58:22 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: make xmenuconfig is broken
Message-ID: <20021030165822.B19907@linux-mips.org>
References: <20021029103545.K24266@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021029103545.K24266@mvista.com>; from jsun@mvista.com on Tue, Oct 29, 2002 at 10:35:45AM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 29, 2002 at 10:35:45AM -0800, Jun Sun wrote:

> diff -Nru arch/mips/config-shared.in.orig arch/mips/config-shared.in
> --- arch/mips/config-shared.in.orig	Sun Oct  6 05:28:03 2002
> +++ arch/mips/config-shared.in	Tue Oct 29 10:29:14 2002
> @@ -513,7 +513,7 @@
>  if [ "$CONFIG_CPU_SB1" = "y" ]; then
>     choice 'SB1 Pass' \
>  	 "Pass1   CONFIG_CPU_SB1_PASS_1  \
> -	  Pass2   CONFIG_CPU_SB1_PASS_2
> +	  Pass2   CONFIG_CPU_SB1_PASS_2  \
>  	  Pass2.2 CONFIG_CPU_SB1_PASS_2_2" Pass1
>     if [ "$CONFIG_CPU_SB1_PASS_1" = "y" ]; then
>        define_bool CONFIG_SB1_PASS_1_WORKAROUNDS y

Just fixed that one and another choice statement.

Thanks,

  Ralf
