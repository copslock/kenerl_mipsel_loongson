Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2002 18:41:36 +0100 (CET)
Received: from p508B591D.dip.t-dialin.net ([80.139.89.29]:33463 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122123AbSKURlg>; Thu, 21 Nov 2002 18:41:36 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gALHfJr30566;
	Thu, 21 Nov 2002 18:41:19 +0100
Date: Thu, 21 Nov 2002 18:41:19 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: David Hansen <hansen@phys.ufl.edu>
Cc: linux-mips@linux-mips.org
Subject: Re: Origin 2000 installation
Message-ID: <20021121184119.A29975@linux-mips.org>
References: <Pine.SOL.4.44.0211201038250.7939-100000@neptune.phys.ufl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SOL.4.44.0211201038250.7939-100000@neptune.phys.ufl.edu>; from hansen@phys.ufl.edu on Thu, Nov 21, 2002 at 12:17:43PM -0500
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 21, 2002 at 12:17:43PM -0500, David Hansen wrote:

>  I am about to begin an attempt to install Linux onto an Origin 2000 (16p
> R10K 195MHz, IP27) and was curious as to whether or not there was any
> documentation geared specifically to an Origin installation (preferrably
> oriented towards Debian).

The Debian installer support Indys only so a bit of creativity will be
required to get it to work, I fear.  At least Debian doesn't ship with
Origin kernel images.

The good old trick of booting of NFS root, then transfering the NFS root
stuff to local disk will work though.

The Origin port is fairly broken in CVS right now but I'm fixing it
currently.  I've posted patches here but let me know when you need the
patches agains the latest CVS kernel.

> Also, is there a searchable archive of this
> mailing list so that I can search for old posts on the subject?

For now there are only mbox archives available on ftp.linux-mips.org
in /pub/linux/mips/archives/linux-mips.org/linux-mips/

  Ralf
