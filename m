Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA50575 for <linux-archive@neteng.engr.sgi.com>; Thu, 24 Sep 1998 17:00:58 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA34072
	for linux-list;
	Thu, 24 Sep 1998 16:59:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from jibe.engr.sgi.com (jibe.engr.sgi.com [150.166.37.45])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA88996;
	Thu, 24 Sep 1998 16:59:13 -0700 (PDT)
	mail_from (kyriazis@jibe.engr.sgi.com)
Received: (from kyriazis@localhost) by jibe.engr.sgi.com (980427.SGI.8.8.8/960327.SGI.AUTOCF) id QAA76554; Thu, 24 Sep 1998 16:59:06 -0700 (PDT)
From: kyriazis@jibe.engr.sgi.com (George Kyriazis)
Message-Id: <199809242359.QAA76554@jibe.engr.sgi.com>
Subject: Re: VINO
In-Reply-To: <19980924011207.09418@alpha.franken.de> from Thomas Bogendoerfer at "Sep 24, 98 01:12:07 am"
To: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Date: Thu, 24 Sep 1998 16:59:06 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> Is it possible to do VINO DMA directly to the newport ?
> 
As far as I know, you have to do it through memory.

To elaborate:  I believe you can program the DMA controller to copy
from VINO to the REX3 (read: from a fixed address to a fixed address),
but I doubt the data formats are compatible.  Ie, you'll be dumping
garbage to the REX3 registers.

  --george
-- 
-----------------------------------------------------------------------------
George Kyriazis  | Silicon Graphics, Inc., 8U-590 |  kyriazis@sgi.com
                 | 2011 N. Shoreline Blvd.        |  650-933-2828
                 | Mt. View, CA 94043             | 
