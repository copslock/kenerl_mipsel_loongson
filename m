Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Dec 2006 23:14:12 +0000 (GMT)
Received: from fmmailgate03.web.de ([217.72.192.234]:29415 "EHLO
	fmmailgate03.web.de") by ftp.linux-mips.org with ESMTP
	id S20039846AbWLNXOH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Dec 2006 23:14:07 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 960D94634DEF;
	Fri, 15 Dec 2006 00:14:01 +0100 (CET)
Received: from [84.180.164.166] (helo=pluto.sol)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.107 #114)
	id 1Guzm5-0001D4-00; Fri, 15 Dec 2006 00:14:01 +0100
Received: from jens by pluto.sol with local (Exim 4.63)
	(envelope-from <tux-master@web.de>)
	id 1Guzhi-0001DC-NA; Fri, 15 Dec 2006 00:09:30 +0100
Date:	Fri, 15 Dec 2006 00:09:30 +0100
From:	Jens Seidel <jensseidel@users.sf.net>
To:	linux-mips@linux-mips.org
Cc:	Jens Seidel <jensseidel@users.sf.net>
Subject: Re: SGI Octane kernel patches fail
Message-ID: <20061214230930.GB2229@pluto>
References: <20061214203535.GA18511@pluto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214203535.GA18511@pluto>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Sender: tux-master@web.de
Return-Path: <tux-master@web.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jensseidel@users.sf.net
Precedence: bulk
X-list: linux-mips

On Thu, Dec 14, 2006 at 09:35:35PM +0100, Jens Seidel wrote:
> I tried to compile a newer 2.6.19-rc1 kernel and applied the two IOC3
> and IP30 patches from
> ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/. First of all
> the patch fails slightly and needs manual adjustments. Compiling results
> in an error, do_IRQ() is called with only one parameter instead of two.
> 
> So I wonder what kernels are compatible with
> linux-mips-2.6.19-rc1-ip30-r28.patch.bz2. Do I need other patches as
> well? Also the kernel config file skylark-approved-config-tm in skylark/
> is out of date. It seems to match a 2.6.12 or similar version.
> 
> PS: Please CC: me.

Ah, it works fine with linux-2.6.19 (it was trivial to crosscompile). So it
seems the names of the patches are just wrong.

I still fail to mount the root fs via NFS (tcpdump reports no network
transfer after loading the kernel) and to have root on a local hard disk:
[17179594.972000] XFS: file system using version 1 directory format
[17179595.044000] XFS: SB validate failed
[17179595.092000] VFS: Cannot open root device "sdb8" or unknown-block(8,24)
[17179595.172000] Please append a correct "root=" boot option
[17179595.240000] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,24)

I need to check this "SB validation". But I'm sure I'm able to embed an
initrd into the kernel as this works already with the old Gentoo kernel.

Jens
