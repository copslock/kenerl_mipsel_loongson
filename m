Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4SMJAnC031000
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 28 May 2002 15:19:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4SMJAhM030999
	for linux-mips-outgoing; Tue, 28 May 2002 15:19:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from tibook.netx4.com (embeddededge.com [209.113.146.155])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4SMJ5nC030996
	for <linux-mips@oss.sgi.com>; Tue, 28 May 2002 15:19:06 -0700
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id g4SMJW900688;
	Tue, 28 May 2002 18:19:32 -0400
Message-ID: <3CF40273.1000801@embeddededge.com>
Date: Tue, 28 May 2002 18:19:31 -0400
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: Jun Sun <jsun@mvista.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
   "Steven J. Hill" <sjhill@realitydiluted.com>,
   Linux/MIPS Development
 <linux-mips@oss.sgi.com>
Subject: Re: PCI Graphics/Video Card for Malta Board?
References: <Pine.GSO.4.21.0205271534430.15706-100000@vervain.sonytel.be> <3CF3B72B.4020600@mvista.com> <01da01c2066f$3ed63f40$10eca8c0@grendel>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Kevin D. Kissell wrote:

>>Dan Malek also wrote a driver for MQ200.  

I can't really take credit for that :-).  It was a bunch of code
from various places I just turned into a driver.

> I *am* asking around - that's why I started this thread.

Look at some of the stuff from Epson.  You may find something there.

> So it sounds like the Matrox G450 PCI is really the only
> game in town...

It very well may be the only option.  I've been working with
"standard" graphic cards/chips for embedded devices for quite
some time.  The latest technology is always quite secret, seldom
even available under NDA.  Most of the cards I have used come
from the $5 cardboard box in one of the electronic salvage yards in
Silicon Valley.  Something so old they will tell you about the
registers on the board :-)


	-- Dan
