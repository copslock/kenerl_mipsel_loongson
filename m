Received:  by oss.sgi.com id <S305177AbQAFPUq>;
	Thu, 6 Jan 2000 07:20:46 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:52301 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305175AbQAFPUe>; Thu, 6 Jan 2000 07:20:34 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id HAA02417; Thu, 6 Jan 2000 07:23:33 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA66051
	for linux-list;
	Thu, 6 Jan 2000 07:09:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA52549
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 6 Jan 2000 07:08:54 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA04740
	for <linux@cthulhu.engr.sgi.com>; Thu, 6 Jan 2000 07:08:16 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA24817;
	Thu, 6 Jan 2000 07:08:11 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id HAA11729;
	Thu, 6 Jan 2000 07:08:09 -0800 (PST)
Message-ID: <00ef01bf5859$6d11f410$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     "Florian Lohoff" <flo@rfc822.org>, <linux@cthulhu.engr.sgi.com>
Subject: Re: Decstation 5000/150 2.3.21 Boot successs
Date:   Thu, 6 Jan 2000 16:19:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


-----Original Message-----
From: Ralf Baechle <ralf@oss.sgi.com>
To: Kevin D. Kissell <kevink@mips.com>
Cc: Florian Lohoff <flo@rfc822.org>; linux@cthulhu.engr.sgi.com
<linux@cthulhu.engr.sgi.com>
Date: Thursday, January 06, 2000 3:27 PM
Subject: Re: Decstation 5000/150 2.3.21 Boot successs


>On Thu, Jan 06, 2000 at 10:12:21AM +0100, Kevin D. Kissell wrote:
>
>> The "setting flush to zero/Unimlemented exception"
>> problem is almost certainly due to the fact that the
>> DECstation binaries were compiled for R3000-based
>> platforms with R3K-style FPUs which have 32 single-precision
>> FP regs that can also be treated pairwise as 16
>> double-precision registers.  I didn't know that the 5000 line
>> had R4000 CPUs in them, but on the basis of your reported
>> CPU revision number, that's what you've got.
>>
>> The default SGI/MIPS Linux kernel startup sets the
>> "FR" bit in the CP0.Status register, which enables
>> R4000-style FPU registers, which is to say a full
>> compliment of 32 double-precision registers...
...
>Linux _never_ changes the FR flag.  In fact it's living in the assumption
>that once the firmware hands over the control to the kernel the FR flag
>has been configured apropriately.  For a 32-bit kernel the binaries available
>out there more or less conform to the MIPS ABI which uses the 16/32
>register model, that is the kernel expects the FR flag to be cleared.

Thanks for the correction.  Note that the tweak to head.S I suggested
simply adds FR to the bits to be cleared in case they happen to be
set.   My problem evidently was, and Florian's problem probably is, that
the firmware was leaving FR set when Linux booted, and the DECstation
binaries can't handle that configuration.   What I can say with some
confidence is that those odd error messages *will* result if Linux
boots on an R4000 with FR set, and tries to execute DECstation
binaries.

>In firm assumption that due all the practical problems involved with
>a non-standard execution model (i.e. 32-bit, o32-style ELF, 32/32
>register model and 32-bit gprs) I decieded that in practice nobody will
>use this and dumped all the support for it from later 2.3 kernels.  That
>is the scheduler will no longer try to handle context switching for
>the 32/32 fpr model correctly etc.
>
>If that's desired, how about providing a syscall which allows to manipulate
>this and possibly other bits?

I very much prefer the idea of having exec() to the right thing, so
that 32/32 fpr and o32 ABI programs can be mixed and matched
as appropriate - assuming, of course, that there's sufficient information
in the binary header to do the job!  In practical terms, given that
Linux is a multiuser and multitasking system, a syscall that throws
some sort of global switch could only be safely invoked once
at boot time, and as such offers little advantage over hardwired
kernel code.

            Regards,

            Kevin K.
