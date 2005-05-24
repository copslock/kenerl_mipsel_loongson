Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2005 07:39:32 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:49575
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8224970AbVEXGjS>; Tue, 24 May 2005 07:39:18 +0100
Received: from athena (athena.et.put.poznan.pl [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4O6dF202088;
	Tue, 24 May 2005 08:39:15 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Tue, 24 May 2005 08:39:14 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4O6dED12795;
	Tue, 24 May 2005 08:39:14 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Tue, 24 May 2005 08:39:14 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Richard Sandiford <rsandifo@redhat.com>
cc:	linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
In-Reply-To: <87ekbx872j.fsf@firetop.home>
Message-ID: <Pine.GSO.4.10.10505240837530.12717-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> It should generate:
> 
>     R_MIPS_HI16
>     R_MIPS_HI16
>     R_MIPS_LO16
> 
> And yes, the idea that several HI16s can be associated with the same
> LO16 is also a GNU extension. ;)

Good, no problem - thanks for confirming my darkest suspicions. How can I
detect this? (I've got to emit SGI-compliant ECOFF.) I can emit sham
relocs into .rel.text that point into specially added synthetic
instructions.

Stanislaw
