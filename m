Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2006 08:12:48 +0100 (BST)
Received: from bay0-omc1-s3.bay0.hotmail.com ([65.54.246.75]:14502 "EHLO
	bay0-omc1-s3.bay0.hotmail.com") by ftp.linux-mips.org with ESMTP
	id S8133349AbWGRHMi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Jul 2006 08:12:38 +0100
Received: from hotmail.com ([207.46.10.235]) by bay0-omc1-s3.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 18 Jul 2006 00:12:30 -0700
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Tue, 18 Jul 2006 00:12:30 -0700
Message-ID: <BAY122-F271C1ACCD1969B2F38611AAD630@phx.gbl>
Received: from 207.46.10.254 by by122fd.bay122.hotmail.msn.com with HTTP;
	Tue, 18 Jul 2006 07:12:29 GMT
X-Originating-IP: [211.144.27.155]
X-Originating-Email: [demon19840308@hotmail.com]
X-Sender: demon19840308@hotmail.com
From:	"qi tao" <demon19840308@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: cross compiling gcc for mips
Date:	Tue, 18 Jul 2006 15:12:29 +0800
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
X-OriginalArrivalTime: 18 Jul 2006 07:12:30.0453 (UTC) FILETIME=[8860A250:01C6AA39]
Return-Path: <demon19840308@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: demon19840308@hotmail.com
Precedence: bulk
X-list: linux-mips

hello:
I am building a toolchain for mips platform. I am using

binutils-2.17
gcc-4.1.1
glibc-2.4
linux-2.6.17.4
linux-headers-2.6.17.4

First I built binutils and now I was setting up the bootstrap compiler.
However when I do "make all-gcc" I get the following errors:
  

  -c ../../gcc-4.1.1/gcc/crtstuff.c -DCRT_BEGIN \
  -o crtbegin.o
In file included from ../../gcc-4.1.1/gcc/crtstuff.c:68:
.../../gcc-4.1.1/gcc/tsystem.h:90:19: error: stdio.h: 没有那个文件或目录
.../../gcc-4.1.1/gcc/tsystem.h:93:23: error: sys/types.h: 没有那个文件或目录
.../../gcc-4.1.1/gcc/tsystem.h:96:19: error: errno.h: 没有那个文件或目录
.../../gcc-4.1.1/gcc/tsystem.h:103:20: error: string.h: 没有那个文件或目录
.../../gcc-4.1.1/gcc/tsystem.h:104:20: error: stdlib.h: 没有那个文件或目录
.../../gcc-4.1.1/gcc/tsystem.h:105:20: error: unistd.h: 没有那个文件或目录
In file included from 
/opt/cross_src4.1.1/gcc-build/./gcc/include/syslimits.h:7,
                 from 
/opt/cross_src4.1.1/gcc-build/./gcc/include/limits.h:11,
                 from ../../gcc-4.1.1/gcc/tsystem.h:108,
                 from ../../gcc-4.1.1/gcc/crtstuff.c:68:
/opt/cross_src4.1.1/gcc-build/./gcc/include/limits.h:122:61: error: 
limits.h: 没 有那个文件或目录
In file included from ../../gcc-4.1.1/gcc/crtstuff.c:68:
.../../gcc-4.1.1/gcc/tsystem.h:111:18: error: time.h: 没有那个文件或目录
make[1]: *** [crtbegin.o] 错误 1
make[1]: Leaving directory `/opt/cross_src4.1.1/gcc-build/gcc'
make: *** [all-gcc] 错误 2
 
what should i do??  thanks for your help ! thank you

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
