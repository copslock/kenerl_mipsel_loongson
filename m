Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5CALCA24142
	for linux-mips-outgoing; Tue, 12 Jun 2001 03:21:12 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5CAL3V24116;
	Tue, 12 Jun 2001 03:21:03 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 207DB7F6; Tue, 12 Jun 2001 12:21:02 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 84CF842C5; Tue, 12 Jun 2001 12:09:27 +0200 (CEST)
Date: Tue, 12 Jun 2001 12:09:27 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Raoul Borenius <borenius@shuttle.de>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays)
Message-ID: <20010612120927.B8798@paradigm.rfc822.org>
References: <20010611000359.A25631@paradigm.rfc822.org> <20010611064249.A15039@bacchus.dhis.org> <20010611165019.A17263@bunny.shuttle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010611165019.A17263@bunny.shuttle.de>; from borenius@shuttle.de on Mon, Jun 11, 2001 at 04:50:19PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 11, 2001 at 04:50:19PM +0200, Raoul Borenius wrote:
> Linux version 2.4.3-cvs20010611 (raoul@bunny) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #12 Mon Jun 11 16:22:41 CEST 2001
> MC: SGI memory controller Revision 3

I got a hint that it might be the compile to produce this bug - I was
suggested to use some gcc 3.0 prerelease. I now checked again and i am
already using some gcc 3.0

Linux version 2.4.3 (flo@paradigm) (gcc version 3.0 20010303 (prerelease))
#1 Mon Jun 11 00:27:09 CEST 2001

(flo@paradigm)~# mips-linux-gcc -v
Reading specs from /usr/local/lib/gcc-lib/mips-linux/3.0/specs
Configured with: ./configure --prefix=/usr/local --target=mips-linux --enable-languages=c --with-newlib --disable-shared
gcc version 3.0 20010303 (prerelease)
(flo@paradigm)~# mips-linux-as -v
GNU assembler version 2.11.90 (mips-linux) using BFD version 2.11.90

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
