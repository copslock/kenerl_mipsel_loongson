Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2009 14:17:12 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58110 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492649AbZKJNRI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Nov 2009 14:17:08 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAADGqvx030787;
	Tue, 10 Nov 2009 14:16:52 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAADGk8T030775;
	Tue, 10 Nov 2009 14:16:46 +0100
Date:	Tue, 10 Nov 2009 14:16:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 3/7] [loongson] lemote-2f: add basic cs5536 vsm
	support
Message-ID: <20091110131646.GH18773@linux-mips.org>
References: <cover.1257781987.git.wuzhangjin@gmail.com> <969a9b991c745c3ff7ee1c47ac240499af629f27.1257781987.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969a9b991c745c3ff7ee1c47ac240499af629f27.1257781987.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 10, 2009 at 12:06:12AM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Lemote loongson2f family machines use cs5536 as their south bridge, need
> these lowlevel interfaces to access the devices on cs5536.
> 
> This patch try to virtulize the legacy devices on cs5536 as PCI devices,
> So, users can access the PCI configure space of cs5536 directly as a
> normal multi-function PCI device which follows the PCI-2.2 spec.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Queued for 2.6.33 - but the idea of pretending a PCI device for something
that isn't really one is inelegant to say the least.  Maybe this should be
platform devices intead.

Thanks!

  Ralf
