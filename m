Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g46JExwJ028153
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 6 May 2002 12:14:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g46JEwBZ028152
	for linux-mips-outgoing; Mon, 6 May 2002 12:14:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc51.attbi.com (rwcrmhc51.attbi.com [204.127.198.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g46JEswJ028142
	for <linux-mips@oss.sgi.com>; Mon, 6 May 2002 12:14:55 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020506191608.VMEB9799.rwcrmhc51.attbi.com@ocean.lucon.org>;
          Mon, 6 May 2002 19:16:08 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 0BBBB125C0; Mon,  6 May 2002 12:16:06 -0700 (PDT)
Date: Mon, 6 May 2002 12:16:06 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Kjeld Borch Egevang <kjelde@mips.com>,
   linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: Re: zsh on console
Message-ID: <20020506121606.B28872@lucon.org>
References: <Pine.LNX.4.44.0205061440210.21711-100000@coplin19.mips.com> <01db01c1f4fd$94f6ccb0$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01db01c1f4fd$94f6ccb0$10eca8c0@grendel>; from kevink@mips.com on Mon, May 06, 2002 at 02:57:28PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, May 06, 2002 at 02:57:28PM +0200, Kevin D. Kissell wrote:
> > When I run zsh on the console (serial interface) the process hangs. I can 
> > login with /bin/bash, but when I start /bin/zsh it waits forever. I can 
> > interrupt the process and regain control.
> > 
> > It's only related to the console. If I login with telnet it works just 
> > fine.
> > 
> > Any idea, what could be wrong?
> 
> I don't know what it would be specifically, but having
> dealt with similar problems on other Unix systems,
> it's proably the case that zsh uses a particular tty
> mode that isn't correctly supported by the serial
> console driver, either due to a bug in the driver or
> due to a conflict with some other feature enabled
> on the console port.  The next step to take would
> be to run "stty -all" under /bin/bash and under
> /bin/zsh on a telnet session, and compare the 
> outputs.

That sounds like a zsh bug I fixed. Please try zsh 3.0.8-8.1 in my RedHat 7.1
port and let me know if it doesn't work for you.



H.J.
