Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6I3r2e26447
	for linux-mips-outgoing; Tue, 17 Jul 2001 20:53:02 -0700
Received: from netbank.com.br (IDENT:postfix@garrincha.netbank.com.br [200.203.199.88])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6I3r0V26441
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 20:53:01 -0700
Received: from brinquedo.distro.conectiva (1-102.ctame701-2.telepar.net.br [200.181.138.102])
	by netbank.com.br (Postfix) with ESMTP
	id D64124680A; Wed, 18 Jul 2001 00:52:08 -0300 (BRST)
Received: by brinquedo.distro.conectiva (Postfix, from userid 501)
	id AB02DCC25; Wed, 18 Jul 2001 00:52:55 -0300 (BRT)
Date: Wed, 18 Jul 2001 00:52:55 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Ilya Volynets <ilya@theIlya.com>, linux-mips@oss.sgi.com
Subject: Re: Updates on RedHat 7.1/mips
Message-ID: <20010718005255.R10373@conectiva.com.br>
References: <3B4573B8.9F89022B@mips.com> <20010717125027.A22672@nevyn.them.org> <20010717125718.A24725@lucon.org> <01071713090011.04620@gateway> <20010717131146.A24907@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010717131146.A24907@lucon.org>; from hjl@lucon.org on Tue, Jul 17, 2001 at 01:11:46PM -0700
X-Url: http://advogato.org/person/acme
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Em Tue, Jul 17, 2001 at 01:11:46PM -0700, H . J . Lu escreveu:
> On Tue, Jul 17, 2001 at 01:09:00PM -0700, Ilya Volynets wrote:
> > 
> > I was working on it a while ago, and here are few pointers:
> > Some tools have to be run natively (i.e. xkbcomp), but also need to
> > be installed on target. I din't find a rule that does both. I think new
> > rule is needed.
> 
> I am aware of those. I want to delay it as much as I can.

recent messages to the XFree86 mailing lists has the recipe to x-compile
XFree86, IIRC Keith Packard did the work
 
> > 
> > gcc-3.0 crashes when compiling some parts of Xserver and Xlib,
> > with very obscure bug. Minimal test case I came up with is
> > ~45(!) lines long. Keith filed report to gcc team on my behalf,
> > but there seems to be no responce. I do not know if your
> > gcc has same problem, but someone mentioned similar problem
> > with 2.9x.y series on this list not so long ago.
> > 
> 
> Don't bother with gcc-3.0. I won't use it myself for building X.
> 
> 
> H.J.

-- 


                        - Arnaldo
