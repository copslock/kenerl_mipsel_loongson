Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA33089 for <linux-archive@neteng.engr.sgi.com>; Tue, 19 Jan 1999 18:36:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA86025
	for linux-list;
	Tue, 19 Jan 1999 18:36:21 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from mailbox.esd.sgi.com (mailbox.esd.sgi.com [130.62.72.15])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA86073
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 19 Jan 1999 18:36:19 -0800 (PST)
	mail_from (kck@mailbox.esd.sgi.com)
Received: by mailbox.esd.sgi.com (980427.SGI.8.8.8/950213.SGI.AUTOCF)
	 id SAA12779; Tue, 19 Jan 1999 18:36:03 -0800 (PST)
From: kck@mailbox.esd.sgi.com (Ken Klingman)
Message-Id: <199901200236.SAA12779@mailbox.esd.sgi.com>
Subject: Re: [Fwd: linus.linux.sgi.com]
To: offer@morgaine.engr.sgi.com (Richard Offer)
Date: Tue, 19 Jan 1999 18:36:03 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <9901191828.ZM20761@morgaine.engr.sgi.com> from "Richard Offer" at Jan 19, 99 06:28:50 pm
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


The VW 320 and 540 use 288-bit wide synchronous DRAM, clocked
at 100MHz.  288 bits means it's not your everyday PC SDRAM.
That's 256 bits for data and 32 for ECC.  256bits = 32 bytes
at 100MHz = 3.2GB/sec theoretically possible between the 
memory system and Cobalt, the memory controller/graphics
ASIC.

Ken
