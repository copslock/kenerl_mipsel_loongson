Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Feb 2008 14:26:06 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:3024 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024692AbYBSO0E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Feb 2008 14:26:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1JEQ4lb015119;
	Tue, 19 Feb 2008 14:26:04 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1JEQ3P7015118;
	Tue, 19 Feb 2008 14:26:03 GMT
Date:	Tue, 19 Feb 2008 14:26:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mips: finish the Qemu platform removal
Message-ID: <20080219142603.GA15037@linux-mips.org>
References: <20080217200951.GI1403@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080217200951.GI1403@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 17, 2008 at 10:09:51PM +0200, Adrian Bunk wrote:

> The following files can now be removed:
> - arch/mips/configs/qemu_defconfig
> - include/asm-mips/qemu.h

Applied.  Thanks,

  Ralf
