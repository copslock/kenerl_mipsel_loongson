Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA81575 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 18:58:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA58797
	for linux-list;
	Fri, 17 Jul 1998 18:58:15 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from xtp.engr.sgi.com (xtp.engr.sgi.com [150.166.75.34])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id SAA93473
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Jul 1998 18:58:14 -0700 (PDT)
	mail_from (greg@xtp.engr.sgi.com)
Received: by xtp.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	 id SAA19565; Fri, 17 Jul 1998 18:58:07 -0700
From: "Greg Chesson" <greg@xtp.engr.sgi.com>
Message-Id: <9807171858.ZM19563@xtp.engr.sgi.com>
Date: Fri, 17 Jul 1998 18:58:07 -0700
In-Reply-To: ralf@uni-koblenz.de
        "Re: What about..." (Jul 18,  3:37am)
References: <9807171047.ZM18720@xtp.engr.sgi.com> 
	<m0yxF1A-000aOoC@the-village.bc.nu> 
	<19980718033759.C378@uni-koblenz.de>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: ralf@uni-koblenz.de, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: What about...
Cc: wje@fir.engr.sgi.com, adevries@engsoc.carleton.ca, anubis@BanjaLuka.NET,
        linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I think everyone is suggesting the same general path, and I'm gratified
to know that the buddy system code anticipates non-contiguous physical
memory.

I think you'd want to extend the design limit (XKSEG0) beyond 1 TB
to handle the next rev of silicon.  I'd suggest 64 TB (48 bits) as
the appropriate goal.

g

-- 
Greg Chesson
