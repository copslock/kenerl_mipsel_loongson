Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Mar 2005 12:56:21 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:13339 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8227042AbVCOM4H>; Tue, 15 Mar 2005 12:56:07 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j2FCtHCS007092;
	Tue, 15 Mar 2005 12:55:17 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j2FCtH56007091;
	Tue, 15 Mar 2005 12:55:17 GMT
Date:	Tue, 15 Mar 2005 12:55:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch] fix structure declarations
Message-ID: <20050315125517.GD6025@linux-mips.org>
References: <200503150830.23760.eckhardt@satorlaser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503150830.23760.eckhardt@satorlaser.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 15, 2005 at 08:30:23AM +0100, Ulrich Eckhardt wrote:

> Seems someone went about adding C99 initialisers, but accidentally 'fixed' 
> these structure definitions containing bitfields...

Your mailer converted the tabs in the patch into spaces ..
