Received:  by oss.sgi.com id <S42211AbQF3AeU>;
	Thu, 29 Jun 2000 17:34:20 -0700
Received: from u-241.karlsruhe.ipdial.viaginterkom.de ([62.180.10.241]:46342
        "EHLO u-241.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42202AbQF3AeB>; Thu, 29 Jun 2000 17:34:01 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1405570AbQF3Adx>;
        Fri, 30 Jun 2000 02:33:53 +0200
Date:   Fri, 30 Jun 2000 02:33:53 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Cc:     "J. Scott Kasten" <jsk@tetracon-eng.net>, linux-mips@oss.sgi.com
Subject: Re: MIPS symbol versioning patches
Message-ID: <20000630023352.E15960@bacchus.dhis.org>
References: <14671.21669.3126.181895@calypso.engr.sgi.com> <Pine.SGI.4.10.10006291446000.17956-100000@thor.tetracon-eng.net> <14683.40873.494836.164828@calypso.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <14683.40873.494836.164828@calypso.engr.sgi.com>; from ulfc@calypso.engr.sgi.com on Thu, Jun 29, 2000 at 12:12:41PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jun 29, 2000 at 12:12:41PM -0700, Ulf Carlsson wrote:

> Yes, it's just a matter of recompiling everything against it.  Keith
> Wesolowski is doing this.  We have found some minor problems with
> glibc that we haven't been able to resolve yet.  There is some bug in
> the dynamic linker, it tries to resolve symbols that aren't there in
> some packages.
> 
> There is also a problem with compiling gcc 2.96 natively, but I
> actually think that's a problem in gcc 2.96.  It shouldn't try to
> generate jump instructions like it does that in PIC code.

What jump instructions?  jal goes ok, the assembler knows how expand
them correctly for PIC code.

  Ralf
