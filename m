Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2004 13:41:23 +0100 (BST)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:41132 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225304AbUFAMlS>;
	Tue, 1 Jun 2004 13:41:18 +0100
Received: from mercury.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.11/8.12.11) with ESMTP id i51CT80Z019069;
	Tue, 1 Jun 2004 05:29:08 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id i51CevD7020516;
	Tue, 1 Jun 2004 05:41:08 -0700 (PDT)
Message-ID: <047701c447d6$28aa9d60$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@linux-mips.org>,
	"Guido Guenther" <agx@sigxcpu.org>, <linux-mips@linux-mips.org>,
	<debian-toolchain@lists.debian.org>
References: <20040531230524.GB2785@bogon.ms20.nix> <20040601121520.GB25718@linux-mips.org>
Subject: Re: TLS register
Date: Tue, 1 Jun 2004 14:44:08 +0200
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> On Mon, May 31, 2004 at 08:05:24PM -0300, Guido Guenther wrote:
> 
> > Hi,
> > Now that gcc 3.4 has incompatible ABI changes (on o32 mostly affecting
> > mipsel) I've been discussing with Thiemo if I'd be the right point to
> > take this ABI change as a possibility to additionally reserve a TLS
> > register. 
> > He suggested $24 (t8) another discussed possibility would be $27 (k1)
> > which is already abused by the PS/2 folks for ll/sc emulation.
> > Another possibility would be to reserve such a register only in the
> > n32/n64 ABIs and let o32 stay without __thread and TLS forever.
> 
> Sigh, we'e been through this really often enough.  Reserving a register
> comes at a price so my approach was to implement a fast path in the
> exception code.  I've benchmarked that long time ago; it had less than
> half the overhead than normal syscall and such a function would be subject
> to normal code optimizations so calls should be few only.  Alpha already
> does something similar using their PAL code.

The overhead realtive to a normal syscall is much less interesting
to measure than the overhead relative to having the pointer already
in a register - after all, half of a whole lot of instructions is still a whole
lot of instructions.

As some, but perhaps not all of you know, MIPS is working on
multithreaded extensions to the instruction set architecture and
the hardware, which include the ability to create and destroy
parallel threads of executioon without OS intervention in the
"expected" case (and yes, I have thought about how Linux 
could support this, but I'm not gonna go into that here).
In such a framework, it would not be acceptable to do a
system call to get a TLS value.

I don't yet have an opinion as to whether we need to retrofit
things so that user-level multithreading is compatible with o32,
but I would comment that if we go for a TLS register, k1 may 
not be a very good option. The LL/SC emulation trick with k1 
works by virtue of k1 being *destroyed* by exceptions - it doesn't 
change its status as a register reserved for kernel use.

            Regards,

            Kevin K.
