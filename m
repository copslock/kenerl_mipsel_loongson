Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2002 17:10:44 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:28139 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122121AbSKEQKo>;
	Tue, 5 Nov 2002 17:10:44 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gA5GAYNf004447;
	Tue, 5 Nov 2002 08:10:35 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id IAA12636;
	Tue, 5 Nov 2002 08:11:39 -0800 (PST)
Message-ID: <00fb01c284e6$5b7bf4f0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@uni-koblenz.de>,
	"Carsten Langgaard" <carstenl@mips.com>
Cc: <linux-mips@linux-mips.org>
References: <3DC7CB8B.E2C1D4E5@mips.com> <20021105163806.A24996@bacchus.dhis.org>
Subject: Re: Prefetches in memcpy
Date: Tue, 5 Nov 2002 17:13:48 +0100
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
X-archive-position: 568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

From: "Ralf Baechle" <ralf@uni-koblenz.de>
> So I think the fix will have to be:
> 
>  - Avoid prefetching beyond the end of the copy area in memcpy and memmove.
>  - Introduce a second variant of memcpy that never does prefetching.  This
>    one will be safe to use in KSEG1 / uncached XKPHYS also and will be used
>    for memcpy_fromio, memcpy_toio and friends.

Assuming we had a version that prefetched exactly to the end
of the source memory block and no further, why would we need
the second variant?

            Kevin K.
