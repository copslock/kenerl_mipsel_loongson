Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 16:23:47 +0000 (GMT)
Received: from mail.ivivity.com ([64.238.111.98]:15459 "EHLO thoth.ivivity.com")
	by ftp.linux-mips.org with ESMTP id S8133500AbWAQQX2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 16:23:28 +0000
Received: from 192.168.1.162 ([192.168.1.162]) by thoth.ivivity.com ([192.168.1.9]) with Microsoft Exchange Server HTTP-DAV ;
 Tue, 17 Jan 2006 16:26:57 +0000
Received: from MCK_Linux_NB by mail.ivivity.com; 17 Jan 2006 11:27:00 -0500
Subject: Re: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14?
From:	Marc Karasek <marckarasek@ivivity.com>
To:	Kumba <kumba@gentoo.org>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	zhuzhenhua <zzh.hust@gmail.com>
In-Reply-To: <43CC39A0.8080704@gentoo.org>
References: <0F31272A2BCBBE4FA01344C6E69DBF501EAB1B@thoth.ivivity.com>
	 <43CC39A0.8080704@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:	Tue, 17 Jan 2006 11:27:00 -0500
Message-Id: <1137515220.11738.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Return-Path: <marck@ivivity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marckarasek@ivivity.com
Precedence: bulk
X-list: linux-mips

Is this a better solution than having the ramdisk embedded? 

It seems that most of the MIPS development is embedded designs and this
could be a problem if it is not :

1) Easier 
or
2) Faster



On Mon, 2006-01-16 at 19:26 -0500, Kumba wrote:
> Marc Karasek wrote:
> > Look under arch/mips/ramdisk (I think).  This is where you should put the ramdisk.gz image and the compiler will pick it up and put it into the vmlinux image for you.  
> 
> Embedded Ramdisk support in 2.6 is deprecated and removed from the tree for 
> kernels >=2.6.10.  You need to use initramfs now to get an embedded userland to 
> work.
> 
> 
> --Kumba
> 
-- 
Any content within this email is provided “AS IS” for informational purposes only.  No contract will be formed between the parties by virtue of this email. 
/***********************
Marc Karasek
System Lead Technical Engineer
iVivity Inc.
T 678-990-1550 x238
F 678-990-1551
***********************/
