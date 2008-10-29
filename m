Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 00:26:13 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:63952 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22687488AbYJ2XTl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2008 23:19:41 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9TNJ69V002420;
	Wed, 29 Oct 2008 23:19:06 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9TNJ5AD002418;
	Wed, 29 Oct 2008 23:19:05 GMT
Date:	Wed, 29 Oct 2008 23:19:05 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	akpm@linux-foundation.org
Cc:	linux-mips@linux-mips.org, alessandro.zummo@towertech.it,
	tsbogend@alpha.franken.de
Subject: Re: [patch 2/3] drivers/rtc/rtc-ds1286.c is borked
Message-ID: <20081029231905.GA2370@linux-mips.org>
References: <200810292121.m9TLLXQF019907@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200810292121.m9TLLXQF019907@imap1.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 29, 2008 at 02:21:33PM -0700, akpm@linux-foundation.org wrote:
> From: akpm@linux-foundation.org
> Date: Wed, 29 Oct 2008 14:21:33 -0700
> To: ralf@linux-mips.org
> Cc: linux-mips@linux-mips.org, akpm@linux-foundation.org,
> 	alessandro.zummo@towertech.it, tsbogend@alpha.franken.de
> Subject: [patch 2/3] drivers/rtc/rtc-ds1286.c is borked
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> drivers/rtc/rtc-ds1286.c: In function 'ds1286_rtc_read':
> drivers/rtc/rtc-ds1286.c:33: error: implicit declaration of function '__raw_readl'
> drivers/rtc/rtc-ds1286.c: In function 'ds1286_rtc_write':
> drivers/rtc/rtc-ds1286.c:38: error: implicit declaration of function '__raw_writel'
> drivers/rtc/rtc-ds1286.c: In function 'ds1286_probe':
> drivers/rtc/rtc-ds1286.c:345: error: implicit declaration of function 'ioremap'
> drivers/rtc/rtc-ds1286.c:345: warning: assignment makes pointer from integer without a cast
> drivers/rtc/rtc-ds1286.c:365: error: implicit declaration of function 'iounmap'

Geert's patch commit ID d7a6119f457f48a94985fdbdc400cbb03e136a76 should
have solved this so you can drop this one.

  Ralf
