Return-Path: <SRS0=IVVm=OU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091BEC5CFFE
	for <linux-mips@archiver.kernel.org>; Tue, 11 Dec 2018 10:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2AF2081B
	for <linux-mips@archiver.kernel.org>; Tue, 11 Dec 2018 10:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2AF2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeLKK6n (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:58:43 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:49328 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeLKK6m (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 11 Dec 2018 05:58:42 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990431AbeLKK6jX90YH (ORCPT
        <rfc822;linux-arch@vger.kernel.org> + 2 others);
        Tue, 11 Dec 2018 11:58:39 +0100
Date:   Tue, 11 Dec 2018 10:58:39 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@mips.com>
cc:     Firoz Khan <firoz.khan@linaro.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to
 'n64'
In-Reply-To: <20181210234620.rcmapky2aj7eb2wh@pburton-laptop>
Message-ID: <alpine.LFD.2.21.1812110321220.11202@eddie.linux-mips.org>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org> <1544073508-13720-4-git-send-email-firoz.khan@linaro.org> <20181210195144.dvprpyxyddusyb5c@pburton-laptop> <alpine.LFD.2.21.1812102324500.11202@eddie.linux-mips.org>
 <20181210234620.rcmapky2aj7eb2wh@pburton-laptop>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Paul,

> >  My feeling has been n32 was invented at SGI as an afterthought, hence the 
> > choice of having ABI32 or ABI64 defined for the 32-bit (now o32) and the 
> > 64-bit (now n64) ABI respectively was reasonable.
> 
> I'd agree if _MIPS_SIM were defined as _ABI32 for o32, but:
> 
>   $ mips-linux-gcc -mabi=32 -dM -E - </dev/null | grep ABIO32
>   #define _ABIO32 1
>   #define _MIPS_SIM _ABIO32
> 
> ...so _MIPS_SIM is:
> 
>   _ABIO32 for o32
>   _ABIN32 for n32
>   _ABI64 for n64
> 
> That doesn't seem very consistent to me, and means that there inevitably
> has to be some ugliness once there are multiple 64-bit ABIs.

 The _ABI* macros were invented as a GNU feature long after _MIPS_SIM_* 
ones, i.e. IIRC early 2000s vs mid 1990s.  Only _MIPS_SIM_* macros are 
referred in SGI documentation.

 It is inconsistent and I don't know why whoever invented the _ABI* macros 
didn't follow the original naming convention chosen by SGI for _MIPS_SIM_* 
ones, i.e. _ABI32, _NABI32, _ABI64 (but then I don't know either why some 
people have troubles with recognising patterns in existing code and then 
following those patterns when making changes or additions to that code; I 
guess that's just what some people are like).

 BTW in case anybody wondered SIM stands for Subprogram Interface Model.

> To me it feels like the result of someone thinking "one 64-bit MIPS ABI
> ought to be enough for anybody". I'm undecided whether that person was
> shortsighted or a genius whose vision was simply incomprehensible to
> those of us that followed.

 I think back when 64-bit processors were a new invention hardly anyone 
thought about proliferating 64-bit ABIs.  Remember that first MIPS systems 
were high-end workstations and servers and n32 was invented as a means to 
conserve memory, which wasn't seen as a necessity at the beginning.  A 
secondary goal might have been improving the performance of badly-written 
32-bit software, by means of the better function calling convention n32 
has over o32.

 Notice for example that for a long time x86-64 only had a single native 
64-bit ABI, which is LP64 like our n64, and it was only quite recently 
that the x86-64 x32 ILP32 ABI was added, which is like our n32.  And yet 
at this very moment it is being discussed on LKML whether x32 actually has 
any users beyond developers who maintain it and consequently whether it is 
worth it to keep support for it in our kernel.  To me it means in the 
workstation and server segment there is still no need to conserve memory 
(and with the ubiquity of 64-bit systems nowadays the need to maintain 
unportable 32-bit software has largely disappeared).

 So if anything was not expected it was the expansion of 64-bit MIPS 
processors into the embedded market or indeed the scale of the expansion 
of the embedded market itself, but I wouldn't call the lack of such an 
expectation short-sightedness.  It would be too bold a statement to me, 
because the change was simply too revolutionary to be considered some 25 
years ago.  Nobody in early 1990s would think of a 64-bit computer in a 
ballpoint pen or suchlike being a common device and the consequences for 
code design it would have.

 FWIW,

  Maciej
