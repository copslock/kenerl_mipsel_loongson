Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2005 16:03:29 +0100 (BST)
Received: from mailout08.sul.t-online.com ([IPv6:::ffff:194.25.134.20]:47018
	"EHLO mailout08.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8226386AbVDVPDN>; Fri, 22 Apr 2005 16:03:13 +0100
Received: from fwd20.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1DOzgW-00083l-02; Fri, 22 Apr 2005 17:03:12 +0200
Received: from denx.de (Xp9x+2Zrre2YaWMUYIL3zkdpv0uy-GcNsq-0X+cQeTriInBdNGBogx@[84.150.74.71]) by fwd20.sul.t-online.de
	with esmtp id 1DOzgI-0WOTDc0; Fri, 22 Apr 2005 17:02:58 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id B6DEB42A2F; Fri, 22 Apr 2005 17:02:57 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 4C188C1510; Fri, 22 Apr 2005 17:02:57 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 497E813D94A; Fri, 22 Apr 2005 17:02:57 +0200 (MEST)
To:	martin.nichols@oxinst.co.uk
Cc:	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: Common Flash Memory Interface 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Fri, 22 Apr 2005 13:48:02 BST."
             <DEF431FFDB15C1488464F0E57D5506642AA6B7@MEDNT02> 
Date:	Fri, 22 Apr 2005 17:02:52 +0200
Message-Id: <20050422150257.4C188C1510@atlas.denx.de>
X-ID:	Xp9x+2Zrre2YaWMUYIL3zkdpv0uy-GcNsq-0X+cQeTriInBdNGBogx@t-dialin.net
X-TOI-MSGID: 220afcf9-6913-4072-ba92-cbfa5de7b3ba
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <DEF431FFDB15C1488464F0E57D5506642AA6B7@MEDNT02> you wrote:
> 
> I've arranged for a pair of Spansion S29GL256N 256Mbit flash roms to be
> connected to the
> Au1100 static bus. These devices are each 16bits wide and are connected to
> upper and lower
> halves of the 32 bit static bus at an address such that the boot code can
> reside in them.
> After boot, we want to use the remainder of the devices as flash disk using
> one of the wear
> leveling file systems. Each flash chip implements the Common Flash Memory
> Interface standard,

OK.

> but as they are arranged as 32 bits wide the devices are effectively
> interleaved.

I'd rather say thay are accesses in parallel.

> Can Linux support this arrangement?

Yes, of course. Such a configurationir more or less standard. The MTD
drivers will work just fine.

> Finally, this email is not confidential and is for all Linux-Mips
> addressees.

Then why do you attach such a silly disclaimer?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"...one of the main causes of the fall of the Roman Empire was  that,
lacking  zero,  they had no way to indicate successful termination of
their C programs."                                     - Robert Firth
