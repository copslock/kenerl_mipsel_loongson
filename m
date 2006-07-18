Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2006 09:46:47 +0100 (BST)
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:13971 "EHLO
	wip-ec-wd.wipro.com") by ftp.linux-mips.org with ESMTP
	id S8127232AbWGRIqi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Jul 2006 09:46:38 +0100
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id 4960D205E6
	for <linux-mips@linux-mips.org>; Tue, 18 Jul 2006 14:13:39 +0530 (IST)
Received: from blr-ec-bh01.wipro.com (blr-ec-bh01.wipro.com [10.201.50.91])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id 35AF2205D9
	for <linux-mips@linux-mips.org>; Tue, 18 Jul 2006 14:13:39 +0530 (IST)
Received: from blr-m2-msg.wipro.com ([10.116.50.99]) by blr-ec-bh01.wipro.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 18 Jul 2006 14:16:30 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Mounting rootfs from Alchemy Flash fails
Date:	Tue, 18 Jul 2006 14:16:23 +0530
Message-ID: <2156B1E923F1A147AABDF4D9FDEAB4CB09D16B@blr-m2-msg.wipro.com>
In-Reply-To: <20060718071819.GW5162@dusktilldawn.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mounting rootfs from Alchemy Flash fails
Thread-Index: AcaqOmjJXaqvsu/lQnWwaA5KoDrEbwACjM5A
From:	<hemanth.venkatesh@wipro.com>
To:	<freddy@dusktilldawn.nl>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 18 Jul 2006 08:46:30.0474 (UTC) FILETIME=[AA178AA0:01C6AA46]
Return-Path: <hemanth.venkatesh@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hemanth.venkatesh@wipro.com
Precedence: bulk
X-list: linux-mips

Freddy, thanks for your reply. We are not using DB1100 board, but a
custom board which has AU1100 core. We have added the partition info
into alchemy-flash.c but the probe is not going through. It doesnot seem
to have the dip switches you mentioned, and we are able to boot from
flash with a 2.4 kernel. Its only 2.6.14 that is giving problems.

Thanks
Hemanth

-----Original Message-----
From: Freddy Spierenburg [mailto:freddy@dusktilldawn.nl] 
Sent: Tuesday, July 18, 2006 12:48 PM
To: Hemanth V (WT01 - Embedded Systems)
Cc: linux-mips@linux-mips.org
Subject: Re: Mounting rootfs from Alchemy Flash fails

Hi Hemanth,

On Tue, Jul 18, 2006 at 10:47:16AM +0530, hemanth.venkatesh@wipro.com
wrote:
> We have updated Alchamy-flash.c  to specify  flash size 32 MB
> and physical address as 0X1E000000.

Isn't 32MB the default in 2.6.14 for the DB1100 board? If I
memorized it correctly you don't have to update anything. It
should work out of the box, since the DB1100 comes standard with
32MB flash.


> We found that probe function is failing and vendor command set
> is not found, log attached below. Any inputs for resolving the
> problem are appreciated.

Have you checked dip-switch S5? Both switches should be on (white
switches both near the 1 and 2 instead of the text cts-2)


-- 
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=C948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!
