Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Mar 2003 21:09:20 +0000 (GMT)
Received: from mail2.efi.com ([IPv6:::ffff:192.68.228.89]:57102 "HELO
	fcexgw02.efi.internal") by linux-mips.org with SMTP
	id <S8225073AbTCJVJU>; Mon, 10 Mar 2003 21:09:20 +0000
Received: from 10.3.12.13 by fcexgw02.efi.internal (InterScan E-Mail VirusWall NT); Mon, 10 Mar 2003 13:09:12 -0800
Received: by fcexbh02.efi.com with Internet Mail Service (5.5.2656.59)
	id <DRDG30L1>; Mon, 10 Mar 2003 13:09:12 -0800
Message-ID: <D9F6B9DABA4CAE4B92850252C52383AB07968235@ex-eng-corp.efi.com>
From: Ranjan Parthasarathy <ranjanp@efi.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: syscal handler query
Date: Mon, 10 Mar 2003 13:09:01 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <ranjanp@efi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ranjanp@efi.com
Precedence: bulk
X-list: linux-mips

The syscall handler code does an STI at the very begining in handle_sys. Can
someone explain why that is needed. I am trying to debug a problem in my
mips kernel with compressed ramdisks and I was using something like

cli();
gunzip();
sti();

in the compressed ramdisk code and I could still see the timer interrupts
being raised while gunzip was uncompressing. I suspected the STI in the
syscall handler code. Removing the STI fixes the problem. The
RESTORE_SP_AND_RET will reset the interrupts so I do not see why the STI is
needed, but I am wary of any potential disastrous side effects of removing
the STI.

The code is as follows - from arch/mips/kernel/scall_o32.S

NESTED(handle_sys,PT_SIZE,sp)
	.set 	noat
	SAVE_SOME
	STI
            *
            *

Any help would be appreciated.

Thanks

Ranjan
