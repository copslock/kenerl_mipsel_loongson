Received:  by oss.sgi.com id <S553975AbRAPXEa>;
	Tue, 16 Jan 2001 15:04:30 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:33550 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553970AbRAPXEU>;
	Tue, 16 Jan 2001 15:04:20 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8062C827; Wed, 17 Jan 2001 00:04:17 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id E5ED7F597; Wed, 17 Jan 2001 00:03:01 +0100 (CET)
Date:   Wed, 17 Jan 2001 00:03:01 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
Message-ID: <20010117000301.A18003@paradigm.rfc822.org>
References: <20010116194817.B12610@paradigm.rfc822.org> <Pine.GSO.3.96.1010116204822.5546Y-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010116204822.5546Y-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jan 16, 2001 at 08:52:40PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 16, 2001 at 08:52:40PM +0100, Maciej W. Rozycki wrote:
> On Tue, 16 Jan 2001, Florian Lohoff wrote:
> 
> > Once removed all the debugging stuff even without the mem= parm - Interesting.
> 
>  It's weird.  Could you please check it's repeatable?  It might be the
> debugging stuff does destructive actions or we trigger an unrelated
> problem such as a compiler/assembler/linker bug.

Works reliably afterwards ...

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
