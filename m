Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GAVHRw023339
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 03:31:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GAVH8O023338
	for linux-mips-outgoing; Tue, 16 Jul 2002 03:31:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GAV9Rw023328
	for <linux-mips@oss.sgi.com>; Tue, 16 Jul 2002 03:31:10 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with ESMTP id MAA23772;
	Tue, 16 Jul 2002 12:36:25 +0200 (MET DST)
Date: Tue, 16 Jul 2002 12:36:24 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
In-Reply-To: <3D33F38A.1866E8BB@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1020716122449.20654E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
X-MIME-Autoconverted: from 8bit to quoted-printable by delta.ds2.pg.gda.pl id MAA23772
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g6GAVBRw023330
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 16 Jul 2002, Gleb O. Raiko wrote:

> In two words, it's unclear when there are no fills. Too much situations,
> additional stall condition (which may break spec anyway). I can't

 The cache logic somehow must know a fill is in progress.  Or at least
that it starts or finishes.  Another latch may store the state.

> present full explanation, sorry. You have to believe. :-)

 You don't have to convince me broken hardware is out there.  I am simply
trying to emphasize there is still some demand on good hardware, even if
marginally more expensive.

> BTW, I reread my R3081 HW Manual and found two intresting places about
> cache operation:
> 
> "These mechanisms [cache sizing, cache flushing] are enabled through the
> use of the “IsC” (Isolate Cache) and SwC (Swap Cache) bits of the status
> register, which resides in the on-chip System Control Co-Processor
> (CP0). Instructions which immediately precede and succeed these
> operations must not be cacheable, so that the actual swapping/isolation
> of the cache does not disrupt operation."

 So someone will need to code a set of cache handling functions with a
workaround for this deficiency if we are to support a system with this CPU
as it appears Linux-capable.

 Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
