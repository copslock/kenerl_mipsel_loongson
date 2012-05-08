Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 13:17:05 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36798 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903640Ab2EHLQ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 May 2012 13:16:58 +0200
Date:   Tue, 8 May 2012 12:16:58 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Hill, Steven" <sjhill@mips.com>
cc:     Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "Leung, Douglas" <douglas@mips.com>,
        "Dearman, Chris" <chris@mips.com>
Subject: RE: [PATCH 01/10] MIPS: Add core files for MIPS SEAD-3 development
 platform.
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B8011469208F@exchdb03.mips.com>
Message-ID: <alpine.LFD.2.00.1205080945120.3701@eddie.linux-mips.org>
References: <1333817315-30091-1-git-send-email-sjhill@mips.com> <1333817315-30091-2-git-send-email-sjhill@mips.com>,<4F8386C8.9020401@renesas.com> <31E06A9FC96CEC488B43B19E2957C1B8011469208F@exchdb03.mips.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, 7 May 2012, Hill, Steven wrote:

> I will certainly remove CONFIG_CPU_HAS_LLSC, thank you. I attempted to 
> enable 'cpu_has_clo_clz' for SEAD-3, but it breaks my microMIPS-only 
> kernel builds. Specifically, since microMIPS LL/SC instructions do not 
> have 16-bit address offsets, in the '__cmpxchg_asm' macro function I get 
> constraint errors because then the assembler has to use the %LO register 
> in order to calculate the offset address. I am going to hold off on 
> enabling the option until after the 3.5 release and then revisit for a 
> solution. Thank you.

 It's OK to ask. :)  Try using the "YC" constraint, this piece:

int test(void *p)
{
	int i;

	__asm__ __volatile__("ll\t%0,%1" : "=r" (i) : "YC" (*p));

	return i;
}

assembles to:

	ll	$2,0($4)
	jrc	$31

for me (with "-O2 -mmicromips").

 You may have to factor in backwards compatibility -- while "YC" is 
supported both in the microMIPS and the standard MIPS mode, switching the 
width of the immediate offset between 12 and 16 bits as appropriate, it's 
certainly a new constraint older compilers did not support.  I suggest 
using a macro, as usually, you can use some existing examples as a 
reference, e.g. <asm/compiler.h> (you know where to place this stuff now 
too :) ).

  Maciej
