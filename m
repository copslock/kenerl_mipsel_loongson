Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Oct 2004 10:42:53 +0100 (BST)
Received: from wip-ec-wd.wipro.com ([IPv6:::ffff:203.101.113.39]:58816 "EHLO
	wip-ec-wd.wipro.com") by linux-mips.org with ESMTP
	id <S8225073AbUJGJmt> convert rfc822-to-8bit; Thu, 7 Oct 2004 10:42:49 +0100
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id 7294F20510;
	Thu,  7 Oct 2004 15:09:19 +0530 (IST)
Received: from blr-ec-bh3.wipro.com (unknown [10.200.50.93])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id 59A172050F;
	Thu,  7 Oct 2004 15:09:19 +0530 (IST)
Received: from chn-snr-bh3.wipro.com ([10.145.50.93]) by blr-ec-bh3.wipro.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 7 Oct 2004 15:12:35 +0530
Received: from chn-snr-msg.wipro.com ([10.145.50.99]) by chn-snr-bh3.wipro.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 7 Oct 2004 15:12:34 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: __up, __down_trylock & __down_interruptible for MIPS
Date: Thu, 7 Oct 2004 15:12:32 +0530
Message-ID: <6BF015B686198842A1C8F84F4B7E6D2601276C2F@chn-snr-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: __up, __down_trylock & __down_interruptible for MIPS
thread-index: AcSsTGr4NHXewde+QtKGWmejLjI8xQAAZfKQ
From: <priya.mani@wipro.com>
To: <geert@linux-m68k.org>
Cc: <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 07 Oct 2004 09:42:34.0881 (UTC) FILETIME=[F9578F10:01C4AC51]
Return-Path: <priya.mani@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: priya.mani@wipro.com
Precedence: bulk
X-list: linux-mips

Thanks but I did try that and did not find kernel version above 2.3.
Since I am behind a firewall I got speacial access to the
ftp.linux-mips.org and logged into the site to find the linux under pub
which contains only upto kernel version 2.3. Am I going the wrong path?

-----Original Message-----
From: geert@sonycom.com [mailto:geert@sonycom.com] On Behalf Of Geert
Uytterhoeven
Sent: Thursday, October 07, 2004 1:40 PM
To: Priya Balasubramanian (WT01 - EMBEDDED & PRODUCT ENGINEERING
SOLUTIONS)
Cc: Ralf Baechle; Linux/MIPS Development
Subject: RE: __up, __down_trylock & __down_interruptible for MIPS


On Thu, 7 Oct 2004 priya.mani@wipro.com wrote:
> I too doubted that the kernel which I am using is not in proper shape.
> Please could you point me to a proper link where I can download it
from.
> I am in need of a proper working kernel version 2.4.25 or above.
> 
> Hope you can lead me to a proper link for this!

http://cvs.linux-mips.org/kernel.html

and check out the 2.4 branch (or mainline if you want 2.6).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker.
But
when I'm talking to journalists I just say "programmer" or something
like that.
							    -- Linus
Torvalds
