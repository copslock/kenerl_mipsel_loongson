Received:  by oss.sgi.com id <S553817AbQKPB5l>;
	Wed, 15 Nov 2000 17:57:41 -0800
Received: from u-6.karlsruhe.ipdial.viaginterkom.de ([62.180.20.6]:56069 "EHLO
        u-6.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S553704AbQKPB5T>; Wed, 15 Nov 2000 17:57:19 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868642AbQKPB5D>;
        Thu, 16 Nov 2000 02:57:03 +0100
Date:   Thu, 16 Nov 2000 02:57:03 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ian Chilton <ian@ichilton.co.uk>
Cc:     Brady Brown <bbrown@ti.com>,
        Linux-MIPS Mailing List <linux-mips@oss.sgi.com>
Subject: Re: egcs 1.0.3a build error?
Message-ID: <20001116025703.F6979@bacchus.dhis.org>
References: <3A12F036.40753275@ti.com> <NAENLMKGGBDKLPONCDDOAEMGDCAA.ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <NAENLMKGGBDKLPONCDDOAEMGDCAA.ian@ichilton.co.uk>; from ian@ichilton.co.uk on Wed, Nov 15, 2000 at 08:33:41PM -0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Nov 15, 2000 at 08:33:41PM -0000, Ian Chilton wrote:

> > Thank you, I tried that and had the same result?? Maybe there are other
> > CFLAGS that I need to specify?
> 
> Don't think so...it worked for me, but this was CVS GCC, not 1.0.3a. I have
> had no such problems with 1.0.3a.
> 
> > CFLAGS=-O1
> 
> humm...I used CFLAGS="-O1"
> donno what difference the quotes make, if any...

No difference.

In any case he seems to hit a different problem than the one you're
refering to which only happens when using an old gcc suchs as egcs 1.0.3a
without optimization for compilation of a fairly recent one.

  Ralf
