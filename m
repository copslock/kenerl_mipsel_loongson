Received:  by oss.sgi.com id <S553915AbRAISjQ>;
	Tue, 9 Jan 2001 10:39:16 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:19962 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553913AbRAISjD>; Tue, 9 Jan 2001 10:39:03 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870734AbRAIS2f>; Tue, 9 Jan 2001 16:28:35 -0200
Date:	Tue, 9 Jan 2001 16:28:35 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc:	linux-mips@oss.sgi.com
Subject: Re: MIPS32 patches breaking DecStation
Message-ID: <20010109162835.B4232@bacchus.dhis.org>
References: <20010109095438.A10683@paradigm.rfc822.org> <XFMail.010109181100.Harald.Koerfgen@home.ivm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.010109181100.Harald.Koerfgen@home.ivm.de>; from Harald.Koerfgen@home.ivm.de on Tue, Jan 09, 2001 at 06:11:00PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 09, 2001 at 06:11:00PM +0100, Harald Koerfgen wrote:

> > No problem - Done - doesnt work
> 
> Same here on my /260 (R4400SC V4.0). Neither inserting four "sll $0,$0,1" nor
> four "nop" seem to work. The branch, on the other hand, does.

Note the ssnops only make sense on superscalar CPUs, so not on the R4000.
Also note that the branch is equivalent to three nops.  One for the
branch instruction itself, the two more for instructions in the pipeline
that get killed.  On the R4600 / R500 where the hazard is only a single
instruction the branch is equivalent to only a single nop.  So while
unobvious the branch is a rather neat idea.

  Ralf
