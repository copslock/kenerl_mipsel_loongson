Received:  by oss.sgi.com id <S553831AbRAPQoz>;
	Tue, 16 Jan 2001 08:44:55 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:4362 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553825AbRAPQom>;
	Tue, 16 Jan 2001 08:44:42 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 2DA96825; Tue, 16 Jan 2001 17:44:25 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id D459FF597; Tue, 16 Jan 2001 17:44:18 +0100 (CET)
Date:   Tue, 16 Jan 2001 17:44:18 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
Message-ID: <20010116174418.C7327@paradigm.rfc822.org>
References: <20010116135737.A13302@bacchus.dhis.org> <Pine.GSO.3.96.1010116170209.5546K-100000@delta.ds2.pg.gda.pl> <20010116142449.B13302@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010116142449.B13302@bacchus.dhis.org>; from ralf@oss.sgi.com on Tue, Jan 16, 2001 at 02:24:49PM -0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 16, 2001 at 02:24:49PM -0200, Ralf Baechle wrote:
> 
> The Indy has it's memory starting at phys. 0x08000000; a part of it is also
> mirrored at physical address zero.  So in case of an Indy the totalpages
> number should indicate 128mb too much which means that Flo's machine should
> have only 128mb real memory.  Right Florian?
> 

Correct "only" 128Mb :)

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
