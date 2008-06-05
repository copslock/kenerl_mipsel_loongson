Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2008 02:36:00 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:2222 "EHLO
	bby1mta03.pmc-sierra.bc.ca") by ftp.linux-mips.org with ESMTP
	id S20021633AbYFEBf6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Jun 2008 02:35:58 +0100
Received: from bby1mta03.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
	by localhost (Postfix) with SMTP id 23FE510713A7;
	Wed,  4 Jun 2008 18:37:32 -0700 (PDT)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
	by bby1mta03.pmc-sierra.bc.ca (Postfix) with SMTP id ED26410713DF;
	Wed,  4 Jun 2008 18:37:31 -0700 (PDT)
Received: from BBY1EXM09.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.157]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Jun 2008 18:36:12 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Status of PMC MSP71xx support?
Date:	Wed, 4 Jun 2008 18:35:08 -0700
Message-ID: <92F38F1DC286C7409E29F0C6FBFB6E4F0134B636@BBY1EXM09.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <8A9D56C5E50F774BABE033F1710B35760138FF57@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Status of PMC MSP71xx support?
Thread-Index: AcjGXDI8bKZ0Up11QmqlnFytGPSKmQAA6eagABK41GA=
References: <8A9D56C5E50F774BABE033F1710B35760138FF57@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
From:	"Rod Sillett" <Rod_Sillett@pmc-sierra.com>
To:	<bunk@kernel.org>
Cc:	"Brian Oostenbrink" <Brian_Oostenbrink@pmc-sierra.com>,
	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 05 Jun 2008 01:36:12.0996 (UTC) FILETIME=[89E10840:01C8C6AC]
X-PMX-Version: 5.4.2.338381, Antispam-Engine: 2.6.0.325393, Antispam-Data: 2008.6.4.181942
X-PMC-SpamCheck: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_1000_LESS 0, BODY_SIZE_300_399 0, BODY_SIZE_5000_LESS 0, __BOUNCE_CHALLENGE_SUBJ 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __IMS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
Return-Path: <Rod_Sillett@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rod_Sillett@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi Adrian,

Yes, the msp71xx platform is still actively supported by PMC. I am
responsible for merging the changes back to the community. As a first
step (a learning experience for me) I was planning to submit updated
GPIO and LED support in the next few weeks. 

Best Regards,
Rod Sillett
