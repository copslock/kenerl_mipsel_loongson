Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jul 2005 16:41:31 +0100 (BST)
Received: from mailout03.sul.t-online.com ([IPv6:::ffff:194.25.134.81]:53900
	"EHLO mailout03.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8226095AbVGBPlP>; Sat, 2 Jul 2005 16:41:15 +0100
Received: from fwd23.aul.t-online.de 
	by mailout03.sul.t-online.com with smtp 
	id 1Dok7E-0000Ie-03; Sat, 02 Jul 2005 17:41:12 +0200
Received: from denx.de (VmKhU8ZdoehGzbfi5dIs+YOgFa6QQN-SE7Edrfjyk0P42GPJCXQEZJ@[84.150.110.36]) by fwd23.sul.t-online.de
	with esmtp id 1Dok6x-0wDy3U0; Sat, 2 Jul 2005 17:40:55 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 5EE49428A7; Sat,  2 Jul 2005 17:40:54 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id A2728353A36;
	Sat,  2 Jul 2005 17:39:45 +0200 (MEST)
To:	rolf liu <rolfliu@gmail.com>
Cc:	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: glibc based toolchain for mips 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Fri, 01 Jul 2005 16:09:26 PDT."
             <2db32b7205070116091240fcf4@mail.gmail.com> 
Date:	Sat, 02 Jul 2005 17:39:45 +0200
Message-Id: <20050702153945.A2728353A36@atlas.denx.de>
X-ID:	VmKhU8ZdoehGzbfi5dIs+YOgFa6QQN-SE7Edrfjyk0P42GPJCXQEZJ@t-dialin.net
X-TOI-MSGID: bf739ed4-0012-4d2a-8f97-a5a66c633c7c
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <2db32b7205070116091240fcf4@mail.gmail.com> you wrote:
> 
> The files in /opt/eldk/mips_4KCle are in little endian mips, for sure.=20
> What I want is a cross-development tools for i386-to-mipsel, including
> the corss gcc, binutils, other libs. I couldn't find such tools :(

Please read the documentation. You  will  find  these  tools  in  the
/opt/eldk/bin resp. /opt/eldk/usr/bin directories.

The README.html (or the DULG at http://www.denx.de/twiki/bin/view/DULG/Manual)
documents in detail what needs to be done to install and use the tools.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The sight of death frightens them [Earthers].
	-- Kras the Klingon, "Friday's Child", stardate 3497.2
