Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g648hkRw013673
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 01:43:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g648hjws013672
	for linux-mips-outgoing; Thu, 4 Jul 2002 01:43:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g648haRw013659;
	Thu, 4 Jul 2002 01:43:36 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.12.5/8.12.5) with ESMTP id g648lV8j029767;
	Thu, 4 Jul 2002 01:47:32 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA22799;
	Thu, 4 Jul 2002 01:47:28 -0700 (PDT)
Message-ID: <00d401c22337$7e731580$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>, "H. J. Lu" <hjl@lucon.org>
Cc: <linux-mips@oss.sgi.com>, "GNU C Library" <libc-alpha@sources.redhat.com>
References: <20020702114045.A16197@lucon.org> <20020702220651.B9566@dea.linux-mips.net>
Subject: Re: PATCH: Always use ll/sc for mips
Date: Thu, 4 Jul 2002 10:47:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-Spam-Status: No, hits=1.3 required=5.0 tests=PORN_12,PORN_3,PORN_10 version=2.20
X-Spam-Level: *
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> On Tue, Jul 02, 2002 at 11:40:45AM -0700, H. J. Lu wrote:
> 
> > The ll/sc emulation is implemented in 2.4.0 and above. This patch makes
> > glibc always use ll/sc.
> 
> Which means the overhead of two syscalls instead of one sysmips() call
> for something that is assumed to be dirt cheap.  R3000, R5900 etc.
> users won't this patch you, which'll have significant impact on their
> glibc performance.

The R5900 kernel for the Playstation 2 does not use system
calls.  It uses a memory-mapped pseudo-device hack that
the guys at Sony came up with, which is much faster.  We
at MIPS came up with an even faster hack which uses 
the destruction of a "k" register value, but which requires 
the branch-likely instruction and thus only workson 
MIPS II CPUs and above (R39xxx, R4xxx, R5xxx,
but not the classic R3K).  See my message
"Re: patches for test-and-set without ll/sc" of January 22.

I consider it to be very important for MIPS/Linux
that the embedded/workstation kernel and libraries
merge with the Playstation 2 "consumer" Linux, and
I don't think that will happen if we try to push the
PS2 people to use something far less efficient than
what they already have. "Entia non sunt multiplicanda 
praeter necessitatem", as a wise old guy once said,
but could we not consider a MIPS/Linux universe
where R3000 binaries use system calls, non-LL/SC
MIPSII+ binaries use k-register destruction, real,
manly, MIPS binaries use LL/SC instructions, and
where the MIPS/Linux kernel (a) supports an appropriate
system call, (b) makes a contract with userland to 
destroy k-regs predictably, and (c) contains the
emulation logic for LL/SC?  That should give us
full cross-platform binary compatibility, with optimal
performance on each platform when an appropriately
configured set of libraries and tools is installed.

            Regards,

            Kevin K.
 
