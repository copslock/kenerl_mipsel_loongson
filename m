Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LKIDK11002
	for linux-mips-outgoing; Mon, 21 Jan 2002 12:18:13 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0LKIBP10999
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 12:18:11 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 6F7A8125C0; Mon, 21 Jan 2002 11:18:08 -0800 (PST)
Date: Mon, 21 Jan 2002 11:18:08 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Kevin D. Kissell" <kevink@mips.com>,
   Machida Hiroyuki <machida@sm.sony.co.jp>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
Message-ID: <20020121111808.A28676@lucon.org>
References: <003701c1a25f$8abfc120$0deca8c0@Ulysses> <Pine.GSO.3.96.1020121144413.22392C-100000@delta.ds2.pg.gda.pl> <20020121102455.A27606@lucon.org> <m3zo37tutx.fsf@myware.mynet> <20020121105253.B28087@lucon.org> <20020121135910.A26790@nevyn.them.org> <20020121110533.B28350@lucon.org> <20020121140932.A27328@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020121140932.A27328@nevyn.them.org>; from dan@debian.org on Mon, Jan 21, 2002 at 02:09:32PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jan 21, 2002 at 02:09:32PM -0500, Daniel Jacobowitz wrote:
> 
> When is the thread pointer accessed?  My understanding was that it
> would be needed for the lifetime of the application, in functions
> called from the application.  In that case its value can not be
> trusted.

You are right. If we use $23 as the thread pointer, we have to change
the ABI. Any assembler codes have to be checked.


H.J.
