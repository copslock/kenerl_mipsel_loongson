Received:  by oss.sgi.com id <S305154AbQCLVmT>;
	Sun, 12 Mar 2000 13:42:19 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:37387 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQCLVmF>; Sun, 12 Mar 2000 13:42:05 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA02007; Sun, 12 Mar 2000 13:45:25 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id NAA37795; Sun, 12 Mar 2000 13:42:04 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA94135
	for linux-list;
	Sun, 12 Mar 2000 13:23:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA73252
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 12 Mar 2000 13:22:58 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA05297
	for <linux@cthulhu.engr.sgi.com>; Sun, 12 Mar 2000 13:22:56 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port52.duesseldorf.ivm.de [195.247.65.52])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id WAA11128;
	Sun, 12 Mar 2000 22:22:41 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000312222334.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <008a01bf8c23$65dd01f0$0ceca8c0@satanas.mips.com>
Date:   Sun, 12 Mar 2000 22:23:34 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: FP emulation patch available
Cc:     linux-mips@vger.rutgers.edu, linux-mips@fnet.fr,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi Kevin,

On 12-Mar-00 Kevin D. Kissell wrote:
> I have come up with a slightly-less-pretty hack that uses the
> Load Address Error trap instead of the Trap instruction to force
> kernel entry in the delay slot emulator. It seems just as functional
> as the previous version (i.e. operational but "paranoia" finds an
> exponentiation problem), and is currently being tortured with crashme
> to see if it holds up under corrupted instruction streams and corrupted
> process states.  I attach a pseudo-patch (cvs diff -c output) for the changes
> relative to the version obtained by applying the previous patches on the
> paralogos.com server, and would appreicate verification that it does
> indeed work on an R3K.  If it does, I'll check it into the MIPS repository
> and it will be included in the next web distribution (and maybe our
> CD-ROMS).

After some minor patches it works fine on an R3000A (tested on a DECstation
5000/133 with 2.3.47) but my Mobilon (R3912) still bombs out horribly.
Unfortunately there is no fully functional serial driver for the R3912 yet so
all I am able to tell is that this box crashes so badly that even the CPU
internal LCD controller is going wild.

Either there are more differences between an R3000 and an R3900 core as I am
aware of (quite likely), or this may have something to do with the fact that the
R3912 definately has no FPU.

Kevin, please forgive me this question, but has the Linux integration of the FPU
emulation code been tested on MIPS CPUs without FPU?

-- 
Regards,
Harald
