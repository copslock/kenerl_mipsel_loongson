Received:  by oss.sgi.com id <S305160AbQCMWfT>;
	Mon, 13 Mar 2000 14:35:19 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:32601 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQCMWfA>;
	Mon, 13 Mar 2000 14:35:00 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA20611; Mon, 13 Mar 2000 14:30:23 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA52884; Mon, 13 Mar 2000 14:33:29 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA04183
	for linux-list;
	Mon, 13 Mar 2000 14:22:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA90417
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 13 Mar 2000 14:22:04 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA08552
	for <linux@cthulhu.engr.sgi.com>; Mon, 13 Mar 2000 14:22:02 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port138.duesseldorf.ivm.de [195.247.65.138])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id XAA31454;
	Mon, 13 Mar 2000 23:21:49 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000313232242.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <00f301bf8c6d$35db4670$0ceca8c0@satanas.mips.com>
Date:   Mon, 13 Mar 2000 23:22:42 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: FP emulation patch available
Cc:     Linux SGI <linux@cthulhu.engr.sgi.com>,
        Linux/MIPS fnet <linux-mips@fnet.fr>,
        linux-mips@vger.rutgers.edu
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On 12-Mar-00 Kevin D. Kissell wrote:
> The R3900 is quite different in a number of details from the R3900A.
> It has a different ISA (MIPS II+ instead of MIPS I), a different pipeline
> and a different CP0 implementation. And the R3912 has its rather
> peculiar set of on-chip peripherals with, if memory serves, a somewhat
> obnoxious memory map. Do you have a set of documentation for the
> R3912?  I do, but I don't know when I will have time to check it against
> the R3000 Linux code.

Yes, I have documentation for the R3912. In fact, if I am allowed to say
this, I wrote most of the R3000 and all of the R3912 code so far in Linux 8)
 
>>Kevin, please forgive me this question, but has the Linux integration of
>>the FPU emulation code been tested on MIPS CPUs without FPU?
> 
> Yes.  Of course.  What kind of amateur fire-and-forget hacker do you take
> me for?!! ;-)   Specifically, we've run it on the MIPS 4Kc core.  Both big
> and little endian.  We also ran it on R4400 Indys and R5260 Algorithmics
> platforms with the FPUs disabled in software. 

That's exactly what I am wondering about. Does it make a difference for the
emulator if the CPU has an FPU (disabled, obviously) or not?

Personally, I don't have any idea why the emulator works perfectly on an R3000
but not on an R3912.

> I'm not saying that it's perfect - I know it cannot be - but the emulator
> does not get invoked until very late in the boot process, just before init
> fires up, so if you're dieing early on, whatever it is, it ain't the
> emulator, and it isn't the lack of FP.  Even without an emulator, the
> 2.2.12 kernel will get as far as trying to run init on an FPU-less
> machine.

Oh I see, I should have made myself more clear. I have a root filesystem on a
CF card based on declinuxroot (a cut down RedHat 5.1) and my Mobilon boots all
the way through to the login prompt if I delete the fsck from the initscripts.

Booting into single user mode I can easily verify that tools like df or e2fsck
are bombing out with floating point exeptions. My "tests" with the emulator
have been so far: Does df survive? What does fsck do? and things like that.
Well, with the emulator all these tools make the Mobilon crash. Hard. So hard
that even the reset button doesn't work.

Anyway, it looks like we will going to have a fully functional serial driver
soon and that should make debugging somewhat easier.

-- 
Regards,
Harald
