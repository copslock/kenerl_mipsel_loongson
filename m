Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 21:16:20 +0100 (BST)
Received: from mailout03.sul.t-online.com ([IPv6:::ffff:194.25.134.81]:52663
	"EHLO mailout03.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225624AbTJIUPs>; Thu, 9 Oct 2003 21:15:48 +0100
Received: from fwd09.aul.t-online.de 
	by mailout03.sul.t-online.com with smtp 
	id 1A7fsd-0003LD-07; Thu, 09 Oct 2003 20:51:19 +0200
Received: from denx.de (rS-VOmZY8eTVJ5Ucz4b55uGdKTsnbwdyxHNbI2jA2pHZ6MDf33VKEf@[217.235.220.36]) by fmrl09.sul.t-online.com
	with esmtp id 1A7fsT-02TiL20; Thu, 9 Oct 2003 20:51:09 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 93E324314F; Thu,  9 Oct 2003 20:51:07 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 6E6FFC59E4; Thu,  9 Oct 2003 20:51:04 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 6B60AC545E; Thu,  9 Oct 2003 20:51:04 +0200 (MEST)
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: YAMON Source code modification 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Thu, 09 Oct 2003 11:01:54 PDT."
             <20031009110154.B17781@mvista.com> 
Date: Thu, 09 Oct 2003 20:50:59 +0200
Message-Id: <20031009185104.6E6FFC59E4@atlas.denx.de>
X-Seen: false
X-ID: rS-VOmZY8eTVJ5Ucz4b55uGdKTsnbwdyxHNbI2jA2pHZ6MDf33VKEf@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20031009110154.B17781@mvista.com> you wrote:
>
> Actually is YAMON code freely available?  Can someone from MIPS confirm
> that and perhaps point to the downloading place?  

It is available for free, but under a special license  that  prevents
you  from  using  it  for any hardware that is not a MIPS "Authorized
Product". See http://www.mips.com/LicenseMapper/Yamon_license


An alternative is to use  U-Boot,  the  universal  boot  loader  that
covers not only MIPS but also PowerPC, ARM, and even x86 systems. See
http://sourceforge.net/projects/u-boot

U-Boot is strictly GPL.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The ultimate barrier is one's viewpoint.
                        - Terry Pratchett, _The Dark Side of the Sun_
