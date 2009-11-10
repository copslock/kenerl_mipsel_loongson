Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2009 14:07:55 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58024 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492617AbZKJNHf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Nov 2009 14:07:35 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAAD7NuE030600;
	Tue, 10 Nov 2009 14:07:23 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAAD7NVG030599;
	Tue, 10 Nov 2009 14:07:23 +0100
Date:	Tue, 10 Nov 2009 14:07:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 7/7] [loongson] lemote-2f: add defconfig file
Message-ID: <20091110130723.GG18773@linux-mips.org>
References: <cover.1257781987.git.wuzhangjin@gmail.com> <56db9ebb7a6a6b43b6b06c5f45d3df028cdca0bf.1257781987.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56db9ebb7a6a6b43b6b06c5f45d3df028cdca0bf.1257781987.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 10, 2009 at 12:06:16AM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch add default config file for lemote loongson2f family
> machines, which means we can use the same kernel image on fuloong2f,
> yeeloong2f and the other lemote loongson2f family machines.
> 
> If you are using the old PMON, and not using the 2f box, please add a
> new command line argument in the boot.cfg.
> 
> for example, add this argument for 8.9inches notebook:
> 
> 	machtype=lemote-yeeloong-2f-8.9inches
> 
> 	or simply type(if it can indicate it),
> 
> 	machtype=8.9
> 
> please get more information from arch/mips/loongson/common/machtype.c
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Queued for 2.6.33.

Thanks!

  Ralf
