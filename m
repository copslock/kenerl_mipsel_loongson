Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 00:23:01 +0000 (GMT)
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:7103 "EHLO
	rwcrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133496AbWAQAWo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 00:22:44 +0000
Received: from [192.168.1.4] (pcp04414054pcs.nrockv01.md.comcast.net[69.140.185.48])
          by comcast.net (rwcrmhc14) with ESMTP
          id <2006011700261101400237g6e>; Tue, 17 Jan 2006 00:26:12 +0000
Message-ID: <43CC39A0.8080704@gentoo.org>
Date:	Mon, 16 Jan 2006 19:26:08 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
CC:	zhuzhenhua <zzh.hust@gmail.com>
Subject: Re: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14?
References: <0F31272A2BCBBE4FA01344C6E69DBF501EAB1B@thoth.ivivity.com>
In-Reply-To: <0F31272A2BCBBE4FA01344C6E69DBF501EAB1B@thoth.ivivity.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Marc Karasek wrote:
> Look under arch/mips/ramdisk (I think).  This is where you should put the ramdisk.gz image and the compiler will pick it up and put it into the vmlinux image for you.  

Embedded Ramdisk support in 2.6 is deprecated and removed from the tree for 
kernels >=2.6.10.  You need to use initramfs now to get an embedded userland to 
work.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
