Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7D5Dwc29520
	for linux-mips-outgoing; Sun, 12 Aug 2001 22:13:58 -0700
Received: from gateway.total-knowledge.com (c1213523-b.smateo1.sfba.home.com [24.1.66.97])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7D5Dvj29517
	for <linux-mips@oss.sgi.com>; Sun, 12 Aug 2001 22:13:57 -0700
Received: (qmail 12221 invoked by uid 502); 13 Aug 2001 05:13:56 -0000
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ilya Volynets <ilya@theIlya.com>
Reply-To: ilya@theIlya.com
Organization: Total knowledge
To: Keith M Wesolowski <wesolows@foobazco.org>
Subject: Re: Is it possible to boot linux on an O2 r5k ?
Date: Sun, 12 Aug 2001 22:13:53 -0700
X-Mailer: KMail [version 1.2]
Cc: Mark Nellemann <mark@nellemann.nu>,
   linux-mips mail list <linux-mips@oss.sgi.com>
References: <20010812215442.C24560@foobazco.org>
In-Reply-To: <20010812215442.C24560@foobazco.org>
MIME-Version: 1.0
Message-Id: <0108122213530C.07543@gateway>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 12 August 2001 21:54, Keith M Wesolowski wrote:
> Also eepro100 has worked for me in the past.  Someone should
> investigate why the 3c doesn't work; probably the driver is doing
> something forbidden.  While we're at it, someone should sync that tree
> with oss again.  It doesn't appear likely that I'll be working on it
> for some time, if ever.
I think Nick wanted to take over this. At least he said he'd try.

> > Also, things only work uncached.
>
> Well, even then I can't really claim that it "works" for any standard
> meaning of the word.  Frankly, I'd rather people start running cached
> so that those problems can get fixed, especially since running cached
> isn't really *that* much worse anyway.
I'll get on it as soon as I get MACE Ethernet driver working.

> > As you now understand, O2+Linux is kernel-hacker only toy at the moment.
>
> Isn't that the rule?  Completeness of Linux support is directly
> proportional to the degree of obsolescence of the hardware.  You want
> full support, just run Irix... it's not like it's windows or anything.
I don't know if this discussion should be started again, but I can't
stop myself from saing that having Linux supporting SGI MIPS
machines as well as it does SPARC64 machines would be very pleasant
thing to have. Everyone knows that Slowlaris is rock-solid OS, but I am
yet to see a person that doesn't like Linux on SUN machines. I want to
be able to say same thing about O2, Octane, and Onyx[2] systems some
time soon (wish wish wish....).
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjt3YhQACgkQtKh84cA8u2kbjACaA2O/hf9+FhPOIe/yQU+IlMxU
6EsAn0cdQihzuUIws9AH7394ITRPa2Mx
=hJez
-----END PGP SIGNATURE-----
