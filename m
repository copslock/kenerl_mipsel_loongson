Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3O90pn06520
	for linux-mips-outgoing; Tue, 24 Apr 2001 02:00:51 -0700
Received: from colo.asti-usa.com (IDENT:root@colo.asti-usa.com [205.252.89.99])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3O90oM06517
	for <linux-mips@oss.sgi.com>; Tue, 24 Apr 2001 02:00:50 -0700
Received: from lineo.com (hal.uk.zentropix.com [212.74.13.151])
	by colo.asti-usa.com (8.9.3/8.9.3) with ESMTP id FAA26907;
	Tue, 24 Apr 2001 05:09:12 -0400
Message-ID: <3AE541B0.410FDF8A@lineo.com>
Date: Tue, 24 Apr 2001 10:04:48 +0100
From: Ian Soanes <ians@lineo.com>
Organization: Lineo UK
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fabrice Bellard <bellard@email.enst.fr>
CC: linux-mips@oss.sgi.com, rivers@lexmark.com
Subject: Re: gdb single step ?
References: <3AE44D0A.9080003@jungo.com> <Pine.GSO.4.02.10104231829020.19846-100000@chimene.enst.fr> <20010423170425.F4623@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Mon, Apr 23, 2001 at 06:31:20PM +0200, Fabrice Bellard wrote:
> 
> > Did someone make a patch so that gdb can do single step on mips-linux ? If
> > not, do you prefer a patch to gdb or a patch in the kernel to support the
> > PTRACE_SINGLESTEP command ?
> 
> Last I used GDB single stepping has been working fine for me, so I wonder
> what is broken?
> 

Hi Fabrice,

This may not be totally relevant, but I'm currently trying to get
gdbserver working on a RC32334 IDT board. I've been having some issues
with single stepping, but am making a bit of progress.

1/ I started with a mips gdbserver port kindly supplied by Martin
Rivers. It mostly works well but had some problems single stepping
through conditional branches (the problem may have been due to a
different target than Martin was using, or me... I am kind of new to
this :)

2/ Previously I've had some luck single stepping kernel and module code
with the kernel gdbstub (arch/mips/kernel/gdb-stub.c), so I ported the
relevant single stepping code into gdbserver. The results were much
better. The only thing that seems to be wrong now is stepping over
function calls isn't working quite right. I can step into functions OK
though.

If you're interested I'll let you know how I get on over the next few
days. If not, I won't be offended :)

Best regards,
Ian
