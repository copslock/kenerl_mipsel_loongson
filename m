Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 00:25:05 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:65488 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22687615AbYJ2XUZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2008 23:20:25 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9TNJkgq002443;
	Wed, 29 Oct 2008 23:19:46 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9TNJkQT002442;
	Wed, 29 Oct 2008 23:19:46 GMT
Date:	Wed, 29 Oct 2008 23:19:46 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	akpm@linux-foundation.org
Cc:	linux-mips@linux-mips.org, alessandro.zummo@towertech.it,
	tsbogend@alpha.franken.de
Subject: Re: [patch 3/3] drivers/rtc/rtc-m48t35.c is borked too
Message-ID: <20081029231946.GB2370@linux-mips.org>
References: <200810292121.m9TLLYjd019910@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200810292121.m9TLLYjd019910@imap1.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 29, 2008 at 02:21:34PM -0700, akpm@linux-foundation.org wrote:

> Subject: [patch 3/3] drivers/rtc/rtc-m48t35.c is borked too
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> drivers/rtc/rtc-m48t35.c: In function 'm48t35_read_time':
> drivers/rtc/rtc-m48t35.c:59: error: implicit declaration of function 'readb'
> drivers/rtc/rtc-m48t35.c:60: error: implicit declaration of function 'writeb'
> drivers/rtc/rtc-m48t35.c: In function 'm48t35_probe':
> drivers/rtc/rtc-m48t35.c:168: error: implicit declaration of function 'ioremap'
> drivers/rtc/rtc-m48t35.c:168: warning: assignment makes pointer from integer without a cast
> drivers/rtc/rtc-m48t35.c:188: error: implicit declaration of function 'iounmap'

Same for this one; commit ID d7a6119f457f48a94985fdbdc400cbb03e136a76 should
have solved this one also.

  Ralf
