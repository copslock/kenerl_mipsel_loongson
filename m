Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2003 14:50:56 +0100 (BST)
Received: from mailout05.sul.t-online.com ([IPv6:::ffff:194.25.134.82]:43137
	"EHLO mailout05.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225209AbTHONuy>; Fri, 15 Aug 2003 14:50:54 +0100
Received: from fwd05.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 19neyP-0004C8-04; Fri, 15 Aug 2003 15:50:33 +0200
Received: from denx.de (bRXB6mZLgenTq3HG63oLUTou8aQWCGKvNggP6t3GjM8bF5nPrwJarv@[217.235.230.57]) by fmrl05.sul.t-online.com
	with esmtp id 19neyK-1foEj20; Fri, 15 Aug 2003 15:50:28 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 01D2342BAD; Fri, 15 Aug 2003 15:50:24 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id B55C0C59E4; Fri, 15 Aug 2003 15:50:18 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id AEB2BC59E3; Fri, 15 Aug 2003 15:50:18 +0200 (MEST)
To: =?UTF-8?B?5pyx5Yek?= <zhufeng@koretide.com.cn>
Cc: "Wilson Chan" <wilsonc@cellvision1.com.tw>,
	linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: gdbserver and gdb debugging stub for mips 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Fri, 15 Aug 2003 19:10:26 +0800."
             <MGEELAPMEFMLFBMDBLKLGEKGCEAA.zhufeng@koretide.com.cn> 
Date: Fri, 15 Aug 2003 15:50:13 +0200
Message-Id: <20030815135018.B55C0C59E4@atlas.denx.de>
X-Seen: false
X-ID: bRXB6mZLgenTq3HG63oLUTou8aQWCGKvNggP6t3GjM8bF5nPrwJarv@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <MGEELAPMEFMLFBMDBLKLGEKGCEAA.zhufeng@koretide.com.cn> you wrote:
> I'm also looking for them . If anybody who has , please tell me , thank you.

MIPS isn't MIPS. What exactly are you looking for?

We have gdb (cross and native) / gdbserver included with our ELDK for
MIPS - this is for 4Kc CPUs.

See section "3. Embedded Linux Development Kit" at
http://www.denx.de/twiki/bin/view/DULG/BoardSelect (select incaip).

Hope this helps.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"If you can, help others. If you can't, at least don't hurt  others."
- the Dalai Lama
