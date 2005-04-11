Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 16:58:10 +0100 (BST)
Received: from bay101-f5.bay101.hotmail.com ([IPv6:::ffff:64.4.56.15]:48186
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8226117AbVDKP5x>; Mon, 11 Apr 2005 16:57:53 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 11 Apr 2005 08:57:45 -0700
Message-ID: <BAY101-F54440B7BD61E4D879501FDC320@phx.gbl>
Received: from 64.4.56.208 by by101fd.bay101.hotmail.msn.com with HTTP;
	Mon, 11 Apr 2005 15:57:44 GMT
X-Originating-IP: [64.4.56.208]
X-Originating-Email: [danieljlaird@hotmail.com]
X-Sender: danieljlaird@hotmail.com
From:	"Daniel Laird" <danieljlaird@hotmail.com>
To:	macro@linux-mips.org
Cc:	libc-alpha@sources.redhat.com, linux-mips@linux-mips.org
Subject: Re: Building GLIBC 2.3.4 on MIPS
Date:	Mon, 11 Apr 2005 15:57:44 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 11 Apr 2005 15:57:45.0140 (UTC) FILETIME=[3355FF40:01C53EAF]
Return-Path: <danieljlaird@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips

I am trying to build glibc-2.3.4 (gcc-3.4.3, binutils-2.15.96) with 
linux-2.6.11.6 on mips.

I am having problems with bits/syscalls.h whereas yours seem to be empty 
mine just does not exist???
Any reason for this?
I have applied your patches but they do not seem to correct this error have 
you seen this.

Its just that when i try to compile busybox i get an error as bits/syscall.h 
is missing and obviously means my cross compiler toolchain is not quite 
correct.

Hope you can help
Daniel Laird
