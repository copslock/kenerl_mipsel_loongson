Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f36FVnX31152
	for linux-mips-outgoing; Fri, 6 Apr 2001 08:31:49 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f36FUqM31108;
	Fri, 6 Apr 2001 08:31:38 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA17054;
	Fri, 6 Apr 2001 17:30:40 +0200 (MET DST)
Date: Fri, 6 Apr 2001 17:30:40 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Carsten Langgaard <carstenl@mips.com>, Florian Lohoff <flo@rfc822.org>,
   "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
In-Reply-To: <20010405143239.B13023@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010406171511.15958B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 5 Apr 2001, Ralf Baechle wrote:

> That patch is compiled into rpm and a number of the config files of rpm
> in /usr/lib/rpm which are generated are rpm build time.  So changing
> isn't that easy, you'll have to rebuild rpm configured with a different
> pathname, I think.

 The RPM config files are processed first, but later definitions override
earlier ones.  The order is: /usr/lib/rpm/rpmrc, /etc/rpmrc, ~/.rpmrc. 
The path for macro files is set in /usr/lib/rpm/rpmrc -- if the default
one does not suit you, you may override it in any of the above rc files. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
