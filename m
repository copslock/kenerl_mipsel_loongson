Received:  by oss.sgi.com id <S42364AbQFUXPk>;
	Wed, 21 Jun 2000 16:15:40 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:56613 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42245AbQFUXPR>; Wed, 21 Jun 2000 16:15:17 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA07155
	for <linux-mips@oss.sgi.com>; Wed, 21 Jun 2000 16:20:24 -0700 (PDT)
	mail_from (kenh@knoxville.sgi.com)
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA53780
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 21 Jun 2000 16:14:44 -0700 (PDT)
	mail_from (kenh@knoxville.sgi.com)
Received: from sgitys.knoxville.sgi.com (sgitys.knoxville.sgi.com [169.238.150.98]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id QAA58802; Wed, 21 Jun 2000 16:14:25 -0700 (PDT)
Received: from enigma.knoxville.sgi.com (enigma.knoxville.sgi.com [169.238.150.118]) by sgitys.knoxville.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA27437; Wed, 21 Jun 2000 19:09:40 -0400 (EDT)
Received: (from kenh@localhost) by enigma.knoxville.sgi.com; Wed, 21 Jun 2000 19:11:39 -0400 (EDT)
Date:   Wed, 21 Jun 2000 19:11:39 -0400 (EDT)
From:   "J.K. Hill" <kenh@knoxville.sgi.com>
Message-Id: <10006211911.ZM32099@enigma.knoxville.sgi.com>
In-Reply-To: Paul Jakma <paul@clubi.ie>
        "RE: Problems with multiple harddisks on my Indigo2" (Jun 21, 10:38pm)
References: <Pine.LNX.4.21.0006212234190.5050-100000@fogarty.jakma.org>
X-Mailer: Z-Mail-SGI (3.2S.3 08feb96 MediaMail)
To:     Paul Jakma <paul@clubi.ie>,
        Ian Chilton <mailinglist@ichilton.co.uk>
Subject: Re: Problems with multiple harddisks on my Indigo2
Cc:     spock@mgnet.de, Linux Debian MIPS <debian-mips@lists.debian.org>,
        Linux MIPS cthulhu <linux@cthulhu.engr.sgi.com>,
        Linux MIPS <linux-mips@fnet.fr>,
        MIPS vger <linux-mips@vger.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

All,

Try looking up the jumper'ing information for the drive... There is probably a
delay for spinning the drive up at boot (or some such nonsense).

Regards,

Ken

On Jun 21, 10:38pm, Paul Jakma wrote:
> Subject: RE: Problems with multiple harddisks on my Indigo2
> On Wed, 21 Jun 2000, Ian Chilton wrote:
>
> > I have an SGI Indy, with 2 internal hard disks, a 4GB and a 1GB
> >
> > I get the same thing!
> >
> >
> > > Also I'm getting a message
> > > sc1,2,0: cmd=0x12 timeout after 2 sec.  Resetting SCSI bus
> >
> > I started getting this when I added the 2nd HD (1GB).
> >
>
> fwiw, i got this too on my indy when i added a Quantum Empire 1GB.
>
> >From cold boot the PROM doesn't recognise the second disk, but IRIX
> does (PROM gives me the exact same error message as the one you wrote
> above - but prints it twice). If i halt back to PROM then the PROM
> does see the second disk. (and only prints that error message once)
>
> my theories are:
>
> 1. PROM controller driver is minimal and doesn't init the
> controller/disks properly whereas the IRIX driver does.
>
> 2. disk spin up times.. ??
>
> 3. Perhaps cause the outboard SCSI port is not terminated. (least not
> on my indy)
>
> >
> --
> Paul Jakma	paul@clubi.ie
> PGP5 key: http://www.clubi.ie/jakma/publickey.txt
> -------------------------------------------
> Fortune:
> Give me a fish and I will eat today.
>
> Teach me to fish and I will eat forever.
>-- End of excerpt from Paul Jakma
