Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 May 2006 16:06:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:21736 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133359AbWE3OGT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 May 2006 16:06:19 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4UE6ILk020392;
	Tue, 30 May 2006 15:06:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4UE6G6E020391;
	Tue, 30 May 2006 15:06:16 +0100
Date:	Tue, 30 May 2006 15:06:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Roman Mashak <mrv@corecom.co.kr>
Cc:	linux-mips@linux-mips.org
Subject: Re: compiling BCM5700 driver
Message-ID: <20060530140616.GA18432@linux-mips.org>
References: <000101c6838e$437abdf0$9d0ba8c0@mrv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101c6838e$437abdf0$9d0ba8c0@mrv>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 30, 2006 at 11:10:45AM +0900, Roman Mashak wrote:

> I try to compile BCM5700 driver of gigabit ethernet card for MIPS target. I 
> used both toolchains (from PMC-sierra and self-made following 
> http://www.kegel.com/crosstool recommendations). Get same errors:
> 
> In file included from mm.h:151,
>                 from b57um.c:19:
> tigon3.h:2225: unnamed fields of type other than struct or union are not 
> allowed

Broadcom's old and infamous Tigon 3 driver.  Dump it, use tg3, be happy.

  Ralf
