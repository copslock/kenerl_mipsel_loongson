Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2006 11:53:24 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:21516 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133413AbWGRKxP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Jul 2006 11:53:15 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 25B66F6652;
	Tue, 18 Jul 2006 12:53:11 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 26005-10; Tue, 18 Jul 2006 12:53:10 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id CBB5BF5A19;
	Tue, 18 Jul 2006 12:53:10 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.7/8.13.1) with ESMTP id k6IArGoP013958;
	Tue, 18 Jul 2006 12:53:16 +0200
Date:	Tue, 18 Jul 2006 11:53:13 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	qi tao <demon19840308@hotmail.com>
cc:	linux-mips@linux-mips.org
Subject: Re: cross compiling gcc for mips
In-Reply-To: <BAY122-F271C1ACCD1969B2F38611AAD630@phx.gbl>
Message-ID: <Pine.LNX.4.64N.0607181150160.31692@blysk.ds.pg.gda.pl>
References: <BAY122-F271C1ACCD1969B2F38611AAD630@phx.gbl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="328795856-18111934-1153219993=:31692"
X-Virus-Scanned: ClamAV 0.88.3/1600/Sat Jul 15 17:03:46 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--328795856-18111934-1153219993=:31692
Content-Type: TEXT/PLAIN; charset=gb2312
Content-Transfer-Encoding: 8BIT

On Tue, 18 Jul 2006, qi tao wrote:

> However when I do "make all-gcc" I get the following errors:
>  
> 
>  -c ../../gcc-4.1.1/gcc/crtstuff.c -DCRT_BEGIN \
>  -o crtbegin.o
> In file included from ../../gcc-4.1.1/gcc/crtstuff.c:68:
> .../../gcc-4.1.1/gcc/tsystem.h:90:19: error: stdio.h: 没有那个文件或目录
> .../../gcc-4.1.1/gcc/tsystem.h:93:23: error: sys/types.h: 没有那个文件或目录
> .../../gcc-4.1.1/gcc/tsystem.h:96:19: error: errno.h: 没有那个文件或目录
> .../../gcc-4.1.1/gcc/tsystem.h:103:20: error: string.h: 没有那个文件或目录
> .../../gcc-4.1.1/gcc/tsystem.h:104:20: error: stdlib.h: 没有那个文件或目录
> .../../gcc-4.1.1/gcc/tsystem.h:105:20: error: unistd.h: 没有那个文件或目录
> In file included from
> /opt/cross_src4.1.1/gcc-build/./gcc/include/syslimits.h:7,
>                 from /opt/cross_src4.1.1/gcc-build/./gcc/include/limits.h:11,
>                 from ../../gcc-4.1.1/gcc/tsystem.h:108,
>                 from ../../gcc-4.1.1/gcc/crtstuff.c:68:
> /opt/cross_src4.1.1/gcc-build/./gcc/include/limits.h:122:61: error: limits.h:
> 没 有那个文件或目录
> In file included from ../../gcc-4.1.1/gcc/crtstuff.c:68:
> .../../gcc-4.1.1/gcc/tsystem.h:111:18: error: time.h: 没有那个文件或目录
> make[1]: *** [crtbegin.o] 错误 1
> make[1]: Leaving directory `/opt/cross_src4.1.1/gcc-build/gcc'
> make: *** [all-gcc] 错误 2
> 
> what should i do??  thanks for your help ! thank you

 It would raise the probability of someone being able to provide you some 
help if you set your locale to English before reporting error messages.

  Maciej
--328795856-18111934-1153219993=:31692--
