Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3NMxDwJ003221
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Apr 2002 15:59:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3NMxClM003220
	for linux-mips-outgoing; Tue, 23 Apr 2002 15:59:12 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc51.attbi.com (rwcrmhc51.attbi.com [204.127.198.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3NMx8wJ003217
	for <linux-mips@oss.sgi.com>; Tue, 23 Apr 2002 15:59:08 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020423225926.LQQH9486.rwcrmhc51.attbi.com@ocean.lucon.org>;
          Tue, 23 Apr 2002 22:59:26 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 6DB28125C7; Tue, 23 Apr 2002 15:59:25 -0700 (PDT)
Date: Tue, 23 Apr 2002 15:59:25 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Hartvig Ekner <hartvige@mips.com>, linux-mips@oss.sgi.com
Subject: Updates for RedHat 7.1/mips
Message-ID: <20020423155925.A8846@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 22, 2002 at 08:38:49PM +0200, Hartvig Ekner wrote:
> Hi,
> 
> H . J . Lu writes:
> > 
> > On Mon, Apr 22, 2002 at 06:55:14PM +0200, Hartvig Ekner wrote:
> > > Hi H.J,
> > > 
> > > No, I did not compile myself, but used your binary (except for cracklib,
> > > where I used our natively compiled package instead). But I did replace
> > > ALL new updated packages at once during the upgrade.
> > > 
> > > However, I have also tried to install (-U) rpm*rpm and the popt rpm on a
> > > working system based on your original packages, and voila: the same error
> > > appears. So it does appear to be linked to the rpm RPM package.
> > > 
> > > The grep you asked for returns:
> > 
> > Thanks. I will fix those among other bugs I have been working on.
> 
> Great, thanks. Can you let me know as soon as the RPM problem has been fixed,
> so that I can continue the update of the installation images? BTW, are the
> other bugs you're working on something to wait for in this regard or not?
> 

I updated glibc, python, gcc, gdb, rpm, openssl, binutils and toolchain at

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/

Let know know if there are any problems.


H.J.
