Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Oct 2004 23:25:07 +0100 (BST)
Received: from mailout11.sul.t-online.com ([IPv6:::ffff:194.25.134.85]:8631
	"EHLO mailout11.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225074AbUJXWZC>; Sun, 24 Oct 2004 23:25:02 +0100
Received: from fwd06.aul.t-online.de 
	by mailout11.sul.t-online.com with smtp 
	id 1CLqnL-0001rp-01; Mon, 25 Oct 2004 00:24:59 +0200
Received: from router.pain-net.home (S81GDiZlrePt5QDnhT+NRBTKVOqtmRCLeFmUPrZV3R8hg0WRcSXec5@[84.133.29.216]) by fmrl06.sul.t-online.com
	with esmtp id 1CLqnK-0sT3dA0; Mon, 25 Oct 2004 00:24:58 +0200
Received: from [127.0.0.1] (neuromancer.pain-net.home [192.168.1.2])
	by router.pain-net.home (Postfix) with ESMTP id B6EE618016A1
	for <linux-mips@linux-mips.org>; Mon, 25 Oct 2004 00:14:30 +0200 (CEST)
Message-ID: <417C2BB1.9030105@pain-net.home>
Date: Mon, 25 Oct 2004 00:24:49 +0200
From: Stefan Deling <stefan.deling@web.de>
User-Agent: Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Kernel conversion problem ELF -> ECOFF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: S81GDiZlrePt5QDnhT+NRBTKVOqtmRCLeFmUPrZV3R8hg0WRcSXec5@t-dialin.net
X-TOI-MSGID: 8d87e201-f843-4ea0-b60f-42a46427b42d
Return-Path: <stefan.deling@web.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefan.deling@web.de
Precedence: bulk
X-list: linux-mips

Hi there!

I´ve just tried to compile the latest linux-mips 2.4.x kernel a few 
dayas ago.It ended up with the following problem. elf2ecoof told me:
"programm header type 3 1694766464 can´t be converted!"
I got the same problem while compiling the gentoo-mips-sources kernel.
I was not able to find a solution in the archives.
Has anyone got a solution for this problem??

Any help is appreciated.

regards

Stefan Deling
