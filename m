Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2009 14:06:49 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57682 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492520AbZKJNGf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Nov 2009 14:06:35 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAAD6N0t030551;
	Tue, 10 Nov 2009 14:06:23 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAAD6NH3030550;
	Tue, 10 Nov 2009 14:06:23 +0100
Date:	Tue, 10 Nov 2009 14:06:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 4/7] [loongson] lemote-2f: add pci support
Message-ID: <20091110130623.GD18773@linux-mips.org>
References: <cover.1257781987.git.wuzhangjin@gmail.com> <791c33dbd40b62f7341a545390db70731b85ce22.1257781987.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <791c33dbd40b62f7341a545390db70731b85ce22.1257781987.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 10, 2009 at 12:06:13AM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Most of the pci support between fuloong2e and lemote loongson2f family
> machines are the same, except the cs5536 support.
> 
> This patch renames ops-fuloong2e.c to ops-loongson2.c and then append
> the cs5536 support to share most of the source code among loongson
> machines.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Queued for 2.6.33.

Thanks!

  Ralf
