Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57IKFQ00837
	for linux-mips-outgoing; Thu, 7 Jun 2001 11:20:15 -0700
Received: from foghorn.airs.com (IDENT:qmailr@foghorn.airs.com [63.201.54.26])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57IKEh00830
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 11:20:14 -0700
Received: (qmail 22746 invoked by uid 10); 7 Jun 2001 18:20:09 -0000
Received: (qmail 24662 invoked by uid 269); 7 Jun 2001 18:20:05 -0000
Mail-Followup-To: ac131313@cygnus.com,
  gdb@sourceware.cygnus.com,
  binutils@sourceware.cygnus.com,
  linux-mips@oss.sgi.com,
  hjl@lucon.org
From: Ian Lance Taylor <ian@zembu.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Andrew Cagney <ac131313@cygnus.com>, GDB <gdb@sourceware.cygnus.com>,
   binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: stabs or ecoff for Linux/mips
References: <20010607093332.C13198@lucon.org> <3B1FC23D.3020900@cygnus.com>
	<20010607111324.C15440@lucon.org>
Date: 07 Jun 2001 11:20:05 -0700
In-Reply-To: <20010607111324.C15440@lucon.org>
Message-ID: <si4rtsp2y2.fsf@daffy.airs.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" <hjl@lucon.org> writes:

> On Thu, Jun 07, 2001 at 02:04:45PM -0400, Andrew Cagney wrote:
> > dwarf2
> > stabs
> > not ecoff (er, isn't ecoff an object format like coff? I guess you mean 
> > something like Dwarf1)

ECOFF is both an object file format and a debugging format.  Irix (at
least Irix 5) uses the ECOFF debugging format with the ELF object file
format (ECOFF smuggled in ELF).

The ECOFF debugging format can also be called mdebug or Third Eye, but
most people simply call it ECOFF.

Ian
