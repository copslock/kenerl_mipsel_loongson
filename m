Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 04:40:13 +0200 (CEST)
Received: from [220.76.242.187] ([220.76.242.187]:62415 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S8133428AbWEZCkG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 May 2006 04:40:06 +0200
Received: from mrv ([192.168.11.157])
	by localhost.localdomain (8.12.8/8.12.8) with SMTP id k4Q2fqEE031736;
	Fri, 26 May 2006 11:41:55 +0900
Message-ID: <002601c6806d$b09fc890$9d0ba8c0@mrv>
From:	"Roman Mashak" <mrv@corecom.co.kr>
To:	"Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>
Cc:	<linux-mips@linux-mips.org>
References: <001101c6805e$4c4f62b0$9d0ba8c0@mrv> <20060526103840.79fe5ec5.yoichi_yuasa@tripeaks.co.jp>
Subject: Re: booting with NFS root
Date:	Fri, 26 May 2006 11:40:01 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
FL-Build: Fidolook 2002 (SL) 6.0.2800.86 - 14/6/2003 22:16:25
Return-Path: <mrv@corecom.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@corecom.co.kr
Precedence: bulk
X-list: linux-mips

Hello, Yoichi

and thanks for reply.

 YY> <snip>
 ??>> Freeing unused kernel memory: 104k freed
 ??>> do_cpu invoked from kernel context! in traps.c::do_cpu, line 676:

 YY> This error is coprocessor unusable exception.
May this be caused by hardware error/bug ?

 ??>> $0 : 00000000 9004a000 2ab03fe0 2ab03fe0 2ab01560 00000000 00000ae0
 ??>> 00000ae0 $8 : 00000020 2ab01fe0 2ab01520 00001000 00000019 00000080
 ??>> 811d7b18 00000c62 $16: 2ab010c0 811d7c58 87f8cfe0 00000003 00000080
 ??>> 2ab01520 87f841a0 00000001 $24: 00000000 00000080
 ??>> 811d6000 811d7ba0 2aaa8000 8015f414 Hi : 00000000 Lo : 00000000 epc
 ??>> : 80256e14    Not tainted

 YY> The exception program counter is 0x80256e14 .
 YY> You can check instructions(0x80256e14 and before) in your kernel
 YY> object.
I ran 'objdump -d /tftpboot/vmlinux | grep -B7 ^80256e14' and got the 
following:

80256df8:       732f6330        0x732f6330
80256dfc:       64347000        daddiu  s4,at,28672
80256e00:       63636973        daddi   v1,k1,26995
80256e04:       732f6330        0x732f6330
80256e08:       64357000        daddiu  s5,at,28672
80256e0c:       63636973        daddi   v1,k1,26995
80256e10:       732f6330        0x732f6330
80256e14:       64367000        daddiu  s6,at,28672

But I'm not good in MIPS assembling. Does this give you some clue?

 ??>> Status: 9004a003
 ??>> Cause : 1000002c
 ??>> PrId  : 000034c1
 ??>> Process init (pid: 1, stackpage=811d6000)
 ??>> Stack:    8015f8a8 8015f9a8 87f71180 8012b2fc 00000000 80135330

With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
