Received:  by oss.sgi.com id <S42199AbQGTNeO>;
	Thu, 20 Jul 2000 06:34:14 -0700
Received: from u-51.karlsruhe.ipdial.viaginterkom.de ([62.180.18.51]:32775
        "EHLO u-51.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42209AbQGTNde>; Thu, 20 Jul 2000 06:33:34 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S639437AbQGTM1r>;
        Thu, 20 Jul 2000 14:27:47 +0200
Date:   Thu, 20 Jul 2000 14:27:47 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     "J. Scott Kasten" <jsk@tetracon-eng.net>,
        Keith M Wesolowski <wesolows@foobazco.org>,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Simple Linux/MIPS 0.2b
Message-ID: <20000720142747.C26191@bacchus.dhis.org>
References: <20000714005155.C8972@bacchus.dhis.org> <Pine.GSO.3.96.1000719160110.21239D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.3.96.1000719160110.21239D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jul 19, 2000 at 04:04:58PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jul 19, 2000 at 04:04:58PM +0200, Maciej W. Rozycki wrote:

> > We have various known problems with the various binutils version around.
> > We're working on getting a current snapshot of binutils working
> > properly but right now we still have various problems, therefore
> > egcs 1.0.3a + binutils 2.8.1 is still the recommended version.
> 
>  I have binutils 2.10 and gcc 2.95.2 which appear to be stable, i.e. I
> haven't observed any problems recently.  I may publish patches if anyone
> is interested.  I may see if I can arrange to publish RPM packages as
> well.

Anyway, have you tried to rebuild an entire Linux distribution with your
toolset, including kernel, static (Like rpm or ldconfig) and dynamic PIC
code?  If that was successful I'd really like to recommend your toolset
as the new standard - especially binutils 2.8.1 are just too rotten.
Example:

[ralf@indy /tmp]$ echo 'main(){}' > c.c;gcc -o c c.c -lm -lieee
collect2: ld terminated with signal 11 [Segmentation fault], core dumped

This nukes binutils 2.8.1 reliably ...  The problem is extracted from the
INN build but also affects a few more packages.

  Ralf
