Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2003 15:07:58 +0100 (BST)
Received: from p508B60E0.dip.t-dialin.net ([IPv6:::ffff:80.139.96.224]:43923
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225202AbTG3OHz>; Wed, 30 Jul 2003 15:07:55 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6UE7mx6026551;
	Wed, 30 Jul 2003 16:07:48 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6UE7mYC026550;
	Wed, 30 Jul 2003 16:07:48 +0200
Date: Wed, 30 Jul 2003 16:07:48 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Keith M Wesolowski <wesolows@foobazco.org>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030730140748.GC26372@linux-mips.org>
References: <20030730021249.GC7366@linux-mips.org> <Pine.GSO.3.96.1030730094217.26733A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030730094217.26733A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 30, 2003 at 09:47:34AM +0200, Maciej W. Rozycki wrote:

> > > > It will flash up on your retina and stay there for a while, waiting
> > > > for your response, if you run `make oldconfig' :-)
> > > 
> > >  Hmm, now I have to speed up my transition to 2.6 to have my curiosity
> > > appeased...  Hopefully I won't get disappointed.
> > 
> > Well, 2.6 won't be the big leap that 2.4 was for most MIPS users, more
> > evolution than revolution ...
> 
>  I'm referring to that menus that will flash up on my retina (if I got the
> meaning right). ;-)

Oh :-)

>  Anyway, it looks like some additional checks and possibly fixes will be
> needed for 64-bit configurations (including changes to my pending
> patches).  And last time I checked 2.5.x had showstopper problems for me
> elsewhere (IDE -- I still use it here and there) -- I doubt they have been
> fixed in the recent 2.6 -test releases. 

True, 2.6 isn't yet a great stability experience ...

  Ralf
