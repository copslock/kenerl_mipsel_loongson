Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 03:36:51 +0000 (GMT)
Received: from c251.h203149222.is.net.tw ([IPv6:::ffff:203.149.222.251]:57828
	"EHLO ms.gv.com.tw") by linux-mips.org with ESMTP
	id <S8225521AbSLTDgu>; Fri, 20 Dec 2002 03:36:50 +0000
Received: from jmt (IDENT:root@[172.16.1.11])
	by ms.gv.com.tw (8.11.2/8.11.2) with SMTP id gBK3dmH28415;
	Fri, 20 Dec 2002 11:39:48 +0800
Message-ID: <01da01c2a7d9$1de6c500$e20310ac@gv.com.tw>
From: "??" <kevin@gv.com.tw>
To: "Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Cc: <cms@gv.com.tw>
References: <011c01c29c54$7aa64c60$e20310ac@gv.com.tw> <20021205132358.A5634@linux-mips.org>
Subject: [help] exec_usermodehelper() then content of CURRENT is destroyed
Date: Fri, 20 Dec 2002 11:37:26 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <kevin@gv.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevin@gv.com.tw
Precedence: bulk
X-list: linux-mips

dear all,

1)in our 2.4.18 mips kernel , when we call  exec_usermodehelper() (in
kernel/kmod.c)
the content of CURRENT is destroyed during [page_fault handler loading pages
from storage-device to ram]

which kind of error may cause this problem?
any hint/idea?

2)btw, in some mips linux port,
[syscall] is done by [scall_o32.S]
when [handle_sys] is done,
it will return by [o32_ret_from_sys_call],
[o32_ret_from_sys_call] will do [reschedule] and [signal],
but the question is here it doesn't check whether [syscall] is from
User-space or Kernel-space
if we use [syscall] in kernel-space, and do [signal] after [syscall] return,
won't it cause problem? is this bug of linux code?

thanks alot in advanced!
