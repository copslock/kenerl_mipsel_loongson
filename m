Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2009 14:07:12 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57924 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492460AbZKJNG7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Nov 2009 14:06:59 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAAD6npG030566;
	Tue, 10 Nov 2009 14:06:49 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAAD6nCa030565;
	Tue, 10 Nov 2009 14:06:49 +0100
Date:	Tue, 10 Nov 2009 14:06:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 5/7] [loongson] lemote-2f: add irq support
Message-ID: <20091110130649.GE18773@linux-mips.org>
References: <cover.1257781987.git.wuzhangjin@gmail.com> <1d0296297adcbb33efe9e46488866e9f897faec3.1257781987.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d0296297adcbb33efe9e46488866e9f897faec3.1257781987.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 10, 2009 at 12:06:14AM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> The common i8259_irq() will make kernel hang on booting, herein, we
> write our own instead.
> 
> The IP6 is shared by the bonito interrupt and the perfcounter interrupt.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Queued for 2.6.33.

Thanks!

  Ralf
