Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id XAA271046 for <linux-archive@neteng.engr.sgi.com>; Thu, 12 Feb 1998 23:54:04 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA02466 for linux-list; Thu, 12 Feb 1998 23:49:38 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA02449 for <linux@engr.sgi.com>; Thu, 12 Feb 1998 23:49:32 -0800
Received: from thorgal.et.tudelft.nl (thorgal.et.tudelft.nl [130.161.40.91]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id XAA15608
	for <linux@engr.sgi.com>; Thu, 12 Feb 1998 23:49:30 -0800
	env-from (bakker@thorgal.et.tudelft.nl)
Received: from [130.161.115.44] (jdbakker.et.tudelft.nl [130.161.115.44])
	by thorgal.et.tudelft.nl (8.8.5/8.8.5) with ESMTP id IAA09517;
	Fri, 13 Feb 1998 08:48:22 +0100
Message-Id: <v0313030ab108e9ffdbdb@[130.161.40.82]>
In-Reply-To: <199802121210.NAA25532@loki.gams.co.at>
References: Your message of "Thu, 12 Feb 1998 05:56:48 +0100."            
 <19980212055648.54198@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 12 Feb 1998 23:05:11 +0100
To: Michael Lausch <mla@gams.co.at>
From: "J.D. Bakker" <bakker@thorgal.et.tudelft.nl>
Subject: Re: TLB entries > 4kb
Cc: ralf@uni-koblenz.de, linux-kernel@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>r> Has anybody ever looked into implementing that?  What architectures besides
>r> MIPS could take advantage of such a feature?
>
>The MPC860. We now have 8 MByte Page Table entries for the Kernel Address
>Space and the Dual Ported RAM used to communicate with the CPM.

...and the IBM PPC403GC/GCX. Variable page sizes between 1k and 16M (in
eight steps, variable per TLB IIRC). This MMU, "designed for embedded apps"
according to IBM, also handles the process ID per TLB that Ralf mentioned
on the MIPS.

JDB (hunting for round tuits for that PPC board design)

Jan-Derk Bakker
Official Usenet Net.scum; see http://www.netscum.net
