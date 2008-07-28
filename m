Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2008 19:51:09 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:40088 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S28584663AbYG1SvE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Jul 2008 19:51:04 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m6SIouqK015658;
	Mon, 28 Jul 2008 11:50:56 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 28 Jul 2008 11:50:56 -0700
Received: from [172.25.32.37] ([172.25.32.37]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 28 Jul 2008 11:50:56 -0700
Message-ID: <488E150F.9050508@windriver.com>
Date:	Mon, 28 Jul 2008 13:50:55 -0500
From:	Jason Wessel <jason.wessel@windriver.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] kgdb, mips: add arch support for the kernel's kgdb
 core
References: <20080725.012748.108121457.anemo@mba.ocn.ne.jp><488941C5.9060908@windriver.com><20080725.235233.130241768.anemo@mba.ocn.ne.jp> <20080728.230512.132304415.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080728.230512.132304415.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jul 2008 18:50:56.0308 (UTC) FILETIME=[DE4F6740:01C8F0E2]
Return-Path: <jason.wessel@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason.wessel@windriver.com
Precedence: bulk
X-list: linux-mips



Atsushi Nemoto wrote:
> On Fri, 25 Jul 2008 23:52:33 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>>> It seem ok to me to try it.  Here is version 3 of the patch, which I was going to send to Ralf.
>> Thanks, it works for me with serial_txx9 kgdboc module.
> 
> BTW, is FRAME_POINTER mandatory for kgdb?  I agree that FRAME_POINTER
> (ie. -fno-omit-frame-pointer -fno-optimize-sibling-calls) helps source
> level debugging, but I think transparency is more important.
> 
> Now kgdboc can be loaded/activated at run-time, so I want to enable
> CONFIG_KGDB usually.  But CONFIG_FRAME_POINTER introduces runtime
> overhead on overall kernel, which is too bad (at least on MIPS).
> 
> Also, selecting FRAME_POINTER (which is not selectable on MIPS)
> unconditionally looks somewhat inconsistent.
> 
> So ... Is this patch reasonable?
> 

Sure the patch is reasonable for MIPS, but I think it is worth going a
step further.

There is no technical reason that frame pointers are required for KGDB
in the present mainline sources.  This does allow for further
traceability but it is certainly not a requirement for the use of kgdb.
If all you want to do is look at frame 0 and inspect memory or set a
breakpoint and look at some structures kgdb will certainly serve your
purpose.

I'll consider this a defect to the kgdb core and update the
documentation to reflect that it is advised to use frame pointers, but
not a requirement.

Jason.
