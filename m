Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7AGAvo17041
	for linux-mips-outgoing; Fri, 10 Aug 2001 09:10:57 -0700
Received: from gateway.total-knowledge.com (c1213523-b.smateo1.sfba.home.com [24.1.66.97])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7AGAuV17038
	for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 09:10:56 -0700
Received: (qmail 11549 invoked by uid 502); 10 Aug 2001 16:10:55 -0000
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ilya Volynets <ilya@theIlya.com>
Reply-To: ilya@theIlya.com
Organization: Total knowledge
To: Mark Nellemann <mark@nellemann.nu>,
   linux-mips mail list <linux-mips@oss.sgi.com>
Subject: Re: Is it possible to boot linux on an O2 r5k ?
Date: Fri, 10 Aug 2001 09:10:52 -0700
X-Mailer: KMail [version 1.2]
References: <3B73A5D0.1050202@nellemann.nu>
In-Reply-To: <3B73A5D0.1050202@nellemann.nu>
MIME-Version: 1.0
Message-Id: <01081009105200.07543@gateway>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 10 August 2001 02:13, Mark Nellemann wrote:
> I'm confused.
>
> I was told on irc a month ago, that someone had gotten an O2 to boot.
>
> Yesterday I tried to fire up my O2. The whole bootp, tftp setup was working
> fine, but when I boot'ed the kernel (linux-2.4.3-ip22) the kernel said
> "Yee, could not determine architecture type <SGI-IP32>". Is this because
> i'm using a wrong kernel or isn't it possible to boot the O2 yet ?
Both. The kernel sources for O2 live in cvs.foobazco.org. Also, there are LOTS
of problems. You will need some extra ethernet adapter, for example, since MACE
ethernet is not suported. (I am working on it at the moment, but don't hold your breath).
NICs that are knownw to work: some tulip-based.
NICs that are known not to work: 3c905B-TX...

Also, things only work uncached.

As you now understand, O2+Linux is kernel-hacker only toy at the moment.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjt0B48ACgkQtKh84cA8u2k/AwCeKNmJjvGQesQl8EE2jqwcIXzA
VeUAnAwLKa/hCSL/oIyZ8bRc2crbE+rN
=1v99
-----END PGP SIGNATURE-----
