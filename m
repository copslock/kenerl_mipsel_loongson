Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 09:37:48 +0200 (CEST)
Received: from relay1.mentorg.com ([192.94.38.131]:35928 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903548Ab2EKHhl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 09:37:41 +0200
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
        by relay1.mentorg.com with esmtp 
        id 1SSkPu-0002qI-Ld from Maciej_Rozycki@mentor.com ; Fri, 11 May 2012 00:37:34 -0700
Received: from SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) by svr-orw-fem-01.mgc.mentorg.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 11 May 2012 00:37:34 -0700
Received: from [172.30.14.15] (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server id 14.1.289.1; Fri, 11 May 2012
 08:37:32 +0100
Date:   Fri, 11 May 2012 08:37:22 +0100
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     "Hill, Steven" <sjhill@mips.com>
CC:     Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: RE: [PATCH 01/10] MIPS: Add core files for MIPS SEAD-3 development
 platform.
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B80114692157@exchdb03.mips.com>
Message-ID: <alpine.LFD.2.00.1205082304120.3701@eddie.linux-mips.org>
References: <1333817315-30091-1-git-send-email-sjhill@mips.com> <1333817315-30091-2-git-send-email-sjhill@mips.com>,<4F8386C8.9020401@renesas.com> <31E06A9FC96CEC488B43B19E2957C1B8011469208F@exchdb03.mips.com>,<alpine.LFD.2.00.1205080945120.3701@eddie.linux-mips.org>
 <31E06A9FC96CEC488B43B19E2957C1B80114692157@exchdb03.mips.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-OriginalArrivalTime: 11 May 2012 07:37:34.0133 (UTC) FILETIME=[EE08FE50:01CD2F48]
X-archive-position: 33256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, 8 May 2012, Hill, Steven wrote:

> I thought the "YC" constraint was only present in CodeSourcery 
> toolchains, correct? If so, then that levies the requirement for a 
> vendor-specific toolchain to build a microMIPS kernel. I do not consider 
> that palpable. If it is not CodeSourcery-specific, then I will certainly 
> try it out.

 The GNU GPL applies, these sources are publicly available, so it's not 
like anyone can't use them, integrate into their compiler, etc.  Binutils 
microMIPS support has already been integrated upstream.

 Also is there any other compiler that makes microMIPS code?  If so, then 
I suggest that you convince its maintainers to make a compatible 
constraint available.  We'll need it sooner or later (you can force the 
address into a register of course -- it was already considered a few years 
ago before "R" was fixed in GCC to work reliably -- but I don't expect you 
want such a pessimisation) and anyone implementing microMIPS support in 
their compiler and willing to support building Linux will have to provide 
the necessary constraint just as everyone already has to provide the "R" 
constraint for standard MIPS code.

 Note that as it is, you need to do something about all the code that uses 
"R" with microMIPS instructions that have their immediate offset limited 
to 12 bits anyway -- apart from <asm/cmpxchg.h> considered here this 
includes stuff in <asm/futex.h> and <asm/r4kcache.h>.  I maintain that 
"YC" is your best bet especially given the little effort required to 
handle it, and should any other compiler choose to use a different 
constraint for this purpose, then it can be conditionalised on that 
compiler's ID.

 If you're concerned that "YC" can be used for something else in upstream 
GCC, then we can coordinate this with GCC maintainers -- it's not like 
we're running of of letters here.

  Maciej
