Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g78JwhRw022889
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 8 Aug 2002 12:58:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g78JwhiL022888
	for linux-mips-outgoing; Thu, 8 Aug 2002 12:58:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g78JwaRw022860;
	Thu, 8 Aug 2002 12:58:36 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g78K02Xb021952;
	Thu, 8 Aug 2002 13:00:02 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id NAA02336;
	Thu, 8 Aug 2002 13:00:03 -0700 (PDT)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g78K02b14116;
	Thu, 8 Aug 2002 22:00:02 +0200 (MEST)
Message-ID: <3D52CF03.4173541D@mips.com>
Date: Thu, 08 Aug 2002 22:05:23 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: memcpy.S patch in 64-bit
References: <Pine.GSO.3.96.1020808170518.13783D-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:

> On Thu, 8 Aug 2002, Carsten Langgaard wrote:
>
> > The __copy_user function (in arch/mips64/lib/memcpy.S) calls __bzero.
> > We can't do that because __bzero might modify len, which we want to
> > return in case of an error.
> > The following patch take care of the problem.
>
>  Hmm, how about simply cloning arch/mips/lib/memcpy.S?  It seems:
>
> 1. Designed to work on mips64 as well.
>
> 2. More up to date.
>
> And it would ease maintenance.
>

If it works then it's the right thing to do, so please go a head :-)


>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
