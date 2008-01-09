Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jan 2008 14:49:25 +0000 (GMT)
Received: from mail.gmx.net ([213.165.64.20]:46302 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20029253AbYAIOtP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 Jan 2008 14:49:15 +0000
Received: (qmail invoked by alias); 09 Jan 2008 14:49:08 -0000
Received: from vpn140.rz.tu-ilmenau.de (EHLO [192.168.1.100]) [141.24.172.140]
  by mail.gmx.net (mp058) with SMTP; 09 Jan 2008 15:49:08 +0100
X-Authenticated: #44099387
X-Provags-ID: V01U2FsdGVkX1/54E59Ey/5oAttwWRMZl9T0D1lVq9nY1LkLaJ41Y
	IdJ+Apo/gAv94b
Message-ID: <4784DEE3.90709@gmx.net>
Date:	Wed, 09 Jan 2008 15:49:07 +0100
From:	Andi <opencode@gmx.net>
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: memory dump on mips
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <opencode@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: opencode@gmx.net
Precedence: bulk
X-list: linux-mips

Hello,

Thiemo Seufer wrote:
> > This sounds like you are confusing physical and virtual addresses.
> > Typically the kernel is loaded to the direct-mapped KSEG0 segment,
> > which starts at physical 0x00000000 / virtual 0x80000000.

Thank you for pointing on that. I was not sure if this was virtual or
physical since i grabbed this address from a serial-debug output. But if
one thinks about that the device has around 128mb it should be clear
that this can't be a physical address if ram starts at 0x00000000.

We'll check this ..


Regards,

Andi
