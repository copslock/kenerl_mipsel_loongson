Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 12:55:40 +0100 (BST)
Received: from dns0.mips.com ([63.167.95.198]:30870 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20024700AbXIDLza (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2007 12:55:30 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l84BlYuk020580;
	Tue, 4 Sep 2007 04:47:34 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id l84Blo4n015065;
	Tue, 4 Sep 2007 04:47:51 -0700 (PDT)
Message-ID: <009201c7eee9$6ea3d5d0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc:	"yshi" <yang.shi@windriver.com>, <linux-mips@linux-mips.org>
References: <46DD1CD1.5040306@windriver.com> <006901c7eeda$d8049a50$10eca8c0@grendel> <1188901951.4106.16.camel@yshi.CORP> <006f01c7eee5$bbe77c60$10eca8c0@grendel> <20070904113325.GA6904@alpha.franken.de>
Subject: Re: [PATCH] malta4kec hang in calibrate_delay fix
Date:	Tue, 4 Sep 2007 13:47:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> > In that case, your core is a 4Kc and not a 4KEc.  The "r2" value in the
> 
> does that mean all 4KEc must support MIPS32R2 ? TI claims to use
> an 4KEc core for their AR7/UR8 SoCs, but they only support MIPS32R1.

There are two main differences between the 4K and the 4KE:  Write-back
caches and MIPS32R2.  I honestly don't know if it's possible to synthesise
a 4KE so as to inhibit the MIPS32R2 features, but it would be a surprising
thing to do.  I have no idea what TI actually does, but I could imagine,
hypothetically, a customer who had done a design based around the original
4K, and who upgraded it to the 4KE, deciding not to upgrade their chip-level
testing to cover the Release 2 features, and therefore not wanting to guarantee
them for their customers.  These things happen.  But, again, I have no idea what
TI actually does.  I *do* know that the 4KE is a Release 2 part.

            Regards,

            Kevin K.
