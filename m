Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Aug 2004 04:54:27 +0100 (BST)
Received: from m4.mail2000.com.tw ([IPv6:::ffff:210.200.181.213]:55055 "HELO
	m5.mail2000.com.tw") by linux-mips.org with SMTP
	id <S8224948AbUHVDyW> convert rfc822-to-8bit; Sun, 22 Aug 2004 04:54:22 +0100
Received: from 210.200.181.211
	by m5.mail2000.com.tw with Mail2000 ESMTP Server V3.20M(49043:0:AUTH_RELAY)
	(envelope-from <macleod@mail2000.com.tw>); Sun, 22 Aug 2004 11:54:11 +0800 (CST)
Received: By OpenMail Mailer;Sun, 22 Aug 2004 11:54:10 +0800 (CST)
From: "Macleod" <macleod@mail2000.com.tw>
Reply-To: macleod@mail2000.com.tw
Subject: System call select on R4600
Message-ID: <1093146850.1583.macleod@mail2000.com.tw>
To: linux-mips@linux-mips.org
Date: Sun, 22 Aug 2004 11:54:10 +0800 (CST)
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Return-Path: <macleod@mail2000.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macleod@mail2000.com.tw
Precedence: bulk
X-list: linux-mips


 My problem is "select" system call always return -1
 and errno is -4142, but sys_select has never been called.
 Think, it has some problem on handling system call. 
 Because if I change SYS(sys_select, 5) to 4 arguments,
 sys_select will be executed. 
 Thanks!

 Compiler: gcc-3.3.3
 Kernel: mips-linux-2.4.25/mips-linux-2.4.26
 Compile parameter:
 -Wno-inline \
 -Werror-implicit-function-declarations \
 -fno-PIC \
 -fno-common \
 -mno-abicalls \
 -mlong-calls \
 -march=r4600 \
 -mtune=r4600 \
 -G 0 \
 -Wa,--trap
