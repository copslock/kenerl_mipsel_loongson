Received:  by oss.sgi.com id <S553847AbQJ3Kbw>;
	Mon, 30 Oct 2000 02:31:52 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:1435 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553733AbQJ3Kbb>;
	Mon, 30 Oct 2000 02:31:31 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA12566;
	Mon, 30 Oct 2000 11:27:25 +0100 (MET)
Date:   Mon, 30 Oct 2000 11:27:25 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Jun Sun <jsun@mvista.com>, Pete Popov <ppopov@mvista.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: userland packages
In-Reply-To: <20001028012745.B2813@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1001030112027.11987A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 28 Oct 2000, Ralf Baechle wrote:

> So you probably never tried to crosscompile something with extensive
> autoconf scripts like Gnome.  It's a major pain to get that done right.

 Well, for sane scripts that can be handled easily by defining problematic
cache variables to reasonable values.  The real problem are helper
programs used to build architecture-dependent data, see e.g. tic in
ncurses. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
