Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 23:31:35 +0000 (GMT)
Received: from exch1.onstor.com ([66.201.51.80]:26029 "EHLO exch1.onstor.com")
	by ftp.linux-mips.org with ESMTP id S23941154AbYKZXbZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2008 23:31:25 +0000
Received: from ripper.onstor.net (10.0.0.42) by exch1.onstor.net (10.0.0.225)
 with Microsoft SMTP Server (TLS) id 8.1.311.2; Wed, 26 Nov 2008 15:31:15
 -0800
Date:	Wed, 26 Nov 2008 15:31:15 -0800
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	Mark E Mason <mason@broadcom.com>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	LMO <linux-mips@linux-mips.org>,
	"mmason@upwardaccess.com" <mmason@upwardaccess.com>
Subject: Re: Booting top-of-tree bcm47xx as nfs-root with cfe only (no
 sibyl)
Message-ID: <20081126153115.24dda1dc@ripper.onstor.net>
In-Reply-To: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC8037@SJEXCHCCR01.corp.ad.broadcom.com>
References: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC801C@SJEXCHCCR01.corp.ad.broadcom.com>
	<alpine.LFD.1.10.0811262304510.23566@ftp.linux-mips.org>
	<BD3F7F1EFBA6D54DB056C4FFA45140080348EC8037@SJEXCHCCR01.corp.ad.broadcom.com>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-EMS-Proccessed: 2K3Xl1OQTInXD6xxuA8z3Q==
X-EMS-STAMP: CrMbP8wqBF/NdeN1mgIv5w==
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

On Wed, 26 Nov 2008 15:21:08 -0800 Mark E Mason <mason@broadcom.com>
wrote:

> Hello Maciej!
> 
> Do you mean something like this?
> 
> setenv LINUX_CMDLINE "root=/dev/nfs rw ip=dhcp
> nfsroot=10.0.1.184:/home/mason/debian-root-el" ifconfig eth1 -auto
> boot -elf 10.0.1.184:vmlinux.47xx
> 
> [which ... Unfortunatetly doesn't work... :(]

Post the output from when this didn't work.  You know, so we can see
how you managed to screw it up ~:^)  I kid.  Sort of.  Yes, you should
have CONFIG_ROOT_NFS turned on.

> What about CONIFG_ROOT_NFS? Some of the HOWTOs on the net mention it,
> and it's still in some (most) of the default config files except for
> the bcm47xx (but I added it to mine manually as I couldn't find it in
> the menuconfig). So it shouldn't matter... Except that I'm
> paraniod... Is this a left over 2.4-ism?
> 
> I'm thinking this board, plus a USB disk and I should be able to
> build a portable mips system that I can actually take with me to hack
> on... Unlike the sibyte stuff which usually needs a handtruck to
> move...
> 
> Thanks!
> Mark
>  
> 
> -----Original Message-----
> From: Maciej W. Rozycki [mailto:macro@linux-mips.org] 
> Sent: Wednesday, November 26, 2008 3:11 PM
> To: Mark E Mason
> Cc: LMO; mmason@upwardaccess.com
> Subject: Re: Booting top-of-tree bcm47xx as nfs-root with cfe only
> (no sibyl)
> 
> On Wed, 26 Nov 2008, Mark E Mason wrote:
> 
> > Linux version 2.6.28-rc6 (mason@hawaii) (gcc version 3.4.4) #4 Wed
> > Nov 26 13:59:54 PST 2008 arcs_cmdline='root=/dev/nfs rw
> > nfsroot=10.0.1.184:/home/mason/debian-root-el
> > console=ttyS0,115200'<6>console [early0] enabled
> [...]
> > VFS: Cannot open root device "nfs" or unknown-block(0,255)
> > Please append a correct "root=" boot option; here are the available
> > partitions: Kernel panic - not syncing: VFS: Unable to mount root
> > fs on unknown-block(0,255)
> 
>  For NFS root to work you have to specify an "ip=" option too, so
> that a network interface gets assigned an address somehow.  The
> default for this option was changed to "off" at some point with no
> respective update to documentation apparently.
> 
>   Maciej
> 
> 
> 
