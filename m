Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DBUOC04972
	for linux-mips-outgoing; Mon, 13 Aug 2001 04:30:24 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DBTxj04944;
	Mon, 13 Aug 2001 04:30:11 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA19681;
	Mon, 13 Aug 2001 13:32:19 +0200 (MET DST)
Date: Mon, 13 Aug 2001 13:32:19 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>,
   linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: /usr/bin/file
In-Reply-To: <20010810164945.B24889@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010813133045.18279C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 10 Aug 2001, Ralf Baechle wrote:

> The fact that each package based on libtool is carrying it's own copy of
> libtool around doesn't exactly help to eleminate old libtool copies
> quickly either.

 It's worth to run `libtoolize -c -f' before building any libtool-based
software. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
