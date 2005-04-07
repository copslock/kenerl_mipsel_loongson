Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 18:32:54 +0100 (BST)
Received: from bay101-f35.bay101.hotmail.com ([IPv6:::ffff:64.4.56.45]:23676
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225273AbVDGRc1>; Thu, 7 Apr 2005 18:32:27 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 7 Apr 2005 10:32:20 -0700
Message-ID: <BAY101-F35417F4A22F1FC159B196ADC3E0@phx.gbl>
Received: from 64.4.56.200 by by101fd.bay101.hotmail.msn.com with HTTP;
	Thu, 07 Apr 2005 17:32:19 GMT
X-Originating-IP: [64.4.56.200]
X-Originating-Email: [danieljlaird@hotmail.com]
X-Sender: danieljlaird@hotmail.com
From:	"Daniel Laird" <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:*: parse error
Date:	Thu, 07 Apr 2005 17:32:19 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 07 Apr 2005 17:32:20.0331 (UTC) FILETIME=[C05C6BB0:01C53B97]
Return-Path: <danieljlaird@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips

I am trying to build a linux kernel and gcc etc.

I have tried the following combo
gcc-3.4.3
glibc-2.3.4
binutils-2.15.96
linux-2.6.11.6

I egt everything built and then see the following error

mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:6: parse error

I can see that people have told someone else to edit the file vmlinux.lds 
manually
http://www.linux-mips.org/archives/linux-mips/2005-01/msg00059.html

and try again but in a complete build environment so does anyone know what 
causes the bug in the first place

Please help
Dan
