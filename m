Received:  by oss.sgi.com id <S553827AbQKCK4i>;
	Fri, 3 Nov 2000 02:56:38 -0800
Received: from mx.mips.com ([206.31.31.226]:21405 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553814AbQKCK4W>;
	Fri, 3 Nov 2000 02:56:22 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id CAA10781;
	Fri, 3 Nov 2000 02:56:00 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id CAA03645;
	Fri, 3 Nov 2000 02:56:00 -0800 (PST)
Message-ID: <007d01c04585$25262e40$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>, "Jun Sun" <jsun@mvista.com>
Cc:     <linux-mips@oss.sgi.com>
References: <3A0067C5.BA9E3174@mvista.com> <20001102040657.A17786@bacchus.dhis.org>
Subject: Re: "Setting flush to zero for ..." - what is the warning?
Date:   Fri, 3 Nov 2000 11:58:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> On Wed, Nov 01, 2000 at 10:58:13AM -0800, Jun Sun wrote:
>
> > I ran some stress tests and start to get this warning.  It appears to be
> > generated in do_fpe() routine.  See below.  I wonder why this is
> > happening.  Can someone explain what is going on?  Thanks.
>
> It tells you the over-the-thumb-fp-mode has been activated ;-)

More seriously, there was (is, in 2.4 I guess) a hack by which,
in a desperate attempt to avoid having to do the FP emulation
in software, the kernel changed the FPU denorm handling mode
and replayed the instruction, in hopes that the problem would
go away (which it would for a subset of the unimplemented
operation cases). This is not legal IEEE behaviour, as it turns out,
but not many people cared.

> Somebody at MIPS is working on merging the necessary fp support software
> into the kernel, so this problem should be solved soon.

Once we had bolted the Algorithmics FPU emulator into the kernel,
the hack was no longer necessary.   To say that "somebody at MIPS
is working on merging the necessary fp support software into the
kernel" is perhaps a bit misleading.  The FPU emulator itself is in
the oss.sgi.com repository, in the 2_2 branch, but I did not merge
in the hacks to the kernel exception, context, signal, etc. handling.
And there are several bug fixes that have been made since then.
All the additional code is available on the ftp.mips.com server, and
has been merged by others into 2.3/2.4, most notably by the VrLinux
guys.

We've got 2.4-test running in the lab, but it is a long way
from being as robust under torture as our 2.2 kernel, and
we have not decided whether it is "ripe" enough to merge
in the FPU emulation support ourselves.

            Regards,

            Kevin K.
