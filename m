Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2003 02:16:58 +0100 (BST)
Received: from [IPv6:::ffff:210.22.155.234] ([IPv6:::ffff:210.22.155.234]:25775
	"EHLO mail.koretide.com.cn") by linux-mips.org with ESMTP
	id <S8225258AbTHRBQq> convert rfc822-to-8bit; Mon, 18 Aug 2003 02:16:46 +0100
Received: from zhufeng ([192.168.1.12])
	(authenticated)
	by mail.koretide.com.cn (8.11.6/8.11.6) with ESMTP id h7I1E9c11662;
	Mon, 18 Aug 2003 09:14:12 +0800
From: "=?utf-8?Q?=E6=9C=B1=E5=87=A4\=28zhufeng\=29?=" 
	<zhufeng@koretide.com.cn>
To: <wd@denx.de>
Cc: "Wilson Chan" <wilsonc@cellvision1.com.tw>,
	<linux-mips@linux-mips.org>
Subject: RE: gdbserver and gdb debugging stub for mips 
Date: Mon, 18 Aug 2003 09:16:06 +0800
Message-ID: <MGEELAPMEFMLFBMDBLKLGEKOCEAA.zhufeng@koretide.com.cn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Importance: Normal
In-Reply-To: <20030815150755.C4DCAC59E4@atlas.denx.de>
Return-Path: <zhufeng@koretide.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhufeng@koretide.com.cn
Precedence: bulk
X-list: linux-mips

when I build my mips program using gcc with -O0 , it is ok, while using -o2, there come the following questions.
lingking,,,

relocation truncated to fit: R_MIPS_GPREL16  __global_ctor_start
relocation truncated to fit: R_MIPS_GPREL16 __global_ctor_end
relocation truncated to fit: R_MIPS_GPREL16 _recycle_start 

and so on.

Has anybody encounter such questions?



-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]
Sent: 2003年8月15日 23:08
To: Öì·ï
Cc: Wilson Chan; linux-mips@linux-mips.org
Subject: Re: gdbserver and gdb debugging stub for mips 


In message <MGEELAPMEFMLFBMDBLKLIEKICEAA.zhufeng@koretide.com.cn> you wrote:
>  what do you mean by "MIPS is NOT MIPS"? Does it mean there are too many mips boards?

big endian, little endian, 32 bit, 64 bit, ...

It means that there are several  different  configurations,  and  you
must use tools to match your configuration.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Newer disks don't have a rectangular layout anymore,  but  Unix  (and
SunOS) still assumes this.     - Peter Koch in <koch.779356598@rhein>
