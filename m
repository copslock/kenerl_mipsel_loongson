Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jan 2005 14:23:31 +0000 (GMT)
Received: from mailout10.sul.t-online.com ([IPv6:::ffff:194.25.134.21]:4804
	"EHLO mailout10.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225213AbVAEOX0>; Wed, 5 Jan 2005 14:23:26 +0000
Received: from fwd08.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1CmC4A-0007dx-00; Wed, 05 Jan 2005 15:23:14 +0100
Received: from denx.de (bKDQIoZEQe524SwNqSZYLTEvG1koL+4YdvpIxyQtWKeb2kHOMVZjwr@[62.158.193.240]) by fmrl08.sul.t-online.com
	with esmtp id 1CmC3z-22d1M00; Wed, 5 Jan 2005 15:23:03 +0100
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id B745B42F52; Wed,  5 Jan 2005 15:22:57 +0100 (MET)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 12A72C108D; Wed,  5 Jan 2005 15:22:55 +0100 (MET)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 1040813D6DB; Wed,  5 Jan 2005 15:22:55 +0100 (MET)
To: ichinoh@mb.neweb.ne.jp
Cc: linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: problem of cross compile 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Wed, 05 Jan 2005 16:56:20 +0900."
             <1104911780.5055@157.120.127.3.DIONWebMail> 
Date: Wed, 05 Jan 2005 15:22:50 +0100
Message-Id: <20050105142255.12A72C108D@atlas.denx.de>
X-ID: bKDQIoZEQe524SwNqSZYLTEvG1koL+4YdvpIxyQtWKeb2kHOMVZjwr@t-dialin.net
X-TOI-MSGID: b2c43d7e-12cc-4fac-81b0-82846376a544
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <1104911780.5055@157.120.127.3.DIONWebMail> you wrote:
> 
> I have a question about cross compile(MIPS on REDHAT9).
...
> "test:ELF 32-bit LSB executable, no machine, version 1(SYSV), for GNU/Linux 2.4.17, dynamically linked (uses shared libs), stripped"

Looks like your cross toolchain is seriously broken.

Try using the ELDK (see
http://www.denx.de/twiki/bin/view/DULG/ELDKAvailability?stickboard=incaip)

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Never call a man a fool.  Borrow from him.
