Received:  by oss.sgi.com id <S42255AbQI2I4m>;
	Fri, 29 Sep 2000 01:56:42 -0700
Received: from [203.244.211.231] ([203.244.211.231]:14608 "EHLO
        swc.sec.samsung.co.kr") by oss.sgi.com with ESMTP id <S42190AbQI2I42>;
	Fri, 29 Sep 2000 01:56:28 -0700
Received: by swc with Internet Mail Service (5.5.2650.21)
	id <SW1HBK3K>; Fri, 29 Sep 2000 17:54:54 +0900
Message-ID: <F805AE5A9759D41198BA00A0C985B8FA36D175@swc>
From:   =?euc-kr?B?wK+xpMf2?= <khyoo@swc.sec.samsung.co.kr>
To:     linux-mips@oss.sgi.com
Subject: Help!! My Indy do not want to boot.
Date:   Fri, 29 Sep 2000 17:54:47 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I am building Linux system on my Indy IP22 with egcs 1.0.3a, binutil-2.8.1-
1.
Target kernel is fresh one, downloaded from CVS server (oss.sgi.com), 2.4.0-
test8-pre1.
The building process was very easy, calm.
But during the boot process my Indy displays following messages ...

	Exception: <vector=UTLB miss>
	Status register: 0x10004803 <CU0, IM7, IM4, IPL=???, MODE=KERNEL,
EXL, IE>
	Cause register: 0x8 <CE=0, EXC=RMISS>
	Exception PC: 0x8817d730, Exception RA: 0x8817ddfc
	[....... ]
	
	PANIC: Unexpected Exception
	[Press Reset or ENTER to restart]

Is there anyone who can help me and let me know why this happens?

PS: I do not use -N flag at file (arch/mips/Makefile LINKFLAGS).
