Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 May 2003 14:26:55 +0100 (BST)
Received: from [IPv6:::ffff:202.125.80.34] ([IPv6:::ffff:202.125.80.34]:28166
	"EHLO mail.esn.activedirectory") by linux-mips.org with ESMTP
	id <S8225192AbTEZN0w>; Mon, 26 May 2003 14:26:52 +0100
Received: by mail.esn.activedirectory with Internet Mail Service (5.5.2650.10)
	id <LAZ0NQT5>; Mon, 26 May 2003 18:56:16 +0530
Message-ID: <AF572D578398634881E52418B2892567122B4C@mail.esn.activedirectory>
From: JinuM <jinum@esntechnologies.co.in>
To: linux-mips@linux-mips.org
Subject: PCI Conf Space in application mode
Date: Mon, 26 May 2003 18:56:13 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.10)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <jinum@esntechnologies.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jinum@esntechnologies.co.in
Precedence: bulk
X-list: linux-mips

Hi!

I am looking at an application to print PCI Configuration space on MIPS
platform in user mode.

On my x86 system i do that using iopl() call n then accessing PCI Conf space
through ADDRESS port(0xCF8) and DATA port(0xCFC). Here i have no problems
accessing the IO ports.

But i believe its not the same in MIPS architecture. How can i read n write
into some IO port(memory mapped in MIPS) on MIPS platform. Can i only access
these ports in driver mode?

The x86 code does compile with a mips cross compiler and i am able to
execute it. But the output that i see is some junk getting printed on one
line. 

Thanx in advance.

Regards,
Jinu
