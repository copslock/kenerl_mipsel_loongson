Received:  by oss.sgi.com id <S553834AbQLCMWS>;
	Sun, 3 Dec 2000 04:22:18 -0800
Received: from u-162-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.162]:27147
        "EHLO u-162-19.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553827AbQLCMVy>; Sun, 3 Dec 2000 04:21:54 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S869663AbQLCMVd>;
	Sun, 3 Dec 2000 13:21:33 +0100
Date:	Sun, 3 Dec 2000 13:21:33 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	Ulrich Drepper <drepper@cygnus.com>,
        "H . J . Lu" <hjl@valinux.com>, Nick Clifton <nickc@redhat.com>,
        binutils@sources.redhat.com, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: Update readelf to know about the new ELF constants
Message-ID: <20001203132132.B21272@bacchus.dhis.org>
References: <m3wvdnsu3z.fsf@otr.mynet.cygnus.com> <Pine.GSO.3.96.1001129130308.13815B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.3.96.1001129130308.13815B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Nov 29, 2000 at 01:10:58PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Nov 29, 2000 at 01:10:58PM +0100, Maciej W. Rozycki wrote:

>  Well, I would only add the name should probably be EM_MIPS_R3_LE (and
> ditto the comment).  We might actually use it for mipsel-linux especially
> as the ABI explicitly states EM_MIPS is for big endian machines but I'm
> not sure it's worth bothering as the endianness is specified
> independently.

The entire ABI only covers big endianess, so you can't directly make
conclusions for little endian boxes based.  So whatever a little endian
system ``ABI compliant'' system does it's only based on an effort to stick
as closely as possible to the ABI.

> I believe all software involved should handle it well -- I recall Linux,
> glibc, binutils, modutils all handle both tags fine.  It's just BFD that
> does not generate EM_MIPS_R3_LE. 

  Ralf
