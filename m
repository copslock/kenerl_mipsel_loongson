Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9HB8Tf25528
	for linux-mips-outgoing; Wed, 17 Oct 2001 04:08:29 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9HB8HD25523;
	Wed, 17 Oct 2001 04:08:18 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA06978;
	Wed, 17 Oct 2001 13:07:23 +0200 (MET DST)
Date: Wed, 17 Oct 2001 13:07:23 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.9: Bad code in xchg_u32()
In-Reply-To: <20011017002947.A19789@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1011017125807.6463A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 17 Oct 2001, Ralf Baechle wrote:

> I've added the "memory" clobber back; xchg() is expected to imply a memory
> barrier.

 I'm not sure what you mean.  The "memory" clobber only means random
memory can get modified so gcc must dispose of all variables cached in
registers and reload them from memory.  Is xchg() meant to do so?  What
for?

> "R" indeed seems to be fishy; I can't compile the kernel if I remove
> the volatile from the first argument of xchg_u32().  I'd feel safer if
> we could use "m" until we can be sure "R" works fine.

 Sure we can, at the expense of obfuscating the code and wasting a
register -- we may use la explicitly.  But I hate workarounds -- they tend
to live forever and keep the real bug unfixed.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
