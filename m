Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jul 2005 00:02:29 +0100 (BST)
Received: from mailout06.sul.t-online.com ([IPv6:::ffff:194.25.134.19]:43958
	"EHLO mailout06.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8226180AbVGAXCN>; Sat, 2 Jul 2005 00:02:13 +0100
Received: from fwd35.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1DoUWL-00009d-00; Sat, 02 Jul 2005 01:02:05 +0200
Received: from denx.de (VO5RE8ZSZezD9EyDSqFanWjsog4OOVsfaKX-aWLhfy+UrJcWjzP9Qw@[84.150.71.68]) by fwd35.sul.t-online.de
	with esmtp id 1DoUWA-22Pp0S0; Sat, 2 Jul 2005 01:01:54 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 454AC42D8D; Sat,  2 Jul 2005 01:01:52 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id D09EC353A36;
	Sat,  2 Jul 2005 01:00:56 +0200 (MEST)
To:	rolf liu <rolfliu@gmail.com>
Cc:	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: glibc based toolchain for mips 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Thu, 30 Jun 2005 15:58:46 PDT."
             <2db32b72050630155831582cd7@mail.gmail.com> 
Date:	Sat, 02 Jul 2005 01:00:56 +0200
Message-Id: <20050701230056.D09EC353A36@atlas.denx.de>
X-ID:	VO5RE8ZSZezD9EyDSqFanWjsog4OOVsfaKX-aWLhfy+UrJcWjzP9Qw@t-dialin.net
X-TOI-MSGID: d0c3744e-dc61-441e-9b9e-74a8ea5ec7ea
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <2db32b72050630155831582cd7@mail.gmail.com> you wrote:
> 
> I download the package. after installation,  the 4KCle is still
> linking to the mips-linux-, which is big-endian.

Please explain exactly what you did.

We have kernel, all libraries and apps running in  this  environment,
and if I check it looks very much like little endinan, for example:

$ file /opt/eldk/mips_4KCle/bin/bash
/opt/eldk/3.1.1/mips_4KCle/bin/bash: ELF 32-bit LSB executable, MIPS, version 1 (SYSV), for GNU/Linux 2.4.0, dynamically linked (uses shared libs), stripped

versus

$ file /opt/eldk/mips_4KC/bin/bash
 /opt/eldk/3.1.1/mips_4KC/bin/bash: ELF 32-bit MSB executable, MIPS, version 1 (SYSV), for GNU/Linux 2.4.0, dynamically linked (uses shared libs), stripped


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
CONSUMER NOTICE:  Because  of  the  "Uncertainty  Principle,"  It  Is
Impossible  for  the  Consumer  to  Find  Out  at  the Same Time Both
Precisely Where This Product Is and How Fast It Is Moving.
