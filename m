Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DGPcT12996
	for linux-mips-outgoing; Mon, 13 Aug 2001 09:25:38 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DGPVj12986;
	Mon, 13 Aug 2001 09:25:31 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA24793;
	Mon, 13 Aug 2001 18:27:37 +0200 (MET DST)
Date: Mon, 13 Aug 2001 18:27:35 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>,
   linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: /usr/bin/file
In-Reply-To: <20010813175226.D2228@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010813182436.23241O-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 13 Aug 2001, Ralf Baechle wrote:

> >  It's worth to run `libtoolize -c -f' before building any libtool-based
> > software. 
> 
> That results in build failures for a few rpms.  Many packages already do
> that but unfortunately not all.

 Well, libtool is pretty self-contained, but you may try to regenerate
scripts as well.  If that fails, too, the software needs to be fixed
sooner or later.  Look at my packages for a number of updates in this
area.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
