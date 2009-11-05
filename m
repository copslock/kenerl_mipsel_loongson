Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 08:39:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49582 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492026AbZKEHjz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Nov 2009 08:39:55 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA57fEWk012858;
	Thu, 5 Nov 2009 08:41:17 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA57fAjU012856;
	Thu, 5 Nov 2009 08:41:10 +0100
Date:	Thu, 5 Nov 2009 08:41:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Paul Gortmaker <p_gortmaker@yahoo.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-mips@linux-mips.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH v1 1/3] RTC: rtc-cmos.c: fix warning for MIPS
Message-ID: <20091105074107.GA12826@linux-mips.org>
References: <cover.1257383766.git.wuzhangjin@gmail.com> <a91e34bf2595157830d599cb66becd52247b1819.1257383766.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a91e34bf2595157830d599cb66becd52247b1819.1257383766.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 05, 2009 at 09:21:54AM +0800, Wu Zhangjin wrote:

> This patch fixes the following warning with RTC_LIB on MIPS:
> 
> drivers/rtc/rtc-cmos.c:697:2: warning: #warning Assuming 128 bytes of
> RTC+NVRAM address space, not 64 bytes.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
