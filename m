Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2003 16:08:20 +0100 (BST)
Received: from mailout05.sul.t-online.com ([IPv6:::ffff:194.25.134.82]:18858
	"EHLO mailout05.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225209AbTHOPIS>; Fri, 15 Aug 2003 16:08:18 +0100
Received: from fwd02.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 19ngBW-0007zD-02; Fri, 15 Aug 2003 17:08:10 +0200
Received: from denx.de (ZedUEcZcZe+6HFGYzJWkOPdVw5i0QtoEPi3Znlo2P0Jq+lOYcsNfs7@[217.235.230.57]) by fmrl02.sul.t-online.com
	with esmtp id 19ngBP-0NfIy80; Fri, 15 Aug 2003 17:08:03 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id DF66542C81; Fri, 15 Aug 2003 17:08:01 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id C4DCAC59E4; Fri, 15 Aug 2003 17:07:55 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id C19ADC59E3; Fri, 15 Aug 2003 17:07:55 +0200 (MEST)
To: =?UTF-8?B?5pyx5Yek?= <zhufeng@koretide.com.cn>
Cc: "Wilson Chan" <wilsonc@cellvision1.com.tw>,
	linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: gdbserver and gdb debugging stub for mips 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Fri, 15 Aug 2003 22:49:21 +0800."
             <MGEELAPMEFMLFBMDBLKLIEKICEAA.zhufeng@koretide.com.cn> 
Date: Fri, 15 Aug 2003 17:07:50 +0200
Message-Id: <20030815150755.C4DCAC59E4@atlas.denx.de>
X-Seen: false
X-ID: ZedUEcZcZe+6HFGYzJWkOPdVw5i0QtoEPi3Znlo2P0Jq+lOYcsNfs7@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

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
