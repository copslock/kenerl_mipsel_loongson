Received:  by oss.sgi.com id <S305160AbQCNSYG>;
	Tue, 14 Mar 2000 10:24:06 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:62525 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQCNSXy>;
	Tue, 14 Mar 2000 10:23:54 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA05794; Tue, 14 Mar 2000 10:19:16 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA94593
	for linux-list;
	Tue, 14 Mar 2000 10:14:59 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA44501
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 14 Mar 2000 10:14:55 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA08096
	for <linux@cthulhu.engr.sgi.com>; Tue, 14 Mar 2000 10:14:53 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port80.duesseldorf.ivm.de [195.247.65.80])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id TAA07601;
	Tue, 14 Mar 2000 19:14:39 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000314191532.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <005a01bf8d42$c656d2c0$ec44e8c3@Ulysses>
Date:   Tue, 14 Mar 2000 19:15:32 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: FP emulation patch available
Cc:     linux-mips@vger.rutgers.edu, Linux/MIPS fnet <linux-mips@fnet.fr>,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On 13-Mar-00 Kevin D. Kissell wrote:

[FPU emulator crashes on R3912]

> There are two ways in which the FPU emulator is close enough
> to the hardware to be this sensitive to implementation.  One
> is the way the emulator provokes an address error exception to
> execute a delay slot instruction following a simulated branch, but
> I don't think df or fsck do any branch-on-floating-conditions.  The
> other is, of course, that it counts on getting sensible and recoverable
> coprocessor unusable exceptions.  If the R3912 does something
> funky to the processor state on a CP1 unusable fault - an event
> that it doesn't have to deal with in its principal mission
> as a Windows CE platform - the results would be much
> what you are seeing.

Good Point. Thanks, Kevin, I'll look deeper into that.

-- 
Regards,
Harald
