Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Sep 2004 17:37:34 +0100 (BST)
Received: from smtp.omnis.com ([IPv6:::ffff:216.239.128.26]:51460 "EHLO
	smtp.omnis.com") by linux-mips.org with ESMTP id <S8224935AbUIPQh3>;
	Thu, 16 Sep 2004 17:37:29 +0100
Received: from [172.26.48.101] (unknown [216.54.148.81])
	by smtp-relay.omnis.com (Postfix) with ESMTP id 456B51004A8
	for <linux-mips@linux-mips.org>; Thu, 16 Sep 2004 09:37:22 -0700 (PDT)
Message-ID: <4149C140.2070605@keathmilligan.net>
Date: Thu, 16 Sep 2004 11:37:20 -0500
From: Keath Milligan <keath@keathmilligan.net>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: PCI VGA card info
References: <4149B71C.7020705@keathmilligan.net> <D9320BAE-07FC-11D9-BA3D-003065F9B7DC@embeddededge.com>
In-Reply-To: <D9320BAE-07FC-11D9-BA3D-003065F9B7DC@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <keath@keathmilligan.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keath@keathmilligan.net
Precedence: bulk
X-list: linux-mips

Dan Malek wrote:

> The AMD/Alchemy folks have a Silicon Motion video adapter that will
> work in that board.  I've done the framebuffer, X-Windows runs on it.
> The standard video cards are nearly impossible to use in any kind of
> embedded environment.  Nothing PCI is available anymore, and even
> if you are able to find a way to initialize the controllers, they are 
> obsolete
> before you get any product ready for manufacturing.

I have this card but it doesn't seem to work with a 2.6 kernel. I'm 
trying to just get a console visible on it at this point, but the card 
doesn't seem to be getting turned on.

-- 
Keath Milligan
Austin, Texas
http://keathmilligan.net - News, Tech, Politics, Software
