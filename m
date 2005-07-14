Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2005 21:48:47 +0100 (BST)
Received: from orb.pobox.com ([IPv6:::ffff:207.8.226.5]:8630 "EHLO
	orb.pobox.com") by linux-mips.org with ESMTP id <S8226738AbVGNUsY>;
	Thu, 14 Jul 2005 21:48:24 +0100
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id A1DDA1FB3
	for <linux-mips@linux-mips.org>; Thu, 14 Jul 2005 16:49:26 -0400 (EDT)
Received: from troglodyte.asianpear (c-24-21-141-200.hsd1.or.comcast.net [24.21.141.200])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 4603287
	for <linux-mips@linux-mips.org>; Thu, 14 Jul 2005 16:49:26 -0400 (EDT)
Subject: Re: What is the current USB support status on DB1550?
From:	Kevin Turner <kevin.m.turner@pobox.com>
To:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1121356192.4797.362.camel@localhost.localdomain>
References: <2db32b7205071408327b005e4e@mail.gmail.com>
	 <1121356192.4797.362.camel@localhost.localdomain>
Content-Type: text/plain
Date:	Thu, 14 Jul 2005 13:49:34 -0700
Message-Id: <1121374174.30104.7.camel@troglodyte.asianpear>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Return-Path: <kevin.m.turner@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevin.m.turner@pobox.com
Precedence: bulk
X-list: linux-mips

On Thu, 2005-07-14 at 08:49 -0700, Pete Popov wrote:
> Host only. We couldn't make gadget work due to interrupt latency
> requirements by the HW that couldn't be reliably achieved with Linux.
> But gadget does work on the Au1200.

Is the Au1500 in the same boat as the DB1550?  Do the hardware
requirements apply to all boards with that SOC, or is it somewhat
board-dependent?

Thanks,

 - Kevin

-- 
The moon is first quarter, 49.5% illuminated, 7.3 days old.
