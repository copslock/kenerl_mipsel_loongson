Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GDZtRw030967
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 06:35:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GDZsZm030966
	for linux-mips-outgoing; Tue, 16 Jul 2002 06:35:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crack.them.org (mail@crack.them.org [65.125.64.184])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GDZZRw030954;
	Tue, 16 Jul 2002 06:35:35 -0700
Received: from dsl254-114-096.nyc1.dsl.speakeasy.net ([216.254.114.96] helo=nevyn.them.org)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17USYp-0006bZ-00; Tue, 16 Jul 2002 08:40:16 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17USYo-00053q-00; Tue, 16 Jul 2002 09:40:14 -0400
Date: Tue, 16 Jul 2002 09:40:14 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, "H. J. Lu" <hjl@lucon.org>,
   linux-mips@oss.sgi.com
Subject: Re: Personality
Message-ID: <20020716134014.GA19350@nevyn.them.org>
References: <3D33DAB2.353A4399@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D33DAB2.353A4399@mips.com>
User-Agent: Mutt/1.5.1i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 16, 2002 at 10:34:58AM +0200, Carsten Langgaard wrote:
> The include/linux/personality.h file has changed between the 2.4.3 and
> the 2.4.18 kernel.
> Now there is a define of personality (#define personality(pers) (pers &
> PER_MASK), but that breaks things for the users, if they include this
> file.
> The user wishes to call the glibc personality function (which do the
> syscall), and not use the above definition.
> 
> So I guess we need a "#ifdef __KERNEL__" around some of the code in
> include/linux/personality.h (at least around the define of personality),
> which then has to go into the glibc kernel header files.
> 
> Any comments ?

Why is the user program including <linux/personality.h> in the first
place?

The right thing to do here is to provide the necessary bits in a glibc
header, probably in bits/personality.h or so.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
