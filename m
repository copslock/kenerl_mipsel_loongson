Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2002 19:20:12 +0100 (CET)
Received: from p508B591D.dip.t-dialin.net ([80.139.89.29]:63159 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122123AbSKUSUM>; Thu, 21 Nov 2002 19:20:12 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gALIJxA31211;
	Thu, 21 Nov 2002 19:19:59 +0100
Date: Thu, 21 Nov 2002 19:19:59 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: David Hansen <hansen@phys.ufl.edu>
Cc: linux-mips@linux-mips.org
Subject: Re: Origin 2000 installation
Message-ID: <20021121191959.B30635@linux-mips.org>
References: <20021121184119.A29975@linux-mips.org> <Pine.SOL.4.44.0211211254390.11471-100000@neptune.phys.ufl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SOL.4.44.0211211254390.11471-100000@neptune.phys.ufl.edu>; from hansen@phys.ufl.edu on Thu, Nov 21, 2002 at 01:00:09PM -0500
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 21, 2002 at 01:00:09PM -0500, David Hansen wrote:

>  The system does currently have an IRIX installation on it, would it be
> easier to use a NFS root method or is there a documented method for doing
> this from an existing local IRIX environment?

A super-old distribution had tools to create and fill an ext2 fs from under
IRIX but nobody did maintain that, so still having IRIX isn't useful in
that context.

It doesn't harm either, Linux can coexist with IRIX.

> > The Origin port is fairly broken in CVS right now but I'm fixing it
> > currently.  I've posted patches here but let me know when you need the
> > patches agains the latest CVS kernel.
> >
> > For now there are only mbox archives available on ftp.linux-mips.org
> > in /pub/linux/mips/archives/linux-mips.org/linux-mips/
> 
>   Great, thanks alot for the reply and information. I'll check out the
> mailing list archives today.

You won't find too much O2k-related stuff though ...

  Ralf
