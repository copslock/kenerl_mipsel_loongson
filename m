Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2003 04:27:30 +0100 (BST)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:62081
	"HELO alpha.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225209AbTF3D12>; Mon, 30 Jun 2003 04:27:28 +0100
Received: (qmail 22509 invoked from network); 29 Jun 2003 20:21:44 -0000
Received: from unknown (HELO gateway.total-knowledge.com) (12.234.207.60)
  by alpha.total-knowledge.com with SMTP; 29 Jun 2003 20:21:44 -0000
Received: (qmail 24965 invoked by uid 502); 30 Jun 2003 03:27:25 -0000
Date: Sun, 29 Jun 2003 20:27:25 -0700
From: ilya@theIlya.com
To: Andrew Clausen <clausen@gnu.org>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: ip32 timer setup fix
Message-ID: <20030630032725.GL13617@gateway.total-knowledge.com>
References: <20030630031338.GK13617@gateway.total-knowledge.com> <20030630132841.GD480@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630132841.GD480@gnu.org>
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips

Oops! You are right, of course.
it should be

Index: arch/mips/sgi-ip32/ip32-setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/ip32-setup.c,v
retrieving revision 1.4
diff -u -r1.4 ip32-setup.c
--- arch/mips/sgi-ip32/ip32-setup.c     14 Apr 2003 16:33:24 -0000      1.4
+++ arch/mips/sgi-ip32/ip32-setup.c     30 Jun 2003 03:11:05 -0000
@@ -94,6 +94,7 @@
        rtc_ops = &ip32_rtc_ops;
        board_be_init = ip32_be_init;
        board_time_init = ip32_time_init;
+       board_timer_setup = ip32_timer_setup;
 
        crime_init ();
 }


On Mon, Jun 30, 2003 at 01:28:41PM +0000, Andrew Clausen wrote:
> On Sun, Jun 29, 2003 at 08:13:38PM -0700, ilya@theIlya.com wrote:
> > diff -u -r1.4 ip32-setup.c
> > --- arch/mips/sgi-ip32/ip32-setup.c	14 Apr 2003 16:33:24 -0000	1.4
> > +++ arch/mips/sgi-ip32/ip32-setup.c	30 Jun 2003 03:11:05 -0000
> > @@ -94,6 +94,7 @@
> >  	rtc_ops = &ip32_rtc_ops;
> >  	board_be_init = ip32_be_init;
> >  	board_time_init = ip32_time_init;
> > +	board_timer_setup = ip32_timer_setup();
> >  
> >  	crime_init ();
> >  }
> 
> Without even looking at the code... it looks like those () are wrong.
> (Is board_timer_setup a function pointer?)  I could be talking
> rubbish of course.
> 
> Cheers,
> Andrew
> 
