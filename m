Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g61EO6nC006197
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 07:24:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g61EO6e2006196
	for linux-mips-outgoing; Mon, 1 Jul 2002 07:24:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g61ENvnC005990;
	Mon, 1 Jul 2002 07:23:58 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA09519;
	Mon, 1 Jul 2002 16:28:14 +0200 (MET DST)
Date: Mon, 1 Jul 2002 16:28:13 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@oss.sgi.com, Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: [Oops] Indy R4600 Oops(es) w/ 2.4.19-rc1
In-Reply-To: <20020701094359.GP17216@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1020701161009.7601E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 1 Jul 2002, Jan-Benedict Glaw wrote:

> Okay, stupid idea. All these flush functions seem to be never called in
> parallel or recursive, so if might be possible to have a global flags
> variable and instead of always calling __save..() and __restore..(),
> we bulid a pair of inline functions doing this. This wouldn't give
> any penalty for !CONFIG_CPU_R4X00 and doesn't obscure the code so much
> as all those #ifdef and #endif's would do... I'll test my suggestion
> as fast as I reach my Indy again (is powered down at home...).

 Feel free to use the change privately.  Otherwise please code a real fix,
i.e. a set of buggy-R4600-specific functions, as CONFIG_CPU_R4X00 means
other processors as well, e.g. R4000 or R4400 which are fine here. 

 Actually blocking interrupts for over 0.01s as it used to be done is
unacceptable, even for buggy R4600 processors.  A fix should use a more
fine-grained interrupt masking. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
