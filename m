Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 16:21:26 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:55427 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225072AbTGPPVY>; Wed, 16 Jul 2003 16:21:24 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA28437;
	Wed, 16 Jul 2003 17:21:20 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 16 Jul 2003 17:21:20 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: linux-mips@linux-mips.org
Subject: Re: sudo oops on mips64 linux_2_4
In-Reply-To: <20030716142136.GA13810@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1030716165657.25959C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 16 Jul 2003, Florian Lohoff wrote:

> >  Please pass it through ksymoops for more details.  Version 2.4.9 should
> > work just fine for mips64.
> 
> This looks still broken - Giving the vmlinux file to ksymoops makes it
> even worse - tons or errors.
> 
> ksymoops 2.4.8 on mips 2.4.19-r5k-ip22.  Options used
>      -v /dev/null (specified)
>      -k /dev/null (specified)
>      -l /dev/null (specified)
>      -o /dev/null (specified)
>      -m /home/flo/System.map (specified)

 Hmm, I would use "-V -K -L -O -m /home/flo/System.map" instead. ;-)  And
also "-t elf64-tradbigmips -a mips:5000" as you really want 64-bit
addresses and opcodes beyond R3k (and your ksymoops isn't configured to
use a 64-bit target by default).  Using vmlinux might give additional
information beyond what System.map can provide and it should work just
fine once right options are passed to ksymoops -- I used to get correct
output with no warnings at all. 

 At least we know the error is in drivers/video/fbmem.c:fbmem_read_proc() 
because of buf being null.  But please retry with the above options to get
some addresses decoded. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
