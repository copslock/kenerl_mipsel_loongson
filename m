Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Mar 2003 19:09:17 +0000 (GMT)
Received: from mailout11.sul.t-online.com ([IPv6:::ffff:194.25.134.85]:14282
	"EHLO mailout11.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225258AbTCETJR>; Wed, 5 Mar 2003 19:09:17 +0000
Received: from fwd03.sul.t-online.de 
	by mailout11.sul.t-online.com with smtp 
	id 18qbEx-0002ep-00; Wed, 05 Mar 2003 16:55:31 +0100
Received: from denx.de (320026445996-0001@[217.235.233.157]) by fmrl03.sul.t-online.com
	with esmtp id 18qbEr-0WxwWmC; Wed, 5 Mar 2003 16:55:25 +0100
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 14670427FF; Wed,  5 Mar 2003 16:55:24 +0100 (MET)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 7F3B8C6E0C; Wed,  5 Mar 2003 10:55:23 -0500 (EST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 1E4DEC5F63; Wed,  5 Mar 2003 16:55:23 +0100 (MET)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: glibc-2.2.1 problems for mips-linux 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Wed, 05 Mar 2003 16:40:36 +0100."
             <20030305164036.A10407@linux-mips.org> 
Date: Wed, 05 Mar 2003 16:55:18 +0100
Message-Id: <20030305155523.7F3B8C6E0C@atlas.denx.de>
X-Sender: 320026445996-0001@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20030305164036.A10407@linux-mips.org> you wrote:
> 
> Don't.  That's over two year old stuff and almost implies a guarantee to
> make you unhappy.  Recompiling libc requires fairly complex setup in
> particular when crosscompiling so the strong recommendation is to use
> the binaries of your favorite Linux distribution.

We are in the process of preparing a MIPS version of our free ELDK
(Embedded Linux Development Kit - see http://www.denx.de/re/ELDK.html)

However, I'm running into storage problems on our FTP server.
Anybody interested in mirroring this stuff?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Computers are not intelligent.  They only think they are.
