Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76GM2h16781
	for linux-mips-outgoing; Mon, 6 Aug 2001 09:22:02 -0700
Received: from dea.waldorf-gmbh.de (u-243-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.243])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76GLxV16778
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 09:22:00 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f76GKoH21156;
	Mon, 6 Aug 2001 18:20:50 +0200
Date: Mon, 6 Aug 2001 18:20:50 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Andreas Jaeger <aj@suse.de>
Cc: "H . J . Lu" <hjl@lucon.org>, Eric Christopher <echristo@redhat.com>,
   gcc@gcc.gnu.org, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
Message-ID: <20010806182050.A21142@bacchus.dhis.org>
References: <20010805094806.A3146@lucon.org> <20010806115913.B17179@bacchus.dhis.org> <hoofptjy6k.fsf@gee.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <hoofptjy6k.fsf@gee.suse.de>; from aj@suse.de on Mon, Aug 06, 2001 at 12:10:59PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 06, 2001 at 12:10:59PM +0200, Andreas Jaeger wrote:

> >> I am working with Eric to clean up the Linux/mips configuration in
> >> gcc 3.x. I'd like to change WCHAR_TYPE from "long int" to "int". They
> >> are the same on Linux/mips. There won't be any run-time problems. I am
> >> wondering if there are any compatibility problems at the compile time
> >> at the source and binary level. For one thing, __WCHAR_TYPE__ will be
> >> changed from "long int" to "int". The only thing I can think of is
> >> the C++ libraries. But gcc 3.x doesn't work on Linux/mips. The one
> >> I am working on will be the first gcc 3.x for Linux/mips. So there
> >> shouldn't be any problems. Am I right?
> >
> > The MIPS ABI defines wchar_t to long.  So please go ahead and make the
> > change.
> 
> I'm confused.  The ABI defines it to be long - and he should change it
> nevertheless?

It's defined as a "long", not "long int" so we're obviously off by a tiny
bit.

H.J. - why did you want to change this type anyway?  "long int" and "int"
both have the same size and signedness so there isn't any incompatibility
anyway?

  Ralf
