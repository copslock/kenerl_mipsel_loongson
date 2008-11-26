Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 23:11:00 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:8091 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S23940979AbYKZXKy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Nov 2008 23:10:54 +0000
Date:	Wed, 26 Nov 2008 23:10:54 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Mark E Mason <mason@broadcom.com>
cc:	LMO <linux-mips@linux-mips.org>,
	"mmason@upwardaccess.com" <mmason@upwardaccess.com>
Subject: Re: Booting top-of-tree bcm47xx as nfs-root with cfe only (no
 sibyl)
In-Reply-To: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC801C@SJEXCHCCR01.corp.ad.broadcom.com>
Message-ID: <alpine.LFD.1.10.0811262304510.23566@ftp.linux-mips.org>
References: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC801C@SJEXCHCCR01.corp.ad.broadcom.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 26 Nov 2008, Mark E Mason wrote:

> Linux version 2.6.28-rc6 (mason@hawaii) (gcc version 3.4.4) #4 Wed Nov 26 13:59:54 PST 2008
> arcs_cmdline='root=/dev/nfs rw nfsroot=10.0.1.184:/home/mason/debian-root-el console=ttyS0,115200'<6>console [early0] enabled
[...]
> VFS: Cannot open root device "nfs" or unknown-block(0,255)
> Please append a correct "root=" boot option; here are the available partitions:
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,255)

 For NFS root to work you have to specify an "ip=" option too, so that a 
network interface gets assigned an address somehow.  The default for this 
option was changed to "off" at some point with no respective update to 
documentation apparently.

  Maciej
