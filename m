Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5KAP7nC003612
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 20 Jun 2002 03:25:07 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5KAP7ca003611
	for linux-mips-outgoing; Thu, 20 Jun 2002 03:25:07 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-7.ka.dial.de.ignite.net [62.180.196.7])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5KAOwnC003581
	for <linux-mips@oss.sgi.com>; Thu, 20 Jun 2002 03:25:00 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5KAPQp05042;
	Thu, 20 Jun 2002 12:25:26 +0200
Date: Thu, 20 Jun 2002 12:25:26 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Paul Jackson <pj@engr.sgi.com>
Cc: William Jhun <wjhun@ayrnetworks.com>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] include/asm-mips/pci.h
Message-ID: <20020620122525.B4835@dea.linux-mips.net>
References: <20020619112207.B6057@ayrnetworks.com> <Pine.LNX.4.44.0206191326560.18638-100000@turbo-linux.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0206191326560.18638-100000@turbo-linux.engr.sgi.com>; from pj@engr.sgi.com on Wed, Jun 19, 2002 at 01:38:52PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 19, 2002 at 01:38:52PM -0700, Paul Jackson wrote:

> Yes - leave them out (speaking out of context here - hopefully still
> useful).
> 
> Remove the warnings instead.
> 
> I've gotten in the habit of having the following form to
> optional code logic:
> 
> In some header file foobar.h:
> 
>     #if CONFIG_FOOBAR
>     #define init_foobar(x) do {		\
> 	    int f = 2 * (x);		\
> 	    foobar_initialize(f);	\
> 	| while (0)
>     #else
>     #define init_foobar(x) do {} while (0)
>     #endif
> 
> I don't see any warnings from this, and it provides just
> the right sort of syntax wrapper on the macro init_foobar(),
> forcing it to be a single statement, regardless of context,
> while providing a nested block context for any local variables.

Note your variant doesn't deal with side effects of the argument expression
x (basically none of the equivalent constructions in the kernels do!) which
is why our code in question does something like this:

     #if CONFIG_FOOBAR
     #define init_foobar(x) do {               \
           int f = 2 * (x);            \
           foobar_initialize(f);       \
       | while (0)
     #else
     #define init_foobar(x) do { (x); } while (0)
     #endif

This can potencially expand into something like:

     do { 42; } while(0)

which will result in warnings.  The solution is:

     #define init_foobar(x) do { (void) (x); } while (0)

  Ralf
