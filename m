Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Sep 2004 00:22:52 +0100 (BST)
Received: from mail-out.m-online.net ([IPv6:::ffff:212.18.0.9]:49323 "EHLO
	mail-out.m-online.net") by linux-mips.org with ESMTP
	id <S8225280AbUIPXWs>; Fri, 17 Sep 2004 00:22:48 +0100
Received: from mail.m-online.net (svr14.m-online.net [192.168.3.144])
	by svr8.m-online.net (Postfix) with ESMTP id 5A5266A109;
	Fri, 17 Sep 2004 01:22:46 +0200 (CEST)
Received: from denx.de (host-82-135-33-74.customer.m-online.net [82.135.33.74])
	by mail.m-online.net (Postfix) with ESMTP id 4EC8F128854;
	Fri, 17 Sep 2004 01:22:46 +0200 (CEST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id DAC3B42A69; Fri, 17 Sep 2004 01:22:45 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 42058C1430; Fri, 17 Sep 2004 01:22:45 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 40DAE13D6D2; Fri, 17 Sep 2004 01:22:45 +0200 (MEST)
To: Dan Malek <dan@embeddededge.com>
Cc: Keath Milligan <keath@keathmilligan.net>,
	Linux MIPS <linux-mips@linux-mips.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PCI VGA card info 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Thu, 16 Sep 2004 12:24:14 EDT."
             <D9320BAE-07FC-11D9-BA3D-003065F9B7DC@embeddededge.com> 
Date: Fri, 17 Sep 2004 01:22:40 +0200
Message-Id: <20040916232245.42058C1430@atlas.denx.de>
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <D9320BAE-07FC-11D9-BA3D-003065F9B7DC@embeddededge.com> you wrote:
> 
> The AMD/Alchemy folks have a Silicon Motion video adapter that will
> work in that board.  I've done the framebuffer, X-Windows runs on it.
> The standard video cards are nearly impossible to use in any kind of
> embedded environment.  Nothing PCI is available anymore, and even
> if you are able to find a way to initialize the controllers, they are 
> obsolete

The Fujitsu Coral-P is running fine on MIPS systems, for  example  on
the XXS3HC Device, see
http://www.mycable.de/productsshow.php?content=products&lang=en&topic=xxs3hc


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Shakespeare's Law of Prototyping: (Hamlet III, iv, 156-160)
        O, throw away the worser part of it,
        And live the purer with the other half.
