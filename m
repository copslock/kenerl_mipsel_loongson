Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0ECagM02635
	for linux-mips-outgoing; Mon, 14 Jan 2002 04:36:42 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0ECaQg02628;
	Mon, 14 Jan 2002 04:36:26 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA13993;
	Mon, 14 Jan 2002 12:35:57 +0100 (MET)
Date: Mon, 14 Jan 2002 12:35:57 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: Ralf Baechle <ralf@oss.sgi.com>, Adrian.Hulse@taec.toshiba.com,
   linux-mips@oss.sgi.com
Subject: Re: libtool warning on redhat 7.1 native mipsel compile
In-Reply-To: <20020111214234.A5294@lucon.org>
Message-ID: <Pine.GSO.3.96.1020114123330.10091B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 11 Jan 2002, H . J . Lu wrote:

> ELF [0-9][0-9]*-bit [LM]SB [.]* (shared object | dynamic lib)

 Why not simply "lt_cv_deplibs_check_method=pass_all" like for other sane
Linux platforms?  I'm running libtool in such a configuration since May
with no negative side effects. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
