Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f77EYZQ21447
	for linux-mips-outgoing; Tue, 7 Aug 2001 07:34:35 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f77EYVV21429
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 07:34:32 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA08486;
	Tue, 7 Aug 2001 16:36:35 +0200 (MET DST)
Date: Tue, 7 Aug 2001 16:36:34 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Bradley D. LaRonde" <brad@ltc.com>
cc: linux-mips@oss.sgi.com
Subject: Re: cross-mipsel-linux-ld --prefix library path
In-Reply-To: <089d01c11f4b$449b4800$3501010a@ltc.com>
Message-ID: <Pine.GSO.3.96.1010807162531.3289F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 7 Aug 2001, Bradley D. LaRonde wrote:

> So if I leave out --prefix alogether, will "make install" overwrite any x86
> stuff, like that libbfd.la file I mentioned?

 Well, libbfd and libopcodes do conflict indeed.  In theory they can
support multiple targets at once, but I'm unsure if that's stable enough. 
I use "--enable-shared --disable-static
--libdir='${exec_prefix}'/mipsel-linux/i386-linux/lib" in the configure's
command line for i386-linux-hosted cross-binutils.  As a result the
libraries get installed out of the way but they are still used by
cross-binutils thanks to the RPATH tag being set appropriately in ELF
headers by libtool. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
