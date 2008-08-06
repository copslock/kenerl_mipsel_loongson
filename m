Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2008 20:50:21 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:51228 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S28576913AbYHFTuS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Aug 2008 20:50:18 +0100
Received: from 10.8.0.25 ([10.8.0.25]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Wed,  6 Aug 2008 19:50:10 +0000
Received: from kh-ubuntu by webmail.razamicroelectronics.com; 06 Aug 2008 14:50:35 -0500
Subject: Re: [PATCH] Alchemy: register mmc platform device for
	db1200/pb1200 boards
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20080805175126.GA29618@roarinelk.homelinux.net>
References: <20080805175126.GA29618@roarinelk.homelinux.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:	Wed, 06 Aug 2008 14:50:33 -0500
Message-Id: <1218052233.3808.3.camel@kh-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

On Tue, 2008-08-05 at 19:51 +0200, Manuel Lauss wrote:
> Add au1xmmc platform data for PB1200/DB1200 boards, and wire up
> the 2 SD controllers for them.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
This one looks good to me, especially combined with the "au1xmmc: raise
segment size limit" patch that Manuel submitted on July 29.

Acked-by: Kevin Hickey <khickey@rmicorp.com>

-- 
Kevin Hickey
﻿Alchemy Solutions
RMI Corporation
khickey@RMICorp.com
P: 512.691.8044
