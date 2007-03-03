Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2007 21:13:06 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:29859 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037687AbXCCVNE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 Mar 2007 21:13:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l23FVpp0017951
	for <linux-mips@linux-mips.org>; Sat, 3 Mar 2007 15:31:51 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l23F3ExR005359;
	Sat, 3 Mar 2007 15:03:14 GMT
Date:	Sat, 3 Mar 2007 15:03:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Creating infrastructure to allow one kernel for multiple machines
Message-ID: <20070303150314.GE16562@linux-mips.org>
References: <20070227144818.GA25883@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070227144818.GA25883@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 27, 2007 at 02:48:18PM +0000, Martin Michlmayr wrote:

> On ARM and PowerPC, you can compile one kernel that will support
> multiple machines, as long as they all belong to the same group (e.g.
> have a compatible CPU).  On ARM, each machine needs to register a
> machine id at http://www.arm.linux.org.uk/developer/machines/ and then
> the boot loader passes this value to the kernel via a register.  On
> PowerPC, information about the machine can be found in OF's
> device-tree.
> 
> On MIPS, you need a separate kernel for each machine, which makes it
> hard for distros to support many machines.  For example, it would be
> nice if you could compile one kernel for vr41xx devices since they
> only differ slightly, e.g. in their PCI mappings.  I'm therefore
> wondering if there are any plans to introduce a scheme on MIPS that
> would allow one kernel for several machines.

In some cases that works but in many case it would simply be painful or
even impossible to implement due to conflicting load addresses, different
word sizes or endianess.  Probing for the system type would be required
and that would turn out to be about as fun as ISA probing.  So there
are limitations and within those I'm not so sure if the pain would be
justifyable.  As usual, I however will consider patches :-9

  Ralf
