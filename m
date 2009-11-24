Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 17:29:55 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34722 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S1492785AbZKXQ3x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Nov 2009 17:29:53 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAOGU7HL011360;
	Tue, 24 Nov 2009 16:30:07 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAOGU6IA011358;
	Tue, 24 Nov 2009 16:30:06 GMT
Date:	Tue, 24 Nov 2009 16:30:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: EARLY_PRINTK: Fixup of dependency
Message-ID: <20091124163006.GA11277@linux-mips.org>
References: <1259055230-15818-1-git-send-email-wuzhangjin@gmail.com> <f861ec6f0911240824u187347d6od5bfebc509a27d8d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f861ec6f0911240824u187347d6od5bfebc509a27d8d@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 24, 2009 at 05:24:57PM +0100, Manuel Lauss wrote:

> On Tue, Nov 24, 2009 at 10:33 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> [...]
> > This patch will only enable that option when the DEBUG_KERNEL is
> > enabled.
> 
> How about making it independent from DEBUG_KERNEL altogether?  If find
> it useful even without full debug info.

DEBUG_INFO controlls the generation of ELF debug information.  DEBUG_KERNEL
only hides most of the debugging options.

  Ralf
