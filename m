Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 12:00:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:1258 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021525AbXJILAg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 12:00:36 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l99B0ZnW005080;
	Tue, 9 Oct 2007 12:00:35 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l99B0ZJW005079;
	Tue, 9 Oct 2007 12:00:35 +0100
Date:	Tue, 9 Oct 2007 12:00:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	kaka <share.kt@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-git@linux-mips.org
Subject: Re: Fwd: Error opening framebuffer device
Message-ID: <20071009110035.GA4852@linux-mips.org>
References: <eea8a9c90710082258y5bbfc987h83f00d2b48d96fc6@mail.gmail.com> <eea8a9c90710082344r1beebc2bh507a0ba741efd364@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eea8a9c90710082344r1beebc2bh507a0ba741efd364@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 09, 2007 at 12:14:46PM +0530, kaka wrote:

> # insmod brcmstfb.ko
> brcmstfb: Unknown symbol unregister_framebuffer

It would help tremendously to enable framebuffer support.

> brcmstfb: Unknown symbol BKNI_EnterCriticalSection_tagged
> brcmstfb: Unknown symbol printf
> brcmstfb: Unknown symbol BKNI_DestroyEventGroup
> brcmstfb: Unknown symbol BKNI_WaitForEvent_tagged
> brcmstfb: Unknown symbol BKNI_Printf
> brcmstfb: Unknown symbol __divsf3

Floating point in the kernel that doesn't quite fly - unless you do
softfloat.

  Ralf
