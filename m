Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2002 19:00:16 +0100 (CET)
Received: from neptune.phys.ufl.edu ([128.227.64.7]:38883 "HELO
	neptune.phys.ufl.edu") by linux-mips.org with SMTP
	id <S1122123AbSKUSAQ>; Thu, 21 Nov 2002 19:00:16 +0100
Received: by neptune.phys.ufl.edu (Postfix, from userid 4468)
	id 88B68603F; Thu, 21 Nov 2002 13:00:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by neptune.phys.ufl.edu (Postfix) with ESMTP
	id 77A9525C3C; Thu, 21 Nov 2002 13:00:09 -0500 (EST)
Date: Thu, 21 Nov 2002 13:00:09 -0500 (EST)
From: David Hansen <hansen@phys.ufl.edu>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Origin 2000 installation
In-Reply-To: <20021121184119.A29975@linux-mips.org>
Message-ID: <Pine.SOL.4.44.0211211254390.11471-100000@neptune.phys.ufl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <hansen@phys.ufl.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hansen@phys.ufl.edu
Precedence: bulk
X-list: linux-mips

On Thu, 21 Nov 2002, Ralf Baechle wrote:
> The Debian installer support Indys only so a bit of creativity will be
> required to get it to work, I fear.  At least Debian doesn't ship with
> Origin kernel images.

 Is there a preferred distribution/method for Origin installations?

> The good old trick of booting of NFS root, then transfering the NFS root
> stuff to local disk will work though.

 The system does currently have an IRIX installation on it, would it be
easier to use a NFS root method or is there a documented method for doing
this from an existing local IRIX environment?

> The Origin port is fairly broken in CVS right now but I'm fixing it
> currently.  I've posted patches here but let me know when you need the
> patches agains the latest CVS kernel.
>
> For now there are only mbox archives available on ftp.linux-mips.org
> in /pub/linux/mips/archives/linux-mips.org/linux-mips/

  Great, thanks alot for the reply and information. I'll check out the
mailing list archives today.

 -David
