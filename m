Received:  by oss.sgi.com id <S42266AbQGSOHC>;
	Wed, 19 Jul 2000 07:07:02 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:53935 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42257AbQGSOGc>;
	Wed, 19 Jul 2000 07:06:32 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA23335;
	Wed, 19 Jul 2000 16:04:58 +0200 (MET DST)
Date:   Wed, 19 Jul 2000 16:04:58 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     "J. Scott Kasten" <jsk@tetracon-eng.net>,
        Keith M Wesolowski <wesolows@foobazco.org>,
        linux-mips@oss.sgi.com
Subject: Re: Simple Linux/MIPS 0.2b
In-Reply-To: <20000714005155.C8972@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1000719160110.21239D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 14 Jul 2000, Ralf Baechle wrote:

> We have various known problems with the various binutils version around.
> We're working on getting a current snapshot of binutils working
> properly but right now we still have various problems, therefore
> egcs 1.0.3a + binutils 2.8.1 is still the recommended version.

 I have binutils 2.10 and gcc 2.95.2 which appear to be stable, i.e. I
haven't observed any problems recently.  I may publish patches if anyone
is interested.  I may see if I can arrange to publish RPM packages as
well.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
