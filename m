Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g53IS5nC004442
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 3 Jun 2002 11:28:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g53IS5cE004441
	for linux-mips-outgoing; Mon, 3 Jun 2002 11:28:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g53IRvnC004436;
	Mon, 3 Jun 2002 11:27:58 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA22478;
	Mon, 3 Jun 2002 20:30:10 +0200 (MET DST)
Date: Mon, 3 Jun 2002 20:30:09 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>, Jun Sun <jsun@mvista.com>,
   Alexandr Andreev <andreev@niisi.msk.ru>, linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
In-Reply-To: <20020603015536.B2832@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020603202021.14451K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 3 Jun 2002, Ralf Baechle wrote:

> Some gcc 3.0 versions definately misscompiles the kernel; anyway 3.0 enjoys
> a bad reputation for bugginess and being slow at generating slow code
> beyond just the MIPS port, so why both with 3.0.  2.95.4 seems quite
> reliable.

 As gcc 3.1 is out, it may be worth checking.  I actually plan to do that
in not so distant future.

> The issues with newer toolchains have been discussed at various times on
> the list; at this time I don't have a tested toolchain that is usable for
> all configurations of the kernel.  Also note that my recommendation of
> binutils 2.9.5 is only for the kernel.
> 
> Anyway, binutils 2.12 is looking promising so far ...

 Well, 2.12.1 seem rock solid for me.  The package I made available at my
site only contains two patches that affect code (the rest is autoconf and
similar stuff) and then only MIPS64.  They can be safely discarded for
pure MIPS work.

 For MIPS64 they definitely do not work, OTOH, including the N32 ABI.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
