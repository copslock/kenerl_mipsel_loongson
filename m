Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 23:02:05 +0000 (GMT)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:30677 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225203AbTCDXCE>;
	Tue, 4 Mar 2003 23:02:04 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h24N1hUe020455;
	Tue, 4 Mar 2003 15:01:51 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id PAA24363;
	Tue, 4 Mar 2003 15:01:41 -0800 (PST)
Message-ID: <01e401c2e2a2$f1866010$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Kip Walker" <kwalker@broadcom.com>, <linux-mips@linux-mips.org>
Cc: "Ralf Baechle" <ralf@linux-mips.org>
References: <3E651FB7.A38AFD3B@broadcom.com>
Subject: Re: [PATCH] kernelsp on 64-bit kernel
Date: Wed, 5 Mar 2003 00:08:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> Is anyone else interested in having the 64-bit kernel *not* use the CP0
> watchpoint registers for storing the kernel stack pointer for the CPU's
> current process?
> 
> I have a couple problems with this:
>  - there are read-only bits in watchhi (according to the MIPS64 spec) so
> hoping to save and restore all high 32 bits (as currently coded) seems
> unjustified.
>  - somebody might want to actually *use* watchpoints (a JTAG debugger,
> in my case)

For whatever it's worth, I've always maintained that stealing the Watchpoint
registers in this way was a pretty questionable hack to be avoided.  Watchpoint
registers are *optional* in MIPS64 and may not even exist.  And yes, someone
might want to use them for their intended purpose some day.  However, please
note that the EJTAG breakpoint registers are completely orthogonal to the
watchpoint registers.

            Regards,

            Kevin K.
