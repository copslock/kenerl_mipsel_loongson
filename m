Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2003 17:02:25 +0100 (BST)
Received: from mailout05.sul.t-online.com ([IPv6:::ffff:194.25.134.82]:59530
	"EHLO mailout05.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225229AbTGXQCW>; Thu, 24 Jul 2003 17:02:22 +0100
Received: from fwd07.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 19fiXp-0007lU-01; Thu, 24 Jul 2003 18:02:17 +0200
Received: from denx.de (bj63HwZaweFLkF6sHHpWhlIdQdIJHypYnh6mVp+ddTa7+we+T0RRsw@[217.235.209.91]) by fmrl07.sul.t-online.com
	with esmtp id 19fiXl-1JQwzI0; Thu, 24 Jul 2003 18:02:13 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 0D89442E1C; Thu, 24 Jul 2003 18:02:11 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 06AC4C602D; Thu, 24 Jul 2003 18:02:10 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 04BD9C602C; Thu, 24 Jul 2003 18:02:10 +0200 (MEST)
To: Joe George <joeg@clearcore.com>
Cc: David Kesselring <dkesselr@mmc.atmel.com>,
	linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: boot requirements 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Thu, 24 Jul 2003 09:50:31 MDT."
             <3F200047.2050506@clearcore.com> 
Date: Thu, 24 Jul 2003 18:02:04 +0200
Message-Id: <20030724160210.06AC4C602D@atlas.denx.de>
X-Seen: false
X-ID: bj63HwZaweFLkF6sHHpWhlIdQdIJHypYnh6mVp+ddTa7+we+T0RRsw@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <3F200047.2050506@clearcore.com> you wrote:
> 
> I found it easier to port Linux to my board than
> Yamon.  But I guess it probably depends a lot on
> the kind of port.

It depends on what you want or need to do. Capabilities like  booting
over  the  network  or  storing  configuration  parameters or command
sequences can be extremely useful features of a boot loader.

We use U-Boot on a couple of MIPS boards.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
One possible reason that things aren't going  according  to  plan  is
that there never was a plan in the first place.
