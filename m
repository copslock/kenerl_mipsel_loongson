Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2007 14:34:31 +0100 (BST)
Received: from bay0-omc2-s36.bay0.hotmail.com ([65.54.246.172]:28411 "EHLO
	bay0-omc2-s36.bay0.hotmail.com") by ftp.linux-mips.org with ESMTP
	id S20021926AbXHPNeW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Aug 2007 14:34:22 +0100
Received: from hotmail.com ([65.55.152.119]) by bay0-omc2-s36.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Thu, 16 Aug 2007 06:34:15 -0700
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 16 Aug 2007 06:34:15 -0700
Message-ID: <BAY141-F39F0F707148D2899FEF184C2DF0@phx.gbl>
Received: from 65.55.152.123 by by141fd.bay141.hotmail.msn.com with HTTP;
	Thu, 16 Aug 2007 13:34:13 GMT
X-Originating-IP: [61.95.197.134]
X-Originating-Email: [rpoornar@hotmail.com]
X-Sender: rpoornar@hotmail.com
From:	"POORNIMA R" <rpoornar@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: [MIPS]mcheck error 
Date:	Thu, 16 Aug 2007 13:34:13 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 16 Aug 2007 13:34:15.0196 (UTC) FILETIME=[236C8DC0:01C7E00A]
Return-Path: <rpoornar@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpoornar@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I am working on MIPS architecture and my kernel version
is linux-2.6.10  and  I am a newbie to MIPS architecture.
If I try inserting  any module (.ko), I get meck exception
due to multiple matching entries in TLB

1. What is the reason for multiple enteries in TLB
due to module insertion?

2. Should the TLB operations be performed with interrupts disabled?

Poornima

_________________________________________________________________
Find a local pizza place, movie theater, and more….then map the best route! 
http://maps.live.com/default.aspx?v=2&ss=yp.bars~yp.pizza~yp.movie%20theater&cp=42.358996~-71.056691&style=r&lvl=13&tilt=-90&dir=0&alt=-1000&scene=950607&encType=1&FORM=MGAC01
