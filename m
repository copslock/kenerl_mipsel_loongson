Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76GTll17321
	for linux-mips-outgoing; Mon, 6 Aug 2001 09:29:47 -0700
Received: from dea.waldorf-gmbh.de (u-243-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.243])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76GTiV17286
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 09:29:45 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f76GShK21186;
	Mon, 6 Aug 2001 18:28:43 +0200
Date: Mon, 6 Aug 2001 18:28:43 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Eric Christopher <echristo@redhat.com>
Cc: Andreas Jaeger <aj@suse.de>, "H . J . Lu" <hjl@lucon.org>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
Message-ID: <20010806182843.B21142@bacchus.dhis.org>
References: <20010805094806.A3146@lucon.org> <20010806115913.B17179@bacchus.dhis.org> <hoofptjy6k.fsf@gee.suse.de> <997108072.1773.10.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <997108072.1773.10.camel@ghostwheel.cygnus.com>; from echristo@redhat.com on Mon, Aug 06, 2001 at 03:27:49PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 06, 2001 at 03:27:49PM +0100, Eric Christopher wrote:

> > > The MIPS ABI defines wchar_t to long.  So please go ahead and make the
> > > change.
> > 
> > I'm confused.  The ABI defines it to be long - and he should change it
> > nevertheless?
> > 
> 
> Also depends on which MIPS ABI :)  I think it is ok to change though.

MIPS psABI 3.0.

  Ralf
