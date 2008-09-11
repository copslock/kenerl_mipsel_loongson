Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2008 15:13:19 +0100 (BST)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:20742 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S20183617AbYIKOM4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Sep 2008 15:12:56 +0100
Received: from [217.109.65.213] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id JAA29363
	for <linux-mips@linux-mips.org>; Thu, 11 Sep 2008 09:41:46 -0500
Message-ID: <48C92738.6070901@paralogos.com>
Date:	Thu, 11 Sep 2008 16:12:08 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Linux MIPS Org <linux-mips@linux-mips.org>
Subject: Re: SMTC Patches [0 of 3] (how about 4)
References: <48C6DC4C.5040208@paralogos.com>
In-Reply-To: <48C6DC4C.5040208@paralogos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

As sometimes happens, after releasing the trio of patches the other night,
further testing showed that there was still some quirky FPU-affinity 
behavior
when run on an 34Kf.  Further investigation turned up some odd little holes,
which I've fixed, but the misbehavior was mostly due to the default number
of FP emulations to be performed before declaring a process "FP intensive",
which depends on loops_per_jiffy, being so low that "make" was being
declared to be an FPU-intensive program.  This, too, has been dealt with.
I'm going to follow  this message with a "Patch 4 of 3" message containig
a patch which is meant  to be applied after the first 3 - it eliminates 
a part
of patch 1 of 3.  It's probably technically feasible to generate a patch 
that
replaces patch 1, but git and I get along poorly enough where I'd probably
just make a mess.

          Regards,

          Kevin K.

Kevin D. Kissell wrote:
> I've managed to steal enough time to rework the SMTC support
> for the MIPS 34K (and, I suppose 1004K) processors so that it
> works again near the head of the source tree.  This involved
> a complete rework of the clocking model to be compatible with
> new common timing event system, which finally enables "tickless"
> operation in SMTC, something it needed pretty badly.  I also
> solved the problem with using the "wait_irqoff" idle loop
> under SMTC.
>
> There are going to be three patches that will follow.  The
> first two are relatively localized fixes to problems with
> FPU affinity and with IPI replay that I came across in testing
> the new code.  The last is a pretty big patch, but it all
> pretty much hangs together and I couldn't see any sensible
> way to partition it.
>
>     Regards,
>
>     Kevin K.
>
>
