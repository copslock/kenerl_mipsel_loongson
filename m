Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HECaF12932
	for linux-mips-outgoing; Thu, 17 Jan 2002 06:12:36 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HECBP12929;
	Thu, 17 Jan 2002 06:12:14 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA13169;
	Thu, 17 Jan 2002 14:04:50 +0100 (MET)
Date: Thu, 17 Jan 2002 14:04:49 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: IDE driver broken in bigendian 2.4.17 kernel
In-Reply-To: <3C46B151.7A15C5F4@mips.com>
Message-ID: <Pine.GSO.3.96.1020117135554.10407B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 17 Jan 2002, Carsten Langgaard wrote:

> Due to changes in the string port macros/functions (insl, outsl, insw,
> ...) the bigendian IDE driver doesn't work anymore.
> I think we need to have local versions of these functions in
> include/asm-mips/ide.h, therefore these functions should be macros
> (#define) and not static functions in include/asm-mips/io.h (in order to
> redefine them).

 I believe the inline functions should be left as they are and the IDE
driver should use own ones that call the formers and perform byteswapping
on results as needed.  You should avoid the name clash. 

 Also if that's a chipset-specific issue and not an IDE host adapter's
one, this should be resolved globally as other devices/drivers may be
affected. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
