Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 17:26:31 +0100 (BST)
Received: from bay101-f34.bay101.hotmail.com ([IPv6:::ffff:64.4.56.44]:60829
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8226124AbVDKQ0Q>; Mon, 11 Apr 2005 17:26:16 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 11 Apr 2005 09:26:09 -0700
Message-ID: <BAY101-F34FE6C8FFEB4555FB1EE0BDC320@phx.gbl>
Received: from 64.4.56.208 by by101fd.bay101.hotmail.msn.com with HTTP;
	Mon, 11 Apr 2005 16:26:08 GMT
X-Originating-IP: [64.4.56.208]
X-Originating-Email: [danieljlaird@hotmail.com]
X-Sender: danieljlaird@hotmail.com
From:	"Daniel Laird" <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Building Glibc-2.3.4 for mipsel
Date:	Mon, 11 Apr 2005 16:26:08 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 11 Apr 2005 16:26:09.0028 (UTC) FILETIME=[2AEEAC40:01C53EB3]
Return-Path: <danieljlaird@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips

I am trying to get Glibc-2.3.4 to build for mipsel.

I am using crosstool to help me do this
I am using 2.6.11.6 kernel
I am using 2.15.96 binutils
I am using Glibc-2.3.4
I am using 3.4.3 Gcc

I try to compile it and i get a problem in the install-headers target where 
it tries to pass -mabi=32 to a host compile.  This will obviously not work.

To get round this i comment out the offending line in 
sysdeps/mips/mips32/Makefile.

And pass in EXTRA_TARGET_CFLAGS="-mips32 -mtune=r4600"

This succesfuly builds me a toolchain and a kernel and the kernel runs on my 
target

I then try to compile BUSYBox-1.00 and it errors with a missing 
bits/syscall.h.  I check and it is correct this is missing .
I have seen some patches to do in this area and have tried them all but it 
makes no difference.

Has anyone used crosstool and GLibc-2-3-4 etc and built a tollchain where 
bits/syscall.h exists?

I think the problem may lie in my editing of the makefile before 
install-headers and then the editing it back.  But i want to know if anyone 
has done what i am trying.

Please help!!

DJL
