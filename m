Received:  by oss.sgi.com id <S553864AbRADRcX>;
	Thu, 4 Jan 2001 09:32:23 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:32430 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553692AbRADRcM>;
	Thu, 4 Jan 2001 09:32:12 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA13739;
	Thu, 4 Jan 2001 18:18:42 +0100 (MET)
Date:   Thu, 4 Jan 2001 18:18:41 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Joe deBlaquiere <jadb@redhat.com>
cc:     Ralf Baechle <ralf@oss.sgi.com>,
        John Van Horne <JohnVan.Horne@cosinecom.com>,
        "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        "'wesolows@foobazco.org'" <wesolows@foobazco.org>
Subject: Re: your mail
In-Reply-To: <3A54A789.1070608@redhat.com>
Message-ID: <Pine.GSO.3.96.1010104180809.4624G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 4 Jan 2001, Joe deBlaquiere wrote:

> If the BFD stuff is built with any support for 64 bit (even as an 
> optional target) it will maintain all addresses as 64-bit values, even 
> if the file is 32 bit.

 I do consider it fine BFD handles all addresses as 64-bit internally.  I
just think it should truncate them to 32-bits upon printing (and always
whenever appropriate) when the selected target is 32-bit.  It does so (it
has to!) for output anyway, so what's the deal? 

> If you're really only doing 32-bit mips you might consider removing the 
> 64 bit targets in the config.bfd... I think that will solve the problems.

 Nope, I insist 32-bit targets need to work correctly regardless of
whether there are any 64-bit ones supported by a particular BFD binary or
not.  Do you think elf32-i386 should switch to printing 64-bit addresses
if elf64-alpha is also supported by a given configuration of BFD?  I
don't.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
