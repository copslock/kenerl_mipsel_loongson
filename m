Received:  by oss.sgi.com id <S42249AbQJKWnm>;
	Wed, 11 Oct 2000 15:43:42 -0700
Received: from u-252.karlsruhe.ipdial.viaginterkom.de ([62.180.18.252]:6663
        "EHLO u-252.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42239AbQJKWnD>; Wed, 11 Oct 2000 15:43:03 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870101AbQJKPOt>;
        Wed, 11 Oct 2000 17:14:49 +0200
Date:   Wed, 11 Oct 2000 17:14:49 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith Owens <kaos@melbourne.sgi.com>
Cc:     Cort Dougan <cort@fsmlabs.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: modutils bug? 'if' clause executes incorrectly
Message-ID: <20001011171449.A19344@bacchus.dhis.org>
References: <20001010224317.I733@hq.fsmlabs.com> <9251.971242560@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <9251.971242560@kao2.melbourne.sgi.com>; from kaos@melbourne.sgi.com on Wed, Oct 11, 2000 at 04:36:00PM +1100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Keith,

> >I'm finding that in a Linux/MIPS module the test case attached executes the
> >'if' clause in
> 
> Almost certainly nothing to do with modutils, insmod just relocates and
> loads the program.  The only possible modutil problems are an
> unexpected relocation being emitted by binutils or insmod not handling
> a valid relocation correctly.  Compile with -g then do "objdump -rS
> object.o".  What does the offending section of code look like,
> including the relocations?

For such occassions I would like to see some debugging functionality in
modutils which allows dumping the relocated disk image as it would be
loaded into the kernel into a disk image which then could be examined
with objdump etc. for potencial problems.

  Ralf
