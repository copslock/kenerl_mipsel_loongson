Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2005 18:57:13 +0000 (GMT)
Received: from 67-129-173-8.dia.cust.qwest.net ([IPv6:::ffff:67.129.173.8]:37913
	"EHLO alfalfa.fortresstech.com") by linux-mips.org with ESMTP
	id <S8227821AbVCWS44> convert rfc822-to-8bit; Wed, 23 Mar 2005 18:56:56 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: defkeymap.c Compile Warnings . . .
Date:	Wed, 23 Mar 2005 13:56:50 -0500
Message-ID: <54AC63178735ED46BAC5F5E668A9F224046AAC@alfalfa.fortresstech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: defkeymap.c Compile Warnings . . .
Thread-Index: AcUv2hGp4A8rhlYBSRyM+bTUV7W0Ig==
From:	"Dennis Daniels" <ddaniels@fortresstech.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <ddaniels@fortresstech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaniels@fortresstech.com
Precedence: bulk
X-list: linux-mips

I'm having a compile problem with the generated file defkeymap.c for Linux 64-bit MIPS on the BCM1250, and was wondering if anyone has seen or heard of it. The structures in defkeymap.c are all coming out 2x what they should be . . .

Thanks ahead of time,
Dennis

Target:              BCM1250/64-bit
Linux kernel:      2.4.20
gcc:                  3.3.1

The warnings I'm getting are:

mips64_fp_be-gcc -D__KERNEL__ -I/ws/ddaniels/projects/ddaniels-01/Arch_2/Patriot/SQA/Main/Applications/thirdparty/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fnostrict-aliasing -fno-common -fomit-frame-pointer -I /ws
/ddaniels/projects/ddaniels-01/Arch_2/Patriot/SQA/Main/Applications/thirdparty/kernel/linux/include/asm/gcc -mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pip
e -mtune=sb1 -mips64   -nostdinc -iwithprefix include -DKBUILD_BASENAME=defkeymap  -c -o defkeymap.o defkeymap.c
defkeymap.c:25: warning: excess elements in array initializer
defkeymap.c:25: warning: (near initialization for `plain_map')
defkeymap.c:25: warning: excess elements in array initializer
defkeymap.c:25: warning: (near initialization for `plain_map')
:
:
defkeymap.c:250: warning: excess elements in array initializer
defkeymap.c:250: warning: (near initialization for `ctrl_alt_map')
defkeymap.c:250: warning: excess elements in array initializer
defkeymap.c:250: warning: (near initialization for `ctrl_alt_map'

and the structure looks like:
u_short plain_map[NR_KEYS] = {
            0xf200,  0xf01b,  0xf031,  0xf032,  0xf033,  0xf034,  0xf035,  0xf036,
            0xf037,  0xf038,  0xf039,  0xf030,  0xf02d,  0xf03d,  0xf07f,   0xf009,
            0xfb71,  0xfb77,  0xfb65,  0xfb72,  0xfb74,  0xfb79,  0xfb75,  0xfb69,
            0xfb6f,  0xfb70,  0xf05b,  0xf05d,  0xf201,  0xf702,  0xfb61,  0xfb73,
            0xfb64,  0xfb66,  0xfb67,  0xfb68,  0xfb6a,  0xfb6b,  0xfb6c,  0xf03b,
            0xf027,  0xf060,  0xf700,  0xf05c,  0xfb7a,  0xfb78,  0xfb63,  0xfb76,
            0xfb62,  0xfb6e,  0xfb6d,  0xf02c,  0xf02e,  0xf02f,  0xf700,  0xf30c,
            0xf703,  0xf020,  0xf207,  0xf100,  0xf101,  0xf102,  0xf103,  0xf104,
            0xf105,  0xf106,  0xf107,  0xf108,  0xf109,  0xf208,  0xf209,  0xf307,
            0xf308,  0xf309,  0xf30b,  0xf304,  0xf305,  0xf306,  0xf30a,  0xf301,
            0xf302,  0xf303,  0xf300,  0xf310,  0xf206,  0xf200,  0xf03c,  0xf10a,
            0xf10b,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf30e,  0xf702,  0xf30d,  0xf01c,  0xf701,  0xf205,  0xf114,  0xf603,
            0xf118,  0xf601,  0xf602,  0xf117,  0xf600,  0xf119,  0xf115,  0xf116,
            0xf11a,  0xf10c,  0xf10d,  0xf11b,  0xf11c,  0xf110,  0xf311,  0xf11d,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
            0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,  0xf200,
};  
