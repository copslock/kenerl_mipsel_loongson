Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2004 15:41:27 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:45112
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224939AbULUPlX>; Tue, 21 Dec 2004 15:41:23 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Cgm8N-0002Gl-00; Tue, 21 Dec 2004 16:41:11 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Cgm8M-0008E1-00; Tue, 21 Dec 2004 16:41:10 +0100
Date: Tue, 21 Dec 2004 16:41:10 +0100
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: fix FIXADDR_TOP for TX39/TX49
Message-ID: <20041221154110.GT3539@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030517.214555.74756802.anemo@mba.ocn.ne.jp> <20041222.002853.55515442.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222.002853.55515442.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> >>>>> On Sat, 17 May 2003 21:45:55 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
> 
> anemo> On TX39/TX49, high 16MB in virtual address space
> anemo> (0xff000000-0xffffffff) are reserved and can not be used as
> anemo> normal mapped/cached segment.
> 
> anemo> This patch fixes FIXADDR_TOP for TX39/TX49.  FIXADDR_TOP is
> anemo> used not only if CONFIG_HIGHMEM is enabled.  It is also used
> anemo> for high limit address for vmalloc.
> 
> anemo> This patch can be applied to both 2.4 and 2.5.  I'm not sure
> anemo> whether subtracting 0x2000 is necessary or not but doing it is
> anemo> a safe bet.  Please apply.
> 
> This patch can still be applied to 2.6.  Could you apply?
> 
> --- linux-mips/include/asm-mips/fixmap.h	Sat Nov 27 00:39:25 2004
> +++ linux/include/asm-mips/fixmap.h	Sat Dec 18 21:21:01 2004
> @@ -70,7 +70,11 @@
>   * the start of the fixmap, and leave one page empty
>   * at the top of mem..
>   */
> +#if defined(CONFIG_CPU_TX39XX) || defined(CONFIG_CPU_TX49XX)
> +#define FIXADDR_TOP	(0xff000000UL - 0x2000)
> +#else
>  #define FIXADDR_TOP	(0xffffe000UL)

I figure it's PAGE_SIZE which should be subtracted here. (Or is it
2 * PAGE_SIZE for paired r4k-style TLBs?)


Thiemo
