Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2002 03:54:45 +0200 (CEST)
Received: from h24-83-212-10.vc.shawcable.net ([24.83.212.10]:48633 "EHLO
	bard.illuminatus.org") by linux-mips.org with ESMTP
	id <S1123891AbSJAByo>; Tue, 1 Oct 2002 03:54:44 +0200
Received: from templar ([10.0.0.2])
	by bard.illuminatus.org with esmtp (Exim 3.35 #1 (Debian))
	id 17wBMa-0003DO-00; Mon, 30 Sep 2002 17:58:12 -0700
Subject: Re: CVS Update@ftp.linux-mips.org: linux
From: Mike Nugent <mips@illuminatus.org>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20020930.135717.39150888.nemoto@toshiba-tops.co.jp>
References: <20020929014920Z1121744-9213+239@linux-mips.org> 
	<20020930.135717.39150888.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Sep 2002 18:46:41 -0700
Message-Id: <1033436801.13267.47.camel@templar>
Mime-Version: 1.0
Return-Path: <mips@illuminatus.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips@illuminatus.org
Precedence: bulk
X-list: linux-mips


Suggestion for this bug:  Since the except_vec3_r4000 is a fix for the
4k series only, add 'default' statement as below:


On Sun, 2002-09-29 at 21:57, Atsushi Nemoto wrote:
> It seems some necessary codes for non-r4k CPUs were lost by this change.
> 
> > CVSROOT:	/home/cvs
> > Module name:	linux
> > Changes by:	ralf@ftp.linux-mips.org	02/09/29 03:49:20
> > 
> > Modified files:
> > 	arch/mips/kernel: Tag: linux_2_4 traps.c 
> > 	arch/mips/mm   : Tag: linux_2_4 c-sb1.c tlb-sb1.c 
> > 	arch/mips64/kernel: Tag: linux_2_4 traps.c 
> > 	arch/mips64/mm : Tag: linux_2_4 Makefile c-sb1.c loadmmu.c 
> > 	                 tlb-r4k.c tlb-sb1.c tlbex-r4k.S 
> > Added files:
> > 	arch/mips64/mm : Tag: linux_2_4 c-andes.c c-r4k.c pg-andes.c 
> > 	                 pg-r4k.c tlb-andes.c 
> > Removed files:
> > 	arch/mips64/mm : Tag: linux_2_4 andes.c r4xx0.c 
> > 
> > Log message:
> > 	Reorganize arch/mips64/mm along the line of it's 32-bit equivalent.
> 
> This is a patch to revert the change.
> 
> diff -ur linux-mips-cvs/arch/mips/kernel/traps.c linux.new/arch/mips/kernel/traps.c
> --- linux-mips-cvs/arch/mips/kernel/traps.c	Sun Sep 29 19:45:07 2002
> +++ linux.new/arch/mips/kernel/traps.c	Mon Sep 30 13:41:23 2002
> @@ -1015,6 +1015,30 @@
>  			memcpy((void *)(KSEG0 + 0x180), &except_vec3_r4000,
>  			       0x80);
>  		}
> +	} else switch (mips_cpu.cputype) {
> +	case CPU_SB1:
> +		/*
> +		 * XXX - This should be folded in to the "cleaner" handling,
> +		 * above
> +		 */
> +		memcpy((void *)(KSEG0 + 0x180), &except_vec3_r4000, 0x80);
> +		break;
> +	case CPU_R6000:
> +	case CPU_R6000A:
> +	case CPU_R2000:
> +	case CPU_R3000:
> +	case CPU_R3000A:
> +	case CPU_R3041:
> +	case CPU_R3051:
> +	case CPU_R3052:
> +	case CPU_R3081:
> +	case CPU_R3081E:
> +	case CPU_TX3912:
> +	case CPU_TX3922:
> +	case CPU_TX3927:
> +	case CPU_TX39XX:
+     default:
> +		memcpy((void *)(KSEG0 + 0x80), &except_vec3_generic, 0x80);
> +		break;
>  	}
>  
>  	if (mips_cpu.cputype == CPU_R6000 || mips_cpu.cputype == CPU_R6000A) {
> ---
> Atsushi Nemoto
> 
> 
-- 
Mike Nugent
Programmer/Author
mike@illuminatus.org
"I believe the use of noise to make music will increase until we reach a
music produced through the aid of electrical instruments which will make
available for musical purposes any and all sounds that can be heard."
 -- composer John Cage, 1937
