Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fASJ6D800869
	for linux-mips-outgoing; Wed, 28 Nov 2001 11:06:13 -0800
Received: from atlrel9.hp.com (atlrel9.hp.com [156.153.255.214])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fASJ6Ao00866
	for <linux-mips@oss.sgi.com>; Wed, 28 Nov 2001 11:06:10 -0800
Received: from xatlrelay2.atl.hp.com (xatlrelay2.atl.hp.com [15.45.89.191])
	by atlrel9.hp.com (Postfix) with ESMTP id B65611F66D
	for <linux-mips@oss.sgi.com>; Wed, 28 Nov 2001 13:06:03 -0500 (EST)
Received: from xatlbh1.atl.hp.com (xatlbh1.atl.hp.com [15.45.89.186])
	by xatlrelay2.atl.hp.com (Postfix) with ESMTP id 189751F51A
	for <linux-mips@oss.sgi.com>; Wed, 28 Nov 2001 13:06:03 -0500 (EST)
Received: by xatlbh1.atl.hp.com with Internet Mail Service (5.5.2653.19)
	id <XLLP3MT1>; Wed, 28 Nov 2001 13:06:02 -0500
Message-ID: <CBD6266EA291D5118144009027AA63353F9275@xboi05.boi.hp.com>
From: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
To: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: RedHat 7.1 cross toolchain kernel build problem
Date: Wed, 28 Nov 2001 13:06:00 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Does anyone have any ideas why the i386->mipsel cross toolchain at
oss.sgi.com:/pub/linux/redhat/7.1/RPMS/i386/toolchain* fails to build
vgacon.o in the kernel's drivers/video directory?


I get the following errors from the assembler:
{standard input}:4683: Error: expression too complex
{standard input}:4683: Fatal error: internal Error, line 1980,
../../tools-20011020/gas/config/tc-mips.c
make[3]: *** [vgacon.o] Error 1

Apparently the compiler has generated assembly which the assembler cannot
handle.
I compiled to a .s assembly file and line 4683 was simply 'sb $6,$5($3)'.


Thanks,

Roger
