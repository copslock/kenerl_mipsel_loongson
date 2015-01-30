Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 18:11:45 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53499 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012309AbbA3RLnxii7- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 18:11:43 +0100
Date:   Fri, 30 Jan 2015 17:11:43 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
cc:     linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: Re: [PATCH 2/2] MIPS: Makefile: Set default ISA level
In-Reply-To: <54CBB6C5.6020806@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501301701540.28301@eddie.linux-mips.org>
References: <1422629056-27715-1-git-send-email-markos.chandras@imgtec.com> <1422629056-27715-2-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501301621090.28301@eddie.linux-mips.org> <54CBB6C5.6020806@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, 30 Jan 2015, Markos Chandras wrote:

> >  Agreed, but does it happen for any actual configuration?  If so, then the 
> > configuration is broken and your proposal papers over it, an explicit 
> > `-march=' option is supposed to be there for all the possible CPU_foo 
> > settings.  At first look it seems to be the case in arch/mips/Makefile, 
> > but maybe I'm missing something.  Besides, a default of `-march=mips32' or 
> > whatever may not really be adequate for the CPU selected.
> 
> We do have some tools around which default on -march=mips32r6. Then a
> loongson3_defconfig build gives this
> 
> kernel/bounds.c:1:0: error: ‘-march=mips32r6’ is not compatible with the
> selected ABI
> 
> and that's because in the command line you have no -march=XXXX because
> there is none set for CPU_LOONGSON3
> 
> this is the case I've spotted so far, but if you say that *every* CPU_
> symbol needs to set good cflags then this needs to be addressed in a
> different way I suppose.

 In that case I'd expect `-march=loongson3a' or whatever is appropriate 
for the architecture to be set.  If a fallback is required for older 
toolchains, then an arrangement similar to one for CPU_SB1 can be made.
E.g.:

cflags-$(CONFIG_CPU_LOONGSON3)	+= $(call cc-option,-march=loongson3a,-march=mips64r2) -Wa,--trap

or suchlike (based on what GCC says about it).

  Maciej
