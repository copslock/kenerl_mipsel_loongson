Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DFGq308882
	for linux-mips-outgoing; Thu, 13 Sep 2001 08:16:52 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DFGpe08878
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 08:16:51 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 70B37125C3; Thu, 13 Sep 2001 08:16:45 -0700 (PDT)
Date: Thu, 13 Sep 2001 08:16:45 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Kjeld Borch Egevang <kjelde@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Error in gcc version 2.96 20000731
Message-ID: <20010913081645.C24910@lucon.org>
References: <3BA0BF6E.2010300@mips.com> <Pine.GSO.3.96.1010913171138.4511A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010913171138.4511A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Sep 13, 2001 at 05:14:45PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Sep 13, 2001 at 05:14:45PM +0200, Maciej W. Rozycki wrote:
> On Thu, 13 Sep 2001, Kjeld Borch Egevang wrote:
> 
> > I discovered an optimization error in the current gcc for MIPS.
> 
>  Is 2.96 20000731 current?  I thought 3.0.1 is.
> 

gcc 3.0.1 lacks many patches in my gcc 2.96 and gcc 3.x. I am trying to
get them backported to 3.0.x.


H.J.
