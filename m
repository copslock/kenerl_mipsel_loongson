Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2004 07:09:56 +0000 (GMT)
Received: from mx.mips.com ([IPv6:::ffff:206.31.31.226]:41178 "EHLO
	mx.mips.com") by linux-mips.org with ESMTP id <S8224773AbUBWHJx>;
	Mon, 23 Feb 2004 07:09:53 +0000
Received: from mercury.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.12.11/8.12.11) with ESMTP id i1N71aKS018448;
	Sun, 22 Feb 2004 23:01:36 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id i1N79hhi007378;
	Sun, 22 Feb 2004 23:09:44 -0800 (PST)
Message-ID: <001901c3f9dc$3a46b6a0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Eric Christopher" <echristo@redhat.com>
Cc:	"Mark and Janice Juszczec" <juszczec@hotmail.com>,
	<linux-mips@linux-mips.org>
References: <Law10-F39hgbi1Kigvf000046ac@hotmail.com> <1077477186.3636.34.camel@dzur.sfbay.redhat.com> <001001c3f98e$2270dcc0$10eca8c0@grendel> <1077507447.3636.37.camel@dzur.sfbay.redhat.com>
Subject: Re: r3000 instruction set
Date:	Mon, 23 Feb 2004 08:11:14 +0100
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> On Sun, 2004-02-22 at 13:52, Kevin D. Kissell wrote:
> > > Other than the responses you've already gotten, likely you'll need to
> > > compile with -march=r3900(or -mcpu=r3900 if it's an old toolchain) since
> > > the 3900 is missing a couple of r3000 instructions iirc.
> > 
> > The 3900 family should run MIPS I code compiled for the R3000.
> 
> IIRC there were some standard MIPS I instructions that were not on the
> tx39.

I think you may be confusing MIPS I and MIPS II.  I'm pretty darn certain
that the TX39 inplemented all of MIPS I, most of MIPS II, plus a MADD 
extension.  I'm not going to go instruction counting this morning, but the
TX39 spec declares up-front that it's a superset of the R3000A.
