Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA04037 for <linux-archive@neteng.engr.sgi.com>; Tue, 19 Jan 1999 19:09:01 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA55659
	for linux-list;
	Tue, 19 Jan 1999 19:08:24 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from xtp.engr.sgi.com (xtp.engr.sgi.com [150.166.75.34])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id TAA04086
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 19 Jan 1999 19:08:21 -0800 (PST)
	mail_from (greg@xtp.engr.sgi.com)
Received: by xtp.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	 id TAA20789; Tue, 19 Jan 1999 19:08:20 -0800
From: "Greg Chesson" <greg@xtp.engr.sgi.com>
Message-Id: <9901191908.ZM20787@xtp.engr.sgi.com>
Date: Tue, 19 Jan 1999 19:08:19 -0800
In-Reply-To: offer@morgaine (Richard Offer)
        "Re: [Fwd: linus.linux.sgi.com]" (Jan 19,  6:28pm)
References: <199901200204.UAA14601@piquin.uchicago.edu> 
	<9901191828.ZM20761@morgaine.engr.sgi.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: offer@morgaine.engr.sgi.com (Richard Offer), linux@cthulhu.engr.sgi.com
Subject: Re: [Fwd: linus.linux.sgi.com]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

This is a case of rocket brains getting confused by misleading specs
in the commodity world: a 50ns dram or sdram is very fast - that refers
to the cycle time of the internal dram core whereas a PCI-100 compliant
memory must operate on a 100 Mhz (10ns) bus and needs a latch time
better than 10ns.

g

-- 
Greg Chesson
