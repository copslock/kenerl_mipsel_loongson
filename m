Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GB0FS21111
	for linux-mips-outgoing; Mon, 16 Jul 2001 04:00:15 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GB0BV21100;
	Mon, 16 Jul 2001 04:00:12 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E293E802; Mon, 16 Jul 2001 13:00:09 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3CDDE4626; Mon, 16 Jul 2001 12:03:47 +0200 (CEST)
Date: Mon, 16 Jul 2001 12:03:47 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
Message-ID: <20010716120347.B13023@paradigm.rfc822.org>
References: <20010712224520.C23062@bacchus.dhis.org> <Pine.GSO.3.96.1010713124802.3193B-100000@delta.ds2.pg.gda.pl> <20010714125312.A6713@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010714125312.A6713@bacchus.dhis.org>; from ralf@oss.sgi.com on Sat, Jul 14, 2001 at 12:53:12PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 14, 2001 at 12:53:12PM +0200, Ralf Baechle wrote:
> Have you ever profiled the number of calls to MIPS_ATOMIC_SET or
> _test_and_set?  They'll be the other factor in a decission.

Against glibc 2.2 compiled bins do it 20-30 times on startup ... Just
try an strace and you'll astonished ... Even sleep (What on earth
is atomic in sleep ?)

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
