Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Oct 2002 21:50:00 +0100 (CET)
Received: from p508B5FFC.dip.t-dialin.net ([80.139.95.252]:1164 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122121AbSJaUt7>; Thu, 31 Oct 2002 21:49:59 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g9VKnjv24104;
	Thu, 31 Oct 2002 21:49:45 +0100
Date: Thu, 31 Oct 2002 21:49:45 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: NFS Root broken in 2.4.18?  Anyone successfully booted?
Message-ID: <20021031214945.A31757@linux-mips.org>
References: <CBD6266EA291D5118144009027AA63350A68F183@xboi05.boi.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <CBD6266EA291D5118144009027AA63350A68F183@xboi05.boi.hp.com>; from roger_twede@hp.com on Thu, Oct 31, 2002 at 01:28:05PM -0500
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 31, 2002 at 01:28:05PM -0500, TWEDE,ROGER (HP-Boise,ex1) wrote:

> I found that the 2.4.18 system boots fine when booting from standard devices
> (IDE disks etc.).
> 
> Init fails to execute successfully when booting from NFS.  The NFS booting
> success appears to have died with 2.4.18.
> 
> The NFS boot completes fine in 2.4.17 but in 2.4.18 the NFS root is mounted
> and /sbin/init and the ld.so.1 are at least accessed, but the system never
> executes far enough in user space to even print a message to the console.
> 
> I've tried two different network card types just to be sure it wasn't a
> single driver issue.
> 
> Has anyone noticed this or does anyone know what changes may have caused
> this in 2.4.18? 
> I'm curious whether anyone has successfully booted 2.4.18 over NFS.

Problems like this are frequently caused by cache coherence problems in a
network driver.

  Ralf
