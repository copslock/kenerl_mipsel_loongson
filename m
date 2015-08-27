Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2015 11:41:29 +0200 (CEST)
Received: from relay1.mentorg.com ([192.94.38.131]:64253 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010600AbbH0Jl12xV8r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Aug 2015 11:41:27 +0200
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1ZUtgN-00068p-O0 from joseph_myers@mentor.com ; Thu, 27 Aug 2015 02:41:19 -0700
Received: from digraph.polyomino.org.uk (137.202.0.76) by
 SVR-IES-FEM-01.mgc.mentorg.com (137.202.0.104) with Microsoft SMTP Server id
 14.3.224.2; Thu, 27 Aug 2015 10:41:18 +0100
Received: from jsm28 (helo=localhost)   by digraph.polyomino.org.uk with
 local-esmtp (Exim 4.82)        (envelope-from <joseph@codesourcery.com>)       id
 1ZUtgK-0000nQ-Vn; Thu, 27 Aug 2015 09:41:17 +0000
Date:   Thu, 27 Aug 2015 09:41:16 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Markos Chandras <Markos.Chandras@imgtec.com>
CC:     Mike Frysinger <vapier@gentoo.org>, <libc-alpha@sourceware.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips: siginfo.h: add SIGSYS details [BZ #18863]
In-Reply-To: <55DEC3B9.1070105@imgtec.com>
Message-ID: <alpine.DEB.2.10.1508270940090.29564@digraph.polyomino.org.uk>
References: <1440563342-5411-1-git-send-email-vapier@gentoo.org> <alpine.DEB.2.10.1508260918240.26898@digraph.polyomino.org.uk> <20150826171017.GD3116@vapier> <55DEC3B9.1070105@imgtec.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <joseph_myers@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@codesourcery.com
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

On Thu, 27 Aug 2015, Markos Chandras wrote:

> >> OK.  CC to linux-mips because I see that the MIPS implementation of 
> >> copy_siginfo_to_user32 doesn't handle __SI_SYS, unlike arm64 at least, so 
> >> I suspect this won't in fact work for n32 or for o32 with a 64-bit kernel.
> > 
> > i'm getting reports of seccomp misbehavior on mips already which is what
> > started me down this glibc path.  i suspect the original port was tested
> > against o32 kernels only.
> > -mike
> > 
> 
> I have recently tested mips64 n64/n32 with the testsuite from libseccomp
> and that led me to this fix
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=9f161439e4104b641a7bfb9b89581d801159fec8
> 
> if you are aware of other problems (and perhaps a test to trigger them)
> that could be kernel related let me know

My observation about copy_siginfo_to_user32 missing a case was purely 
based on the kernel source code.  I've no reason to think it has anything 
to do with seccomp problems.

-- 
Joseph S. Myers
joseph@codesourcery.com
