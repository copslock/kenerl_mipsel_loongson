Received:  by oss.sgi.com id <S553773AbQKGC6Q>;
	Mon, 6 Nov 2000 18:58:16 -0800
Received: from chmls20.mediaone.net ([24.147.1.156]:32507 "EHLO
        chmls20.mediaone.net") by oss.sgi.com with ESMTP id <S553725AbQKGC6D>;
	Mon, 6 Nov 2000 18:58:03 -0800
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.248.129])
	by chmls20.mediaone.net (8.8.7/8.8.7) with SMTP id VAA08386;
	Mon, 6 Nov 2000 21:58:01 -0500 (EST)
From:   "Jay Carlson" <nop@nop.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>, "Jay Carlson" <nop@place.org>
Cc:     <linux-mips@oss.sgi.com>, <linux-mips@fnet.fr>
Subject: RE: kernel should not reject -mips2 ELF binaries
Date:   Mon, 6 Nov 2000 22:00:02 -0500
Message-ID: <KEEOIBGCMINLAHMMNDJNIEDHCAAA.nop@nop.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20001107032802.D28567@bacchus.dhis.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> > 	if (__h->e_flags & EF_MIPS_ARCH)				\
> > 		__res = 0;						\

> > So what's the right way to fix this?  Three things come to mind:
> >
> > 1) rip out the EF_MIPS_ARCH check from elf_check_arch.
>
> Take 1).  The problem we have is distiguishing Linux binaries from IRIX
> binaries.  The code causing problems for you is a heuristic that no
> longer works these days so I'll have to come up with something new.

OK.  I'm going to remove the above two lines in the Linux VR CVS repository.
Thanks!

Jay
