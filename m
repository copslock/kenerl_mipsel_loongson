Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2005 01:30:21 +0100 (BST)
Received: from mailout08.sul.t-online.com ([IPv6:::ffff:194.25.134.20]:61656
	"EHLO mailout08.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8226064AbVDAAaG>; Fri, 1 Apr 2005 01:30:06 +0100
Received: from fwd34.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1DHA32-0002dK-01; Fri, 01 Apr 2005 02:30:04 +0200
Received: from denx.de (rIHcdiZFQeT1kfTcfYpqOApzGeaO7YV5W-QWJmFNr7t3ewELuUDyQZ@[84.150.111.124]) by fwd34.sul.t-online.de
	with esmtp id 1DHA2z-1M5OEa0; Fri, 1 Apr 2005 02:30:01 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 62E3D42CBC; Fri,  1 Apr 2005 02:30:00 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 282DDC108D; Fri,  1 Apr 2005 02:30:00 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 26E2113D94A; Fri,  1 Apr 2005 02:30:00 +0200 (MEST)
To:	dfsd df <tomcs163@yahoo.com.cn>
Cc:	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: Some questions about kernel tailoring 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Thu, 31 Mar 2005 17:41:15 +0800."
             <20050331094116.66254.qmail@web15805.mail.cnb.yahoo.com> 
Date:	Fri, 01 Apr 2005 02:29:55 +0200
Message-Id: <20050401003000.282DDC108D@atlas.denx.de>
X-ID:	rIHcdiZFQeT1kfTcfYpqOApzGeaO7YV5W-QWJmFNr7t3ewELuUDyQZ@t-dialin.net
X-TOI-MSGID: eba8126e-db7e-484c-b9cb-17350d24cfbf
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20050331094116.66254.qmail@web15805.mail.cnb.yahoo.com> you wrote:
>  
> So I want to write a very simple bootloader and make a self-decompressed kernel.

Don't re-invent the wheel. Consider using (porting) U-Boot.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A supercomputer is a machine that runs an endless loop in 2 seconds.
