Received:  by oss.sgi.com id <S553858AbRA2Pf7>;
	Mon, 29 Jan 2001 07:35:59 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:25493 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553834AbRA2Pfp>;
	Mon, 29 Jan 2001 07:35:45 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA24603;
	Mon, 29 Jan 2001 16:34:53 +0100 (MET)
Date:   Mon, 29 Jan 2001 16:34:52 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Justin Carlson <carlson@sibyte.com>, linux-mips@oss.sgi.com
Subject: Re: GDB 5 for mips-linux/Shared library loading with new binutils/glibc
In-Reply-To: <20010127110106.F867@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010129162609.20889C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 27 Jan 2001, Ralf Baechle wrote:

> The only people who have contributed amounts of code large enough for the
> FSF to requires an assignment are David Miller (davem@redhat.com) and
> myself.  I've already signed an assignment with the FSF and I'm also sure

 Ok, I'll dig out the patch and contact all interested parties again.

> David has.  I btw. cannot remember having seen any mail from you regarding
> copyright assignments of GDB.

 It was back in July, 2000, so it a long time ago...

> >  Does it?  Please provide more details.  All of my system (linux 2.4.0,
> > glibc 2.2.1) is dynamically linked and it works fine.
> 
> I don't know what you look at - ld.so fails to handle libraries which are
> not linked to 0x5fffe000 ...

 Does it?  I admit I haven't checked it specifically.  It needs to be
fixed if so.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
