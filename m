Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Mar 2004 16:42:10 +0100 (BST)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:2242 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225204AbUC1PmJ>; Sun, 28 Mar 2004 16:42:09 +0100
Received: from 204.127.197.114 ([204.127.197.114])
          by comcast.net (rwcrmhc12) with SMTP
          id <2004032815415801400793mve>; Sun, 28 Mar 2004 15:41:58 +0000
Received: from [24.61.90.61] by 204.127.197.114;
	Sun, 28 Mar 2004 15:41:57 +0000
From: larryhl@comcast.net
To: linux-mips@linux-mips.org
Subject: gcc 3.4 and kernel 2.6 for 64bit on sb1250
Date: Sun, 28 Mar 2004 15:41:57 +0000
Message-Id: <032820041541.18245.4066F2450005255E000047452200750330FF9397868D8D9E@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Mar 22 2004)
X-Authenticated-Sender: bGFycnlobEBjb21jYXN0Lm5ldA==
Return-Path: <larryhl@comcast.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: larryhl@comcast.net
Precedence: bulk
X-list: linux-mips

Hi,

I am wondering where gcc 3.4 cross-compiler for mips with little-endian hosted on red-hat/intel could be downloaded. I tried to build them by myself,
but the compilation always failed because of pthread.h missing.

Also, did anybody successfully use kernel 2.6 with 64bit/smp on sb1250? 

Thanks.

Larry.
