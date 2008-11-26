Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 23:52:08 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:52402 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S23941196AbYKZXwG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Nov 2008 23:52:06 +0000
Date:	Wed, 26 Nov 2008 23:52:06 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Mark E Mason <mason@broadcom.com>
cc:	LMO <linux-mips@linux-mips.org>,
	"mmason@upwardaccess.com" <mmason@upwardaccess.com>
Subject: RE: Booting top-of-tree bcm47xx as nfs-root with cfe only (no
 sibyl)
In-Reply-To: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC8037@SJEXCHCCR01.corp.ad.broadcom.com>
Message-ID: <alpine.LFD.1.10.0811262340550.23566@ftp.linux-mips.org>
References: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC801C@SJEXCHCCR01.corp.ad.broadcom.com> <alpine.LFD.1.10.0811262304510.23566@ftp.linux-mips.org> <BD3F7F1EFBA6D54DB056C4FFA45140080348EC8037@SJEXCHCCR01.corp.ad.broadcom.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 26 Nov 2008, Mark E Mason wrote:

> Do you mean something like this?
> 
> setenv LINUX_CMDLINE "root=/dev/nfs rw ip=dhcp nfsroot=10.0.1.184:/home/mason/debian-root-el"    

 Yes, it should work.

> What about CONIFG_ROOT_NFS? Some of the HOWTOs on the net mention it, 
> and it's still in some (most) of the default config files except for the 
> bcm47xx (but I added it to mine manually as I couldn't find it in the 
> menuconfig). So it shouldn't matter... Except that I'm paraniod... Is 
> this a left over 2.4-ism?

 For your configuration you need at least these:

CONFIG_NET=y
CONFIG_INET=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y

In the absence of a platform maintainer the respective default config 
files are at the very best only updated so that `make oldconfig' does not 
ask questions.

  Maciej
