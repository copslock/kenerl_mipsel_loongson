Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76GO3N16912
	for linux-mips-outgoing; Mon, 6 Aug 2001 09:24:03 -0700
Received: from dea.waldorf-gmbh.de (u-243-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.243])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76GO0V16909
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 09:24:00 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f769xDl19762;
	Mon, 6 Aug 2001 11:59:13 +0200
Date: Mon, 6 Aug 2001 11:59:13 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Eric Christopher <echristo@redhat.com>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
Message-ID: <20010806115913.B17179@bacchus.dhis.org>
References: <20010805094806.A3146@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010805094806.A3146@lucon.org>; from hjl@lucon.org on Sun, Aug 05, 2001 at 09:48:06AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Aug 05, 2001 at 09:48:06AM -0700, H . J . Lu wrote:

> I am working with Eric to clean up the Linux/mips configuration in
> gcc 3.x. I'd like to change WCHAR_TYPE from "long int" to "int". They
> are the same on Linux/mips. There won't be any run-time problems. I am
> wondering if there are any compatibility problems at the compile time
> at the source and binary level. For one thing, __WCHAR_TYPE__ will be
> changed from "long int" to "int". The only thing I can think of is
> the C++ libraries. But gcc 3.x doesn't work on Linux/mips. The one
> I am working on will be the first gcc 3.x for Linux/mips. So there
> shouldn't be any problems. Am I right?

The MIPS ABI defines wchar_t to long.  So please go ahead and make the
change.

  Ralf
