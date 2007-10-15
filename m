Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 02:42:51 +0100 (BST)
Received: from alnrmhc15.comcast.net ([204.127.225.95]:31367 "EHLO
	alnrmhc15.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20026988AbXJOBmm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 02:42:42 +0100
Received: from [192.168.1.4] (c-69-140-18-238.hsd1.md.comcast.net[69.140.18.238])
          by comcast.net (alnrmhc15) with ESMTP
          id <20071015014158b1500hu6sde>; Mon, 15 Oct 2007 01:41:58 +0000
Message-ID: <4712C55F.8060107@gentoo.org>
Date:	Sun, 14 Oct 2007 21:41:51 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Johannes Dickgreber <tanzy@gmx.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] arch/mips/pci/ioc3.c
References: <47093583.6010407@gmx.de> <20071009133503.GA1788@linux-mips.org>
In-Reply-To: <20071009133503.GA1788@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sun, Oct 07, 2007 at 09:37:39PM +0200, Johannes Dickgreber wrote:
>> From: Johannes Dickgreber <tanzy@gmx.de>
>> Date: Sun, 07 Oct 2007 21:37:39 +0200
>> To: Ralf Baechle <ralf@linux-mips.org>
>> CC: Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
>> Subject: [PATCH] arch/mips/pci/ioc3.c 
>> Content-Type: text/plain; charset=UTF-8
> 
> Kumba,
> 
> are you collecting Johannes' Octane patches?  They don't apply to the
> main MIPS tree.
> 
>   Ralf
> 

Yup, just haven't had enough free time to format them to apply and test.  This 
will probably take care of the ioc3 metadriver issue until you get your 
re-written one done.


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
