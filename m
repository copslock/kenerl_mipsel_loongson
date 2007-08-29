Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2007 00:51:37 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:11752 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20022503AbXH2Xv2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Aug 2007 00:51:28 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 7576930C818;
	Wed, 29 Aug 2007 23:51:38 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 29 Aug 2007 23:51:38 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 29 Aug 2007 16:51:18 -0700
Message-ID: <46D60675.2070709@avtrex.com>
Date:	Wed, 29 Aug 2007 16:51:17 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	guo guo <sunnyboyguo@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: problem about the tool chain for R3000
References: <50f30abd0708291609i72e4aa57oce757d79a7e87fd6@mail.gmail.com>
In-Reply-To: <50f30abd0708291609i72e4aa57oce757d79a7e87fd6@mail.gmail.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Aug 2007 23:51:18.0162 (UTC) FILETIME=[7E339720:01C7EA97]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

guo guo wrote:
> Dear All,
> 
> I'm trying to build tool chain with gcc4.2, binutils2.17 and glibc2.5
> for mips r3000 chip.
> During configure gcc I add 每mabi=32 每march=r3000 每mtune=r3000. and
> during building glibc, I add CFLAGS= -O2 每mabi=32 每march=r3000
> 每mtune=r3000,
> Then I dissembled the libc-2.5.90.so to check the instructions. I
> found it has two instructions rdhwr(0x7c03e83b) and sync(0x0000000f)
> that don't belongs to mips r3000.

The rdhwr and sync are used by the NPTL pthread library and must be
emulated by the linux kernel.  Probably you will see ll and sc in there
as well.  If you use glibc2.3.x with Linux threads then the rdhwr will
not be generated.

 Probably if you did not use libpthread you would not need any of the
thread synchronization primitives that cause ll,sc, and sync to be
generated.

But if you want libpthread and your CPU does not support the
instructions, you will have to emulate them.


David Daney
