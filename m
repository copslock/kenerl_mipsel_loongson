Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQHBSU11890
	for linux-mips-outgoing; Mon, 26 Nov 2001 09:11:28 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQHBGo11886;
	Mon, 26 Nov 2001 09:11:18 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA03226;
	Mon, 26 Nov 2001 17:10:54 +0100 (MET)
Date: Mon, 26 Nov 2001 17:10:53 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-mips@oss.sgi.com
Subject: Re: FPU interrupt handler
In-Reply-To: <20011127002405.E5465@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1011126170609.21598U-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 27 Nov 2001, Ralf Baechle wrote:

> >  I would *really* appreciate any feedback on DECstation patches I'm
> > sending here -- for quite some time I have a feeling I'm the last one to
> > run Linux on a DECstation... :-(
> 
> Certainly not, on the recent Linux porter meating it was probably the
> most used type of non-x86 machine.  So rather blame general passivity
> of man kind ...

 Well, but what can I think when even fatal core errors remain
unnoticed?...  The int-handler.S was one and the file wasn't changed for a
very long time, i.e. since I fixed another fatal error there...  And both
looked like they were present from the day one...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
