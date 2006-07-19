Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2006 15:39:46 +0100 (BST)
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:55739 "EHLO
	wip-ec-wd.wipro.com") by ftp.linux-mips.org with ESMTP
	id S8133425AbWGSOjh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Jul 2006 15:39:37 +0100
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id 80DA92063D
	for <linux-mips@linux-mips.org>; Wed, 19 Jul 2006 20:06:37 +0530 (IST)
Received: from blr-ec-bh02.wipro.com (blr-ec-bh02.wipro.com [10.201.50.92])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id 6B57A2061B
	for <linux-mips@linux-mips.org>; Wed, 19 Jul 2006 20:06:37 +0530 (IST)
Received: from blr-m2-msg.wipro.com ([10.116.50.99]) by blr-ec-bh02.wipro.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 19 Jul 2006 20:09:30 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: CRAMFS  Ramdisk image as Rootfs
Date:	Wed, 19 Jul 2006 20:09:30 +0530
Message-ID: <2156B1E923F1A147AABDF4D9FDEAB4CB09D2E6@blr-m2-msg.wipro.com>
In-Reply-To: <20060719143500.GI4613@networkno.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CRAMFS  Ramdisk image as Rootfs
Thread-Index: AcarQLDHY0SZHVbVRUWxtoAC8ake1gAAL2Eg
From:	<hemanth.venkatesh@wipro.com>
To:	<ths@networkno.de>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 19 Jul 2006 14:39:30.0568 (UTC) FILETIME=[24D32880:01C6AB41]
Return-Path: <hemanth.venkatesh@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hemanth.venkatesh@wipro.com
Precedence: bulk
X-list: linux-mips

Yes, I am able to mount the image on an RHEL host using the loopback
device.

Hemanth

-----Original Message-----
From: Thiemo Seufer [mailto:ths@networkno.de] 
Sent: Wednesday, July 19, 2006 8:05 PM
To: Hemanth V (WT01 - Embedded Systems)
Cc: linux-mips@linux-mips.org
Subject: Re: CRAMFS Ramdisk image as Rootfs

hemanth.venkatesh@wipro.com wrote:
> Hi All,
> 
>  
> 
> I was trying to mount cramfs image as Ramdisk rootfs for 2.6.14
kernel.
> Even though the kernel seems to detect the cramfs image, it is not
able
> to mount it as rootfs. It throws the error "cramfs: bad root offset
> 4864" The target is little endian, and  RHEL host on which the image
was
> built is also little endian. 

Sounds like the fs image is somewhat broken. Is the cramfs
loop-mountable
on RHEL without showing the error message?


Thiemo
