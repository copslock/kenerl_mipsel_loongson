Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2003 13:10:56 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:34723 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8224802AbTGUMKo>;
	Mon, 21 Jul 2003 13:10:44 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h6LCAVkW028966;
	Mon, 21 Jul 2003 05:10:31 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA09551;
	Mon, 21 Jul 2003 05:10:29 -0700 (PDT)
Message-ID: <02a701c34f81$4f32ca50$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
References: <Pine.GSO.3.96.1030721124445.13489A-100000@delta.ds2.pg.gda.pl>
Subject: Re: CVS Update@-mips.org: linux 
Date: Mon, 21 Jul 2003 14:12:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

>  Any justifiable reason for getting rid of arch/mips64?

In my opinion, it should never have existed.  The vast majority
of MIPS-specific kernel code can be identical for 32-bit and 64-bit
versions of the architecture.  Creating arch/mips64 (as opposed
to arch/mips/mips64 or Ralf's arch/mips/mm-64) caused duplication 
of modules that then needed to be maintained in parallel - but which 
often were not.
