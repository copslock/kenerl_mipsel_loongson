Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MGwlRw027577
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 09:58:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MGwlGt027576
	for linux-mips-outgoing; Mon, 22 Jul 2002 09:58:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MGweRw027567
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 09:58:41 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA08302;
	Mon, 22 Jul 2002 18:56:43 +0200 (MET DST)
Date: Mon, 22 Jul 2002 18:56:42 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@oss.sgi.com
Subject: Re: sys32_execve fix
In-Reply-To: <3D3C0E26.676F4799@mips.com>
Message-ID: <Pine.GSO.3.96.1020722184609.2373J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 22 Jul 2002, Carsten Langgaard wrote:

> The problem is that "nargs" in arch/mips64/kernel/linux32.c fails when
> argv is NULL, the patch below should fix the problem:

 How about just:

	if (!arg)
		return 0;

at the top?  Gcc should optimize it to a single branch, likely not taken,
and a register move.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
