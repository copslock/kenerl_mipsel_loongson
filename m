Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2002 13:24:35 +0100 (CET)
Received: from p508B7FA8.dip.t-dialin.net ([80.139.127.168]:55965 "EHLO
	p508B7FA8.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225196AbSLJMYe>; Tue, 10 Dec 2002 13:24:34 +0100
Received: from c135.h203149222.is.net.tw ([IPv6:::ffff:203.149.222.135]:3779
	"EHLO ms.gv.com.tw") by ralf.linux-mips.org with ESMTP
	id <S868147AbSLJMYd>; Tue, 10 Dec 2002 13:24:33 +0100
Received: from jmt (IDENT:root@[172.16.1.11])
	by ms.gv.com.tw (8.11.2/8.11.2) with SMTP id gBACRoO20139;
	Tue, 10 Dec 2002 20:27:50 +0800
Message-ID: <00da01c2a047$2aa9f9e0$e20310ac@gv.com.tw>
From: "??" <kevin@gv.com.tw>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
References: <011c01c29c54$7aa64c60$e20310ac@gv.com.tw> <20021205132358.A5634@linux-mips.org>
Subject: enlarge KERNEL_STACK_SIZE
Date: Tue, 10 Dec 2002 20:25:03 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <kevin@gv.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevin@gv.com.tw
Precedence: bulk
X-list: linux-mips

dear all,

 how to enlarge KERNEL_STACK_SIZE?

 is it enough if i only change 
 the definition of KERNEL_STACK_SIZE in include/asm-mips/processor.h ?

 best regards,
