Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2007 14:29:19 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:45770 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022255AbXGIN3R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jul 2007 14:29:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l69DLOu0011063;
	Mon, 9 Jul 2007 14:21:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l69DLM5O011062;
	Mon, 9 Jul 2007 14:21:22 +0100
Date:	Mon, 9 Jul 2007 14:21:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@stusta.de>
Cc:	James.Bottomley@HansenPartnership.com, ak@suse.de,
	linux-mips@linux-mips.org, discuss@x86-64.org,
	linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] cpu_callout_map cleanups
Message-ID: <20070709132122.GA10931@linux-mips.org>
References: <20070707010327.GX3492@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070707010327.GX3492@stusta.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 07, 2007 at 03:03:27AM +0200, Adrian Bunk wrote:

> - mips: removed extern for non-existing variable from header

There also is

include/linux/smp.h:#define num_booting_cpus()                  1

but num_booting_cpus() is only ever being used in i386-specific code.

I'm going to merge the MIPS bits of your patch.

  Ralf
