Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 21:54:30 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:8580 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225207AbTGVUy2>; Tue, 22 Jul 2003 21:54:28 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA10148;
	Tue, 22 Jul 2003 22:54:23 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 22 Jul 2003 22:54:23 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Wolfgang Denk <wd@denx.de>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] Generic time fixes 
In-Reply-To: <20030722102109.ADB10C6D82@atlas.denx.de>
Message-ID: <Pine.GSO.3.96.1030722223857.607I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 22 Jul 2003, Wolfgang Denk wrote:

> > I share your dislike of updating the RTC for performance reasons; these
> 
> There are more problems with the 11 minute mode.  We  ran  into  this
> issue  for hard on some PowerPC systems. Assume a situation where the
> RTC is connected through a I2C  bus.  Problem  1:  normally  the  i2c
> drivers  will  be  loaded prety late, which means the system will run
> initially with an undefined time. Problem 2: on some  actions  a  i2c
> transfer  involves  programming an on-chip i2c controller, which will
> perform the task and then signal it's done by an interrupt. On such a
> system the 11 minute mode will crash the system because rtc_set  will
> be called from interrupt contect itself.
> 
> There was a  somewhat  controverse  discussion  on  the  linuxppc_dev
> mailing list, without a real solution.

 A possible solution is to make the update configurable with a sysctl.  It
really begs for it.  I think it may be worth discussing at the LKML. 
Additionally Ulrich Windl may wish to share a few thoughts on the matter. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
