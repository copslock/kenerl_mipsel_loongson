Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2003 08:48:58 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:16334 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225200AbTG3Hs4>; Wed, 30 Jul 2003 08:48:56 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id JAA26912;
	Wed, 30 Jul 2003 09:47:35 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 30 Jul 2003 09:47:34 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Keith M Wesolowski <wesolows@foobazco.org>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20030730021249.GC7366@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030730094217.26733A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 30 Jul 2003, Ralf Baechle wrote:

> On Wed, Jul 23, 2003 at 12:51:37AM +0200, Maciej W. Rozycki wrote:
> 
> > > >  Well, as long as one get that far to run a configuration script (BTW,
> > > > what menus are you referring to? -- I haven't seen any).  Right now that's
> > > 
> > > It will flash up on your retina and stay there for a while, waiting for your
> > > response, if you run `make oldconfig' :-)
> > 
> >  Hmm, now I have to speed up my transition to 2.6 to have my curiosity
> > appeased...  Hopefully I won't get disappointed.
> 
> Well, 2.6 won't be the big leap that 2.4 was for most MIPS users, more
> evolution than revolution ...

 I'm referring to that menus that will flash up on my retina (if I got the
meaning right). ;-)

 Anyway, it looks like some additional checks and possibly fixes will be
needed for 64-bit configurations (including changes to my pending
patches).  And last time I checked 2.5.x had showstopper problems for me
elsewhere (IDE -- I still use it here and there) -- I doubt they have been
fixed in the recent 2.6 -test releases. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
