Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2008 21:20:28 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:24498 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20043940AbYHDUUY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 Aug 2008 21:20:24 +0100
Received: from 10.8.0.25 ([10.8.0.25]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Mon,  4 Aug 2008 20:20:15 +0000
Received: from kh-ubuntu by webmail.razamicroelectronics.com; 04 Aug 2008 15:20:31 -0500
Subject: Re: [PATCH] [MIPS] Add USB device (OTG) support for Au1200 and
	Au1250
From:	Kevin Hickey <khickey@rmicorp.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
In-Reply-To: <1217881052-18797-2-git-send-email-khickey@rmicorp.com>
References: <> <1217881052-18797-1-git-send-email-khickey@rmicorp.com>
	 <1217881052-18797-2-git-send-email-khickey@rmicorp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:	Mon, 04 Aug 2008 15:20:31 -0500
Message-Id: <1217881231.19819.26.camel@kh-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

I intended there to be an introductory email that said:

The following is a patch adding preliminary device-only OTG support for
the Au1200 and Au1250.  It is made largely of code that I inherited that
was never published.  This is the largest patch I have submitted thus
far, and the first one including a new driver.  I welcome comments on
anything in the code, as well as the format and presentation of the
patch.  I will happily rev this to meet the community's standards.
Thanks.

(I'm clearly still getting the hang of git-send-email)

-- 
Kevin Hickey
﻿Alchemy Solutions
RMI Corporation
khickey@RMICorp.com
P: 512.691.8044
