Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g63Mx0Rw017342
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 3 Jul 2002 15:59:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g63Mx0pO017341
	for linux-mips-outgoing; Wed, 3 Jul 2002 15:59:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-235.ka.dial.de.ignite.net [62.180.196.235])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g63MwrRw017287
	for <linux-mips@oss.sgi.com>; Wed, 3 Jul 2002 15:58:54 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g63N2WB22402;
	Thu, 4 Jul 2002 01:02:32 +0200
Date: Thu, 4 Jul 2002 01:02:32 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: "H. J. Lu" <hjl@lucon.org>, Eric Christopher <echristo@redhat.com>,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>,
   binutils@sources.redhat.com, gcc@gcc.gnu.org
Subject: Re: RFC: Use -Wa,-xgot for Linux/mips (Re: MIPS GOT overflow in gcc 3.2.)
Message-ID: <20020704010232.A21624@dea.linux-mips.net>
References: <20020701184640.A2043@lucon.org> <1025575632.30577.64.camel@ghostwheel.cygnus.com> <1025579401.1785.0.camel@ghostwheel.cygnus.com> <20020703093518.A2401@lucon.org> <20020703164039.GA12583@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020703164039.GA12583@nevyn.them.org>; from dan@debian.org on Wed, Jul 03, 2002 at 12:40:39PM -0400
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 03, 2002 at 12:40:39PM -0400, Daniel Jacobowitz wrote:

> Did you see my message about mixing GOT models?  I'd need Ralf or Eric to
> confirm this, but I'm pretty sure there's a lot of luck involved in
> your workaround.

I've not seen your posting but yes, due to other static objects involved
into linking there definately is luck involved.

  Ralf
