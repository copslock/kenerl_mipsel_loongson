Received:  by oss.sgi.com id <S553733AbRADQ0n>;
	Thu, 4 Jan 2001 08:26:43 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:52141 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553661AbRADQ0U>;
	Thu, 4 Jan 2001 08:26:20 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA11844;
	Thu, 4 Jan 2001 17:22:52 +0100 (MET)
Date:   Thu, 4 Jan 2001 17:22:51 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     John Van Horne <JohnVan.Horne@cosinecom.com>,
        "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        "'wesolows@foobazco.org'" <wesolows@foobazco.org>
Subject: Re: your mail
In-Reply-To: <20010104133629.C936@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010104171213.4624E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 4 Jan 2001, Ralf Baechle wrote:

> > I see that our start address of 0x80102584 has been turned into
> > 0xffffffff80102584. I'm thinking that
> > I need to tell ld something to stop it from doing this. Any ideas?
> 
> That's be ok.  32-bit MIPS addresses are sign-extended into 64-bit addresses.
> Older binutils used to zero-extend addresses which was broken.  So what
> you observe is actually the sympthom of a bug that got fixed.

 I'm not sure that's the best solution, I'm afraid.  For elf32-mips
addresses should be 32-bit and not 64-bit.  It would be consistent with
other 32-bit platforms, it would make interoperability easier (ksymoops
cannot make use of System.map to grok kernel oopses which provide 32-bit
addresses) and it would make objdump outputs more readable.

 Fixing this problem with BFD is on my to do list (but has a low priority
assigned). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
