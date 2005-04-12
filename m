Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2005 17:35:53 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:33496
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225195AbVDLQfh>; Tue, 12 Apr 2005 17:35:37 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j3CGZRGJ019606;
	Tue, 12 Apr 2005 09:35:28 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with SMTP id j3CGZJGl003529;
	Tue, 12 Apr 2005 09:35:20 -0700 (PDT)
Message-ID: <00c701c53f7e$09ec56c0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	"Greg Weeks" <greg.weeks@timesys.com>,
	"Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
References: <42553E49.7080004@timesys.com> <4256991C.4020601@timesys.com> <20050408161357.GB19166@linux-mips.org> <4256B524.2080509@timesys.com> <425AD440.5050600@timesys.com> <004a01c53ed4$dab12b00$10eca8c0@grendel> <Pine.LNX.4.61L.0504121610500.18606@blysk.ds.pg.gda.pl>
Subject: Re: another 4kc machine check.
Date:	Tue, 12 Apr 2005 18:38:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> On Mon, 11 Apr 2005, Kevin D. Kissell wrote:
> 
> > If the 4KC and 4KEC need it, so does the 4KSC (and 4KSD).
> 
>  But that's weird in the first place as 4Kc implements the original 
> revision of MIPS32 so it does not implement "ehb".  Therefore it acts just 
> as an ordinary "nop", but according to the 4K manual there is no need for 
> one -- the hazard between a move to EntryLo0/EntryLo1 and tlbwi/tlbwr is 
> explicitly listed as 0 instructions.

Oops.  Maybe I misread the patch.  I thought the added NOP was between
the TLBWR and the ERET.

            Kevin K.
