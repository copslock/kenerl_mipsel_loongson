Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 12:33:43 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:26287 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20024683AbXIDLde (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2007 12:33:34 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1ISWez-0004S9-00; Tue, 04 Sep 2007 13:33:33 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 1D63211ACCE; Tue,  4 Sep 2007 13:33:25 +0200 (CEST)
Date:	Tue, 4 Sep 2007 13:33:25 +0200
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	yshi <yang.shi@windriver.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] malta4kec hang in calibrate_delay fix
Message-ID: <20070904113325.GA6904@alpha.franken.de>
References: <46DD1CD1.5040306@windriver.com> <006901c7eeda$d8049a50$10eca8c0@grendel> <1188901951.4106.16.camel@yshi.CORP> <006f01c7eee5$bbe77c60$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006f01c7eee5$bbe77c60$10eca8c0@grendel>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

> In that case, your core is a 4Kc and not a 4KEc.  The "r2" value in the

does that mean all 4KEc must support MIPS32R2 ? TI claims to use
an 4KEc core for their AR7/UR8 SoCs, but they only support MIPS32R1.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
