Received:  by oss.sgi.com id <S42310AbQJFW1V>;
	Fri, 6 Oct 2000 15:27:21 -0700
Received: from u-150.karlsruhe.ipdial.viaginterkom.de ([62.180.18.150]:11014
        "EHLO u-150.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42222AbQJFW1K>; Fri, 6 Oct 2000 15:27:10 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869490AbQJFW0f>;
        Sat, 7 Oct 2000 00:26:35 +0200
Date:   Sat, 7 Oct 2000 00:26:35 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: load_unaligned() and "uld" instruction
Message-ID: <20001007002635.A9631@bacchus.dhis.org>
References: <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses> <39D0E51C.79A0BE50@mvista.com> <20001005141354.E30075@bacchus.dhis.org> <39DD26CC.3805FFE8@mvista.com> <00d101c02f04$3a6d7340$0deca8c0@Ulysses> <39DD55E9.AFCACB0E@mvista.com> <011801c02f19$1283f6a0$0deca8c0@Ulysses> <39DD68DE.E9B26A3D@mvista.com> <39DE7DD3.7A67B19E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39DE7DD3.7A67B19E@mvista.com>; from jsun@mvista.com on Fri, Oct 06, 2000 at 06:35:15PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 06, 2000 at 06:35:15PM -0700, Jun Sun wrote:

> While the __ldq_u() did work, I had a couple of syntax problems with
> put_unaligned().  See the patch below.
> 
> In addition, my usb subsystem now hangs.  It might mean a bug in the new
> unaligned.h or the fix to unaligned.h reveals another bug.  I will let
> you know.

I had already a patch for a the x vs. val thing in the CVS, so I just took
the part which adds the additional brackets from your patch to make
sure the semantic is identical with functions calls.

  Ralf
