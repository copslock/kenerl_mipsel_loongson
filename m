Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f35C5jS23725
	for linux-mips-outgoing; Thu, 5 Apr 2001 05:05:45 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f35C5cM23718;
	Thu, 5 Apr 2001 05:05:38 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA23114;
	Thu, 5 Apr 2001 14:05:23 +0200 (MET DST)
Date: Thu, 5 Apr 2001 14:05:23 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
   "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
In-Reply-To: <3ACC4EF4.D0F7D810@mips.com>
Message-ID: <Pine.GSO.3.96.1010405135731.21134B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 5 Apr 2001, Carsten Langgaard wrote:

> I have question about installation of the SRPMs, though.
> How can I relocate the packages, so they don't need to reside under
> /usr/src/redhat/ ?

 RPM uses the value of the _topdir macro as the root for source handling. 
You may override the default from /usr/lib/rpm/macros in several places --
see the macrofiles tag in /usr/lib/rpm/rpmrc.  I have it overriden to
/home/macro/src/redhat in the configuration files I made available at my
FTP site. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
