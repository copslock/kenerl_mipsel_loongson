Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2003 17:35:38 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:53197 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225209AbTHNQfg>; Thu, 14 Aug 2003 17:35:36 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA18484;
	Thu, 14 Aug 2003 18:35:28 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Thu, 14 Aug 2003 18:35:28 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] Generic time trailing clean-ups
In-Reply-To: <20030814091326.A1203@mvista.com>
Message-ID: <Pine.GSO.3.96.1030814182619.17768B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 14 Aug 2003, Jun Sun wrote:

> I am completely lost in your arguments.  Let us keep it to the basic.
> 
> Tell me what is wrong with the following, and why your proposal
> is better than this:
> 
> 1) get rid of calibrate_*() function
> 2) introduce a generic counter frequence calibration routine, which
>    is only invoked when mips_counter_frequency is 0.
> 3) If any board is not happy with this calibration, it is free to
>    do its calibration in board_timer_init(), which would set
>    mips_counter_frequency to be non-zero.

 So I am lost, too.  What I proposed with the patch is exactly what you
describe above.  So what's wrong with it?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
