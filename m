Received:  by oss.sgi.com id <S553848AbRAFBrR>;
	Fri, 5 Jan 2001 17:47:17 -0800
Received: from chmls05.mediaone.net ([24.147.1.143]:9977 "EHLO
        chmls05.mediaone.net") by oss.sgi.com with ESMTP id <S553696AbRAFBrC>;
	Fri, 5 Jan 2001 17:47:02 -0800
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.248.129])
	by chmls05.mediaone.net (8.8.7/8.8.7) with SMTP id UAA09492;
	Fri, 5 Jan 2001 20:46:45 -0500 (EST)
From:   "Jay Carlson" <nop@nop.com>
To:     "Kevin D. Kissell" <kevink@mips.com>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        <Lisa.Hsu@taec.toshiba.com>
Cc:     <linux-mips@oss.sgi.com>
Subject: RE: questions on the cross-compiler
Date:   Fri, 5 Jan 2001 20:46:43 -0500
Message-ID: <KEEOIBGCMINLAHMMNDJNGEFGCAAA.nop@nop.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <006c01c07765$fdd26440$0deca8c0@Ulysses>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Kevin D. Kissell writes:

> Lisa's underlying problem may be that there isn't a Config
> option for the R39xx CPUs, and she's ended up getting an
> R4000 (or whatever) configuration by default.
>
> At some point specific support for the R3900 features
> (MIPS II ISA, seperate hardware interrupt vector, etc.)
> should go into the kernel,
[...]

http://cvs.sourceforge.net/cgi-bin/cvsweb.cgi/linux/arch/mips/r39xx/?cvsroot
=linux-vr

The TX3912 is supported by the Linux VR kernel tree.  I'm not sure it's been
tested in a while, but kernel sources from a few months ago run nice on my
VTech Helio.

Jay
