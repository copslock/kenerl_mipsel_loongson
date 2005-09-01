Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2005 09:27:42 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:19915 "EHLO
	mx01.qsc.de") by linux-mips.org with ESMTP id <S8225327AbVIAI1X>;
	Thu, 1 Sep 2005 09:27:23 +0100
Received: from port-195-158-167-225.dynamic.qsc.de ([195.158.167.225] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1EAkVo-0002tP-00; Thu, 01 Sep 2005 10:33:32 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1EAkVq-00019E-2F; Thu, 01 Sep 2005 10:33:34 +0200
Date:	Thu, 1 Sep 2005 10:33:34 +0200
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, geoman@gentoo.org, linux-mips@linux-mips.org
Subject: Re: compiling kernel 2.6.13
Message-ID: <20050901083333.GB26161@hattusa.textio>
References: <4315CD1C.80203@gentoo.org> <20050831153509.GF3377@linux-mips.org> <20050831155526.GW21717@hattusa.textio> <20050901.012247.36920050.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901.012247.36920050.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.10i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> >>>>> On Wed, 31 Aug 2005 17:55:26 +0200, Thiemo Seufer <ths@networkno.de> said:
> >> But that seems an IP22-specific problem.
> 
> ths> I _think_ it hits every 64bit kernel which uses mappings in
> ths> CKSEG0.  Do you know a system where this works?
> 
> Though I do not have IP22, I think this line in mach-ip22/space.h is
> inappropriate.
> 
> #define MAP_BASE		0xffffffffc0000000
> 
> It will make VMALLOC_END in pgtabe-64.h overflow.
> 
> #define VMALLOC_START		MAP_BASE
> #define VMALLOC_END	\
> 	(VMALLOC_START + PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE)
> 
> Shoule we use 0xc000000000000000 as MAP_BASE for IP22 ?

Thanks, this helped!


Thiemo
