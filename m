Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 23:21:35 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:58628 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S23941084AbYKZXV2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2008 23:21:28 +0000
Received: from [10.11.16.99] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Wed, 26 Nov 2008 15:21:10 -0800
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 0ADA02B1; Wed, 26 Nov 2008 15:21:10 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id EA4842B0; Wed, 26 Nov
 2008 15:21:09 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id HIH16106; Wed, 26 Nov 2008 15:21:09 -0800 (PST)
Received: from SJEXCHHUB01.corp.ad.broadcom.com (sjexchhub01
 [10.16.192.224]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 72C5220501; Wed, 26 Nov 2008 15:21:09 -0800 (PST)
Received: from SJEXCHCCR01.corp.ad.broadcom.com ([10.252.49.130]) by
 SJEXCHHUB01.corp.ad.broadcom.com ([10.16.192.224]) with mapi; Wed, 26
 Nov 2008 15:21:09 -0800
From:	"Mark E Mason" <mason@broadcom.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
cc:	LMO <linux-mips@linux-mips.org>,
	"mmason@upwardaccess.com" <mmason@upwardaccess.com>
Date:	Wed, 26 Nov 2008 15:21:08 -0800
Subject: RE: Booting top-of-tree bcm47xx as nfs-root with cfe only (no
 sibyl)
Thread-Topic: Booting top-of-tree bcm47xx as nfs-root with cfe only (no
 sibyl)
Thread-Index: AclQHEbopmtzMP4BRKCrYX/K01WdmgAAEpBg
Message-ID: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC8037@SJEXCHCCR01.corp.ad.broadcom.com>
References: <BD3F7F1EFBA6D54DB056C4FFA45140080348EC801C@SJEXCHCCR01.corp.ad.broadcom.com>
 <alpine.LFD.1.10.0811262304510.23566@ftp.linux-mips.org>
In-Reply-To: <alpine.LFD.1.10.0811262304510.23566@ftp.linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
acceptlanguage:	en-US
MIME-Version: 1.0
X-WSS-ID: 6533066C61S16757398-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello Maciej!

Do you mean something like this?

setenv LINUX_CMDLINE "root=/dev/nfs rw ip=dhcp nfsroot=10.0.1.184:/home/mason/debian-root-el"    
ifconfig eth1 -auto
boot -elf 10.0.1.184:vmlinux.47xx

[which ... Unfortunatetly doesn't work... :(]

What about CONIFG_ROOT_NFS? Some of the HOWTOs on the net mention it, and it's still in some (most) of the default config files except for the bcm47xx (but I added it to mine manually as I couldn't find it in the menuconfig). So it shouldn't matter... Except that I'm paraniod... Is this a left over 2.4-ism?

I'm thinking this board, plus a USB disk and I should be able to build a portable mips system that I can actually take with me to hack on... Unlike the sibyte stuff which usually needs a handtruck to move...

Thanks!
Mark
 

-----Original Message-----
From: Maciej W. Rozycki [mailto:macro@linux-mips.org] 
Sent: Wednesday, November 26, 2008 3:11 PM
To: Mark E Mason
Cc: LMO; mmason@upwardaccess.com
Subject: Re: Booting top-of-tree bcm47xx as nfs-root with cfe only (no sibyl)

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
