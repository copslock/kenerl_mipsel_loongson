Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2005 17:02:39 +0000 (GMT)
Received: from orb.pobox.com ([IPv6:::ffff:207.8.226.5]:2256 "EHLO
	orb.pobox.com") by linux-mips.org with ESMTP id <S8225429AbVA1RCI>;
	Fri, 28 Jan 2005 17:02:08 +0000
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id A2BEB95
	for <linux-mips@linux-mips.org>; Fri, 28 Jan 2005 12:02:06 -0500 (EST)
Received: from troglodyte.asianpear (c-24-21-141-200.client.comcast.net [24.21.141.200])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 43D548A
	for <linux-mips@linux-mips.org>; Fri, 28 Jan 2005 12:02:06 -0500 (EST)
Subject: Re: pcmcia on au1x00
From:	Kevin Turner <kevin.m.turner@pobox.com>
To:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <41F9FC53.7070401@embeddedalley.com>
References: <1106895575.4059.42.camel@troglodyte.asianpear>
	 <41F9FC53.7070401@embeddedalley.com>
Content-Type: text/plain
Date:	Fri, 28 Jan 2005 09:02:04 -0800
Message-Id: <1106931724.4059.90.camel@troglodyte.asianpear>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Return-Path: <kevin.m.turner@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevin.m.turner@pobox.com
Precedence: bulk
X-list: linux-mips

On Fri, 2005-01-28 at 00:48 -0800, Pete Popov wrote:
> The au1000_generic.c is the generic portion of the driver. Then 
> there is the board(s) specific portion. Just a look at the new 
> db1x00 part and updating the pb1x00 driver should be pretty straight 
> forward.

I don't know that I'm personally interested in updating the pb1x00
driver -- I'll be needing to support a new board entirely.  But I
imagine "look at the new db1x00 part" still applies.  Thanks Pete.

-- 
The moon is waning gibbous, 92.3% illuminated, 17.4 days old.
