Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Dec 2002 11:37:31 +0000 (GMT)
Received: from p508B51DF.dip.t-dialin.net ([IPv6:::ffff:80.139.81.223]:6295
	"EHLO p508B51DF.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225326AbSLWLee>; Mon, 23 Dec 2002 11:34:34 +0000
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:56333 "EHLO
	dmz.algor.co.uk") by ralf.linux-mips.org with ESMTP
	id <S868871AbSLWILK>; Mon, 23 Dec 2002 09:11:10 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.algor.co.uk)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 18QNm5-0007Ij-00; Mon, 23 Dec 2002 08:17:22 +0000
Received: from gladsmuir.algor.co.uk ([172.20.192.66])
	by olympia.algor.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 18QNcm-0006gl-00; Mon, 23 Dec 2002 08:07:44 +0000
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15878.50250.913604.889876@gladsmuir.algor.co.uk>
Date: Mon, 23 Dec 2002 08:07:38 +0000
To: "Pichai  Raghavan" <ragh_avan@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: applications compiled with mips16 ISA
In-Reply-To: <20021220142459.1029.qmail@webmail8.rediffmail.com>
References: <20021220142459.1029.qmail@webmail8.rediffmail.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-1.8, required 5, AWL,
	IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES, SIGNATURE_SHORT_DENSE,
	SPAM_PHRASE_00_01)
Return-Path: <dom@algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


> Has anyone put MIPS16 based applications on Linux 2.4.2 kernel? We 
> want to use this to get more flash storage...

Linux applications and libraries require position-independent code.
gcc cannot yet generate PIC MIPS16 code.  We've considered fixing it
to do so for test purposes, but the code will be awful and much of the
MIPS16 code size reduction will be lost.

You'd surely do better to use software compression to reduce the size
of the code in your flash memory.

-- 
Dominic Sweetman
MIPS Technologies
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone +44 1223 706205/fax +44 1223 706250/swbrd +44 1223 706200
http://www.algor.co.uk
