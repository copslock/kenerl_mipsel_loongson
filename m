Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g46N7jwJ030468
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 6 May 2002 16:07:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g46N7jUs030467
	for linux-mips-outgoing; Mon, 6 May 2002 16:07:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc52.attbi.com (rwcrmhc52.attbi.com [216.148.227.88])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g46N7ewJ030460
	for <linux-mips@oss.sgi.com>; Mon, 6 May 2002 16:07:40 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc52.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020506230654.FDUX4412.rwcrmhc52.attbi.com@ocean.lucon.org>;
          Mon, 6 May 2002 23:06:54 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 0467B125C0; Mon,  6 May 2002 16:06:51 -0700 (PDT)
Date: Mon, 6 May 2002 16:06:51 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Hartvig Ekner <hartvige@mips.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>,
   Kjeld Borch Egevang <kjelde@mips.com>,
   linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: Re: zsh on console
Message-ID: <20020506160651.A310@lucon.org>
References: <20020506121606.B28872@lucon.org> <200205062206.g46M6ge17977@coplin09.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200205062206.g46M6ge17977@coplin09.mips.com>; from hartvige@mips.com on Tue, May 07, 2002 at 12:06:42AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, May 07, 2002 at 12:06:42AM +0200, Hartvig Ekner wrote:
> H . J . Lu writes:
> > 
> > On Mon, May 06, 2002 at 02:57:28PM +0200, Kevin D. Kissell wrote:
> > > > When I run zsh on the console (serial interface) the process hangs. I can 
> > > > login with /bin/bash, but when I start /bin/zsh it waits forever. I can 
> > > > interrupt the process and regain control.
> > > > 
> > > > It's only related to the console. If I login with telnet it works just 
> > > > fine.
> > > > 
> > > > Any idea, what could be wrong?
> > > 
> > > I don't know what it would be specifically, but having
> > > dealt with similar problems on other Unix systems,
> > > it's proably the case that zsh uses a particular tty
> > > mode that isn't correctly supported by the serial
> > > console driver, either due to a bug in the driver or
> > > due to a conflict with some other feature enabled
> > > on the console port.  The next step to take would
> > > be to run "stty -all" under /bin/bash and under
> > > /bin/zsh on a telnet session, and compare the 
> > > outputs.
> > 
> > That sounds like a zsh bug I fixed. Please try zsh 3.0.8-8.1 in my RedHat 7.1
> > port and let me know if it doesn't work for you.
> 
> You only have the source RPM on OSS?

I didn't add cross compile support for zsh. You have to compile it natively.

> I believe we compiled from another SRC RPM: zsh-4.0.4-5.src.rpm. 

zsh-4.0.4-5 will be in my RedHat 7.3 port.

> 
> What was your fix? 
> 

zsh-3.0.8-open.patch is in baseline.tar.bz2.


H.J.
