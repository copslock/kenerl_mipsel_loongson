Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 20:10:36 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:38855 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225474AbTI3TKe>; Tue, 30 Sep 2003 20:10:34 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA13711;
	Tue, 30 Sep 2003 21:10:28 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 30 Sep 2003 21:10:28 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Michael Uhler <uhler@mips.com>
cc: Ralf Baechle <ralf@linux-mips.org>,
	"Finney, Steve" <Steve.Finney@spirentcom.com>,
	linux-mips@linux-mips.org
Subject: Re: 64 bit operations w/32 bit kernel
In-Reply-To: <1064946568.13742.51.camel@uhler-linux.mips.com>
Message-ID: <Pine.GSO.3.96.1030930205322.11368E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 30 Sep 2003, Michael Uhler wrote:

> > What you want really is a 64-bit kernel.  On a 64-bit kernel even for
> > processes running in 32-bit address spaces (o32, N32) the processor
> > will run with the UX bit enabled.  o32 userspace still lives in the
> > assumption that registers are 32-bit so only those bits will be restored
> > in function calls etc.  N32 (where userspace isn't ready for prime time
> > yet) does guarantee that.  And N64 (userspace similarly not ready for
> > prime time) obviously is fully 64-bit everything.
> 
> I don't think you want to run o32 processes with the UX bit set.  UX not
> only enables 64-bit addressing (which you can, in software, make look
> like 32-bit addressing), it also enables access to the 64-bit opcodes.
> This means that you are going to get unexpected and potentially
> unreproducible results.

 Well, I think this is OK -- 64-bit opcodes are generally useless for
software built for the o32 ABI, so they should not normally happen in
regular code.  Perhaps some fancy hand-coded assembly might try to use
them to get unusual results, including an invalid opcode trap handler for
the processors that do not support them at all.  But I don't think we
should try to work hard to prevent broken software from shooting into its
foot.

 And the advantage is we have a single TLB refill handler.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
