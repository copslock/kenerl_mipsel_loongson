Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA61425 for <linux-archive@neteng.engr.sgi.com>; Wed, 21 Oct 1998 23:26:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA00758
	for linux-list;
	Wed, 21 Oct 1998 23:26:03 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA94015
	for <linux@engr.sgi.com>;
	Wed, 21 Oct 1998 23:26:01 -0700 (PDT)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id XAA32028 for linux@engr.sgi.com; Wed, 21 Oct 1998 23:26:01 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199810220626.XAA32028@oz.engr.sgi.com>
Subject: (fwd) was bug in haifa scheduler (or not)
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Wed, 21 Oct 1998 23:26:00 -0700 (PDT)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

[just forwarding a bounce]

From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: ralf@uni-koblenz.de
CC: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
In-reply-to: <19981022024408.A360@uni-koblenz.de> (ralf@uni-koblenz.de)
Subject: Re: Haifa scheduler bug in egcs 1.0.2
References: <19981021015047.G1830@uni-koblenz.de> <199810210139.SAA22458@dm.cobaltmicro.com> <19981022024408.A360@uni-koblenz.de>

   Date: Thu, 22 Oct 1998 02:44:08 +0200
   From: ralf@uni-koblenz.de

   The ABI is quite strict in that aspect, it wants one lo16 per hi16
   for the same symbol.  Binutils relax that by allowing an arbitrary
   number of hi16 and one lo16 for the same symbol.

I completely understand how hi16/lo16 relocations work on MIPS, but
thanks for reiterating it to me once more.

All you have shown me is a bug in the MIPS ABI, one of thousands.

Therefore, there is no reason binutils cannot handle this sanely, and
be fixed to do so.

Later,
David S. Miller
davem@dm.cobaltmicro.com

----- End of forwarded message from owner-linux@cthulhu -----

-- 
Peace, Ariel
