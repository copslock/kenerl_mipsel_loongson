Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2005 01:24:46 +0100 (BST)
Received: from mailout04.sul.t-online.com ([IPv6:::ffff:194.25.134.18]:60617
	"EHLO mailout04.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225526AbVFYAYa>; Sat, 25 Jun 2005 01:24:30 +0100
Received: from fwd24.aul.t-online.de 
	by mailout04.sul.t-online.com with smtp 
	id 1DlySL-0000GN-00; Sat, 25 Jun 2005 02:23:33 +0200
Received: from denx.de (TiZ-YyZlgepyhWtNtARGJLOMHBJojPcpeh6b+UvaE4Es2MUYXpHPEJ@[84.150.124.240]) by fwd24.sul.t-online.de
	with esmtp id 1DlySJ-0lvSUa0; Sat, 25 Jun 2005 02:23:31 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 3E7E842C2A; Sat, 25 Jun 2005 02:23:30 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id C0A7FC1510; Sat, 25 Jun 2005 02:23:29 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id BFB4713D2EC; Sat, 25 Jun 2005 02:23:29 +0200 (MEST)
To:	rolf liu <rolfliu@gmail.com>
Cc:	Andy Isaacson <adi@hexapodia.org>,
	Prashant Viswanathan <vprashant@echelon.com>,
	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: glibc based toolchain for mips 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Fri, 24 Jun 2005 15:47:30 PDT."
             <2db32b7205062415471d0fe4c0@mail.gmail.com> 
Date:	Sat, 25 Jun 2005 02:23:24 +0200
Message-Id: <20050625002329.C0A7FC1510@atlas.denx.de>
X-ID:	TiZ-YyZlgepyhWtNtARGJLOMHBJojPcpeh6b+UvaE4Es2MUYXpHPEJ@t-dialin.net
X-TOI-MSGID: bb196170-a317-4656-ac3b-649ad0517a66
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <2db32b7205062415471d0fe4c0@mail.gmail.com> you wrote:
> That one Debian provides is for big endian. Is there one tool chain
> for mips little endian and also gcc 3.*.* ?

The mips_4KCle packages in the ELDK are for mips little endian; we
use 3.3.3; see http://www.denx.de/ELDK.html

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Einstein argued that there must be simplified explanations of nature,
because God is not capricious or arbitrary. No  such  faith  comforts
the software engineer.                             - Fred Brooks, Jr.
