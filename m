Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g138QlU05654
	for linux-mips-outgoing; Sun, 3 Feb 2002 00:26:47 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g138QjA05651
	for <linux-mips@oss.sgi.com>; Sun, 3 Feb 2002 00:26:45 -0800
Received: from drow by nevyn.them.org with local (Exim 3.34 #1 (Debian))
	id 16XH35-0000V1-00; Sun, 03 Feb 2002 02:26:51 -0500
Date: Sun, 3 Feb 2002 02:26:51 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: weasel@cs.stanford.edu
Cc: Eric Christopher <echristo@redhat.com>, binutils@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: me vs gas mips64 relocation
Message-ID: <20020203022651.A1903@nevyn.them.org>
Mail-Followup-To: weasel@cs.stanford.edu,
	Eric Christopher <echristo@redhat.com>, binutils@sources.redhat.com,
	linux-mips@oss.sgi.com
References: <m2vgdh5n9s.fsf@meer.net> <m2pu3o6i1g.fsf@meer.net> <1012598592.1689.33.camel@ghostwheel.cygnus.com> <m24rkz5fz1.fsf@meer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m24rkz5fz1.fsf@meer.net>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Feb 02, 2002 at 08:47:30PM -0800, d p chang wrote:
> Eric Christopher <echristo@redhat.com> writes:
> 
> > > ideas? (other than for me to take the crack pipe out of my ass)
> > 
> > You can try to help Thiemo Seufer finish n32 and n64 support in
> > binutils...
> 
> Is there a todo or something that I could start w/?

Search for TODO in elf64-mips.c, if I recall correctly.  Among other
things PIC support is non-functional.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
