Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Aug 2015 11:30:37 +0200 (CEST)
Received: from relay1.mentorg.com ([192.94.38.131]:55467 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007390AbbHZJadbNbR1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Aug 2015 11:30:33 +0200
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-03.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1ZUX2I-000393-3m from joseph_myers@mentor.com ; Wed, 26 Aug 2015 02:30:26 -0700
Received: from digraph.polyomino.org.uk (137.202.0.76) by
 SVR-IES-FEM-03.mgc.mentorg.com (137.202.0.108) with Microsoft SMTP Server id
 14.3.224.2; Wed, 26 Aug 2015 10:30:24 +0100
Received: from jsm28 (helo=localhost)   by digraph.polyomino.org.uk with
 local-esmtp (Exim 4.82)        (envelope-from <joseph@codesourcery.com>)       id
 1ZUX2F-0007Zl-Ay; Wed, 26 Aug 2015 09:30:23 +0000
Date:   Wed, 26 Aug 2015 09:30:23 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Mike Frysinger <vapier@gentoo.org>
CC:     <libc-alpha@sourceware.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips: siginfo.h: add SIGSYS details [BZ #18863]
In-Reply-To: <1440563342-5411-1-git-send-email-vapier@gentoo.org>
Message-ID: <alpine.DEB.2.10.1508260918240.26898@digraph.polyomino.org.uk>
References: <1440563342-5411-1-git-send-email-vapier@gentoo.org>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <joseph_myers@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49016
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

On Wed, 26 Aug 2015, Mike Frysinger wrote:

> Linux 3.13 added SIGSYS details to siginfo_t; update glibc's copy to
> keep in sync with it.
> 
> 2015-08-25  Mike Frysinger  <vapier@gentoo.org>
> 
> 	[BZ #18863]
> 	* sysdeps/unix/sysv/linux/mips/bits/siginfo.h (siginfo_t): Add _sigsys.
> 	(si_call_addr): Define.
> 	(si_syscall): Define.
> 	(si_arch): Define.

OK.  CC to linux-mips because I see that the MIPS implementation of 
copy_siginfo_to_user32 doesn't handle __SI_SYS, unlike arm64 at least, so 
I suspect this won't in fact work for n32 or for o32 with a 64-bit kernel.

-- 
Joseph S. Myers
joseph@codesourcery.com
