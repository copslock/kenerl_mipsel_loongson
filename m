Received:  by oss.sgi.com id <S42374AbQJFWWl>;
	Fri, 6 Oct 2000 15:22:41 -0700
Received: from u-150.karlsruhe.ipdial.viaginterkom.de ([62.180.18.150]:10502
        "EHLO u-150.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42370AbQJFWWi>; Fri, 6 Oct 2000 15:22:38 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869496AbQJFQcI>;
        Fri, 6 Oct 2000 18:32:08 +0200
Date:   Fri, 6 Oct 2000 18:32:08 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     "Kevin D. Kissell" <kevink@mips.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: load_unaligned() and "uld" instruction
Message-ID: <20001006183208.C9061@bacchus.dhis.org>
References: <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses> <39D0E51C.79A0BE50@mvista.com> <20001005141354.E30075@bacchus.dhis.org> <39DD26CC.3805FFE8@mvista.com> <00d101c02f04$3a6d7340$0deca8c0@Ulysses> <39DD55E9.AFCACB0E@mvista.com> <011801c02f19$1283f6a0$0deca8c0@Ulysses> <39DD68DE.E9B26A3D@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39DD68DE.E9B26A3D@mvista.com>; from jsun@mvista.com on Thu, Oct 05, 2000 at 10:53:34PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Oct 05, 2000 at 10:53:34PM -0700, Jun Sun wrote:

> Although the usb does use get_unaligned(u64) (ldl/ldr), it actually does
> not run into it - at least in my test so far.  That probably explains
> why my fix runs on the R5432 CPU so far.

No, you just never hit the window where the your 64-bit reg got corrupted by
an exception.  The old broken macros also had a cast to long in them
which was truncating the loaded 64-bit word so in 100% of cases the upper
32-bit was modified in creative ways.  So I guess you were just lucky and
never hit the case were this actually bits.

  Ralf
