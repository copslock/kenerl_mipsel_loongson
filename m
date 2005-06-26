Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Jun 2005 04:10:19 +0100 (BST)
Received: from orb.pobox.com ([IPv6:::ffff:207.8.226.5]:28309 "EHLO
	orb.pobox.com") by linux-mips.org with ESMTP id <S8225743AbVFZDKA>;
	Sun, 26 Jun 2005 04:10:00 +0100
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id 94AB7221D
	for <linux-mips@linux-mips.org>; Sat, 25 Jun 2005 23:09:07 -0400 (EDT)
Received: from troglodyte.asianpear (c-24-21-141-200.hsd1.or.comcast.net [24.21.141.200])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 439FC99
	for <linux-mips@linux-mips.org>; Sat, 25 Jun 2005 23:09:07 -0400 (EDT)
Subject: xxs1500 reboots
From:	Kevin Turner <kevin.m.turner@pobox.com>
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Date:	Sat, 25 Jun 2005 20:09:13 -0700
Message-Id: <1119755353.3996.178.camel@troglodyte.asianpear>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Return-Path: <kevin.m.turner@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevin.m.turner@pobox.com
Precedence: bulk
X-list: linux-mips

This reliably reboots my xxs1500:

dd if=/dev/zero of=/dev/null count=10000 bs=1k

while reading just 1000k doesn't.

But only when I have a particular wifi card plugged in and initialized.
(I can have the card in so 'cardctl' sees it and the modules loaded, but
as long as it is not registered by cardmgr it does not react.)

It doesn't have to be /dev/null; I've also triggered this by reading
from nfs, tmpfs, and flash.

The wifi card is a wl1100c with hostap drivers,
the kernel is 2.4 CVS with Pete's 64bit_pcmcia.patch.

Does this ring any bells?  Or can you offer any pointers on how to track
this down further?

Thanks,

 - Kevin


-- 
The moon is waning gibbous, 81.4% illuminated, 19.0 days old.
