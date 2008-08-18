Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 00:10:23 +0100 (BST)
Received: from bby1mta03.pmc-sierra.com ([216.241.235.118]:29919 "EHLO
	bby1mta03.pmc-sierra.bc.ca") by ftp.linux-mips.org with ESMTP
	id S28580032AbYHRXKR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 00:10:17 +0100
Received: from bby1mta03.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
	by localhost (Postfix) with SMTP id 58BFC10700A0;
	Mon, 18 Aug 2008 16:14:21 -0700 (PDT)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
	by bby1mta03.pmc-sierra.bc.ca (Postfix) with SMTP id 2A03E1070076;
	Mon, 18 Aug 2008 16:14:21 -0700 (PDT)
Received: from BBY1EXM09.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.156]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 18 Aug 2008 16:11:14 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [MIPS] msp71xx: resolve compilation problem in msp_setup.c
Date:	Mon, 18 Aug 2008 16:11:13 -0700
Message-ID: <16B817FC3FB4A540BD8003EA6004CE7101A9FDD8@BBY1EXM09.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <20080818212812.GA28692@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [MIPS] msp71xx: resolve compilation problem in msp_setup.c
Thread-Index: AckBeqoejsTDZDqDSoqade8in8HvzAACgCTg
References: <E1KUmPs-0005uZ-Du@localhost> <20080818212812.GA28692@linux-mips.org>
From:	"Patrick Glass" <Patrick_Glass@pmc-sierra.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 18 Aug 2008 23:11:14.0068 (UTC) FILETIME=[B5E53540:01C90187]
X-PMX-Version: 5.4.4.348488, Antispam-Engine: 2.6.0.325393, Antispam-Data: 2008.8.18.225208
X-PMC-SpamCheck: Gauge=IIIIIII, Probability=8%, Report='BODY_SIZE_1400_1499 0, BODY_SIZE_5000_LESS 0, __BOUNCE_CHALLENGE_SUBJ 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_419_BODY_WEBMAIL 0, __FRAUD_419_WEBMAIL 0, __HAS_MSGID 0, __IMS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
Return-Path: <Patrick_Glass@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Patrick_Glass@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

>On Sun, Aug 17, 2008 at 11:51:48AM -0600, Shane McDonald wrote:
>> From: Shane McDonald <mcdonald.shane@gmail.com>
>> Date: Sun, 17 Aug 2008 11:51:48 -0600
>> To: linux-mips@linux-mips.org, ralf@linux-mips.org
>> Subject: [MIPS] msp71xx: resolve compilation problem in msp_setup.c
>> 
>> The msp71xx_defconfig has never compiled in a kernel release.  This
is 
>> because the file msp_setup.c relies on some definitions from the 
>> PMCMSP GPIO driver, which has not yet been accepted into the kernel.
>> This patch checks for the existence of the PMCMSP GPIO driver; if it 
>> doesn't exist, no GPIO functions are referenced.
>> 
>> This patch will continue to work after the GPIO driver has been 
>> accepted, so no changes will be necessary when that happens.
>
>Has the driver actually been submitted?  In its current form I doubt
it'll be accepted since
>there is now a generic GPIO framework so there should be no more new
drivers/char/ GPIO 
>drivers.
>
>  Ralf

Hi,
I have attempted to submit a new patch for msp71xx which enables gpio
access through the new gpio framework. Hopefully it should propogate
throught the list soon... if I have not messed up (It's my first patch
for linux-mips). Also we have a newer msp_setup that removes the gpio
calls altogether. I will cleanup our msp_setup.c file and create a new
patch that can replace this patch if that's ok with you.

Thanks,
Patrick Glass
