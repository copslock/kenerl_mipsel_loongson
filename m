Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5C0xiq13282
	for linux-mips-outgoing; Mon, 11 Jun 2001 17:59:44 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5C0xgV13279
	for <linux-mips@oss.sgi.com>; Mon, 11 Jun 2001 17:59:42 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id DAA19410;
	Tue, 12 Jun 2001 03:01:32 +0200 (MET DST)
Date: Tue, 12 Jun 2001 03:01:32 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: Keith Owens <kaos@ocs.com.au>, linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays)
In-Reply-To: <20010611211251.A5749@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010612025658.18298A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 11 Jun 2001, Florian Lohoff wrote:

> Nope - it wont as it strictly uses the /usr/bin/objdump - You have to
> set the environment var "KSYMOOPS_OBJDUMP"

 Good it has a way to override the default, but wouldn't looking for
objdump in the PATH variable (i.e. using execvp()) be more reasonable?
This way ksymoops would always work in a cross-compilation environment
(i.e. with $tooldir/bin preceding $bindir in PATH).

 Just an ad-hoc idea...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
