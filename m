Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DBSjR04863
	for linux-mips-outgoing; Mon, 13 Aug 2001 04:28:45 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DBScj04858
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 04:28:38 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA19659;
	Mon, 13 Aug 2001 13:30:30 +0200 (MET DST)
Date: Mon, 13 Aug 2001 13:30:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Armin F. Gnosa" <mipslist@gnosa.com>
cc: linux-mips@oss.sgi.com
Subject: Re: Problem with PMAD-AA / DECStation 5000/200
In-Reply-To: <002601c121a0$de4f2fa0$237900d9@shodan>
Message-ID: <Pine.GSO.3.96.1010810154658.7147B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 10 Aug 2001, Armin F. Gnosa wrote:

> That sounds like an interesting alternative to pulling the PROM out of
> its socket. Then, a program running on a DECStation 5000/200 should be
> reading from 0x1F81C0000..0x1F1FFFFF, right? One question about Byte
> Merging: Does it mean that I don't have to read bytewise but instead
> DWORD-wise?

 The system ROM is mapped from 0x1f800000 up to 0x1f83fffff (and repeated
at 0x1fc00000) and is 256kB in size on my /240.

 Although I cannot verify it, docs state that the /200 contains the
following ROMs:

- the system ROM from 0x1fc00000 up to 0x1fc7ffff (repeated at
0x1ff80000), 256kB in size,

- the PMAD-A ROM from 0x1f9c0000 up to 0x1f9fffff, 32kB in size,

- the PMAZ-A ROM from 0x1f4c0000 up to 0x1f4fffff, 32kB in size. 

 The system ROMs are presented on the whole data bus, while the option
ROMs are only presented on 8 least significant bits.  The merging can be
switched off for I/O ASIC systems (I haven't tested the exact behaviour of
this configuration) but it seems to be hardwired for the /200.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
