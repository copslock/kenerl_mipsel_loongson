Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Nov 2004 18:01:05 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:62282
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224859AbUKJSA7>; Wed, 10 Nov 2004 18:00:59 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CRwm3-0003Fk-00; Wed, 10 Nov 2004 19:00:51 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CRwm2-0006LG-00; Wed, 10 Nov 2004 19:00:50 +0100
Date: Wed, 10 Nov 2004 19:00:50 +0100
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	libc-alpha@sources.redhat.com, Nigel Stephens <nigel@mips.com>
Subject: Re: [PATCH] MIPS/Linux: Kernel vs libc struct siginfo discrepancy
Message-ID: <20041110180050.GK7235@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.61.0411101657420.11408@perivale.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411101657420.11408@perivale.mips.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> Hello,
> 
>  Since the following change:
> 
> http://www.linux-mips.org/cvsweb/linux/include/asm-mips/siginfo.h.diff?r1=1.4&r2=1.5&only_with_tag=MAIN
> 
> dated back to Aug 1999 (!), the definitions of struct siginfo in Linux and 
> GNU libc differ to each other.

Only 2.4 Kernels, 2.6 uses the normal definition again.

> While it's the kernel that is at fault by 
> changing its ABI, at this stage it may be more acceptable to update glibc 
> as it's not the only program interfacing to Linux (uClibc?).  It doesn't 
> seem to be a heavily used feature as otherwise someone else would have 
> noticed the problem during these five years.  As I don't really have a 
> preference, hereby I provide two patches to choose from and ask for 
> voting.

I prefer to bring the 2.4 kernel in line with the rest of the system.

> The ChangeLog entry is for glibc, of course.
> 
> 2004-11-10  Maciej W. Rozycki  <macro@linux-mips.org>
> 
> 	* sysdeps/unix/sysv/linux/mips/bits/siginfo.h [struct siginfo] 
> 	(_sigchld): Update to match the kernel.
> 
>   Maciej
> 
> glibc-2.3.3-20041018-mips-siginfo_sigchld-1.patch
> diff -up --recursive --new-file glibc-2.3.3-20041018.macro/sysdeps/unix/sysv/linux/bits/siginfo.h glibc-2.3.3-20041018/sysdeps/unix/sysv/linux/bits/siginfo.h
> --- glibc-2.3.3-20041018.macro/sysdeps/unix/sysv/linux/bits/siginfo.h	Tue Apr 22 02:26:04 2003
> +++ glibc-2.3.3-20041018/sysdeps/unix/sysv/linux/bits/siginfo.h	Wed Nov 10 16:52:24 2004

You surely meant to change the mips-specific siginfo.h here.
