Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62IpdRw009822
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 11:51:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62Ipdbb009821
	for linux-mips-outgoing; Tue, 2 Jul 2002 11:51:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc52.attbi.com (rwcrmhc52.attbi.com [216.148.227.88])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62IpaRw009793
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 11:51:36 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc52.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020702185526.MDMA8262.rwcrmhc52.attbi.com@ocean.lucon.org>;
          Tue, 2 Jul 2002 18:55:26 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id F3A75125D3; Tue,  2 Jul 2002 11:55:25 -0700 (PDT)
Date: Tue, 2 Jul 2002 11:55:25 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Greg Lindahl <lindahl@keyresearch.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: MIPS GOT overflow in gcc 3.2.
Message-ID: <20020702115525.A16419@lucon.org>
References: <20020701184640.A2043@lucon.org> <1025575632.30577.64.camel@ghostwheel.cygnus.com> <1025579401.1785.0.camel@ghostwheel.cygnus.com> <20020702114843.B1896@wumpus.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020702114843.B1896@wumpus.internal.keyresearch.com>; from lindahl@keyresearch.com on Tue, Jul 02, 2002 at 11:48:43AM -0700
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 02, 2002 at 11:48:43AM -0700, Greg Lindahl wrote:
> > AFAIK it happens to mozilla as well.
> 
> On AlphaLinux, we eventually acquired multigot. Many large apps were
> tripping on this problem; many big C++ programs essentially use
> whole-program compilation, and many HPC codes link a bazillion large
> libraries. I don't understand if -fpic or -fPIC are as good of a
> solution as multigot.

FYI, it is -Wa,-xgot, not -fPIC. multigot may be better. But it is not
supported on mips. Until someone adds it, it is not an option.


H.J.
