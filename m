Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g46M5lwJ029744
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 6 May 2002 15:05:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g46M5kV9029743
	for linux-mips-outgoing; Mon, 6 May 2002 15:05:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from coplin09.mips.com ([80.63.7.130])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g46M5ewJ029739
	for <linux-mips@oss.sgi.com>; Mon, 6 May 2002 15:05:41 -0700
Received: (from hartvige@localhost)
	by coplin09.mips.com (8.11.6/8.11.6) id g46M6ge17977;
	Tue, 7 May 2002 00:06:42 +0200
From: Hartvig Ekner <hartvige@mips.com>
Message-Id: <200205062206.g46M6ge17977@coplin09.mips.com>
Subject: Re: zsh on console
To: hjl@lucon.org (H . J . Lu)
Date: Tue, 7 May 2002 00:06:42 +0200 (CEST)
Cc: kevink@mips.com (Kevin D. Kissell), kjelde@mips.com (Kjeld Borch Egevang),
   linux-mips@oss.sgi.com (linux-mips mailing list)
In-Reply-To: <20020506121606.B28872@lucon.org> from "H . J . Lu" at May 06, 2002 12:16:06 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

H . J . Lu writes:
> 
> On Mon, May 06, 2002 at 02:57:28PM +0200, Kevin D. Kissell wrote:
> > > When I run zsh on the console (serial interface) the process hangs. I can 
> > > login with /bin/bash, but when I start /bin/zsh it waits forever. I can 
> > > interrupt the process and regain control.
> > > 
> > > It's only related to the console. If I login with telnet it works just 
> > > fine.
> > > 
> > > Any idea, what could be wrong?
> > 
> > I don't know what it would be specifically, but having
> > dealt with similar problems on other Unix systems,
> > it's proably the case that zsh uses a particular tty
> > mode that isn't correctly supported by the serial
> > console driver, either due to a bug in the driver or
> > due to a conflict with some other feature enabled
> > on the console port.  The next step to take would
> > be to run "stty -all" under /bin/bash and under
> > /bin/zsh on a telnet session, and compare the 
> > outputs.
> 
> That sounds like a zsh bug I fixed. Please try zsh 3.0.8-8.1 in my RedHat 7.1
> port and let me know if it doesn't work for you.

You only have the source RPM on OSS?
I believe we compiled from another SRC RPM: zsh-4.0.4-5.src.rpm. 

What was your fix? 

/Hartvig
