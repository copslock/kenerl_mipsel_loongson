Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2009 14:06:26 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57536 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492460AbZKJNGP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Nov 2009 14:06:15 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAAD64Il030544;
	Tue, 10 Nov 2009 14:06:04 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAAD64uE030543;
	Tue, 10 Nov 2009 14:06:04 +0100
Date:	Tue, 10 Nov 2009 14:06:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 2/7] [loongson] lemote-2f: rtc: enable legacy RTC
	driver
Message-ID: <20091110130604.GC18773@linux-mips.org>
References: <cover.1257781987.git.wuzhangjin@gmail.com> <4c3b69663760b00d39e09c3682a55ee7cf4b84c7.1257781987.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c3b69663760b00d39e09c3682a55ee7cf4b84c7.1257781987.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 10, 2009 at 12:06:11AM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Currently, RTC_LIB is not available on loongson family machines(need
> extra patches to enable it), but the legacy RTC driver works well on
> them. Herein, We just deselect RTC_LIB and make the legacy RTC driver as
> a choice to not break the hwclock relative tools on these machines.
> 
> After the relative patches for RTC_LIB upstream
> (http://www.linux-mips.org/archives/linux-mips/2009-11/msg00093.html),
> we will be safe to Remove this patch at that time, but currently, this
> is need.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Queued for 2.6.33.

Thanks!

  Ralf
