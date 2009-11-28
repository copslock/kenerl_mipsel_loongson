Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Nov 2009 12:05:59 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:46794 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492479AbZK1LFx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Nov 2009 12:05:53 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nASB6AWN022482;
        Sat, 28 Nov 2009 11:06:10 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nASB69Es022480;
        Sat, 28 Nov 2009 11:06:09 GMT
Date:   Sat, 28 Nov 2009 11:06:08 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v1] MIPS: Loongson: Cleanups of serial port support
Message-ID: <20091128110608.GA14340@linux-mips.org>
References: <4eb67c3e4c7df40a71832bbda3b265606b6096be.1259389212.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eb67c3e4c7df40a71832bbda3b265606b6096be.1259389212.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Nov 28, 2009 at 02:21:50PM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> (This revision is rebased on the latest linux-queue.)
> 
> This patchs uses a loongson_uart_base variable instead of the
> uart_base[] array and adds a new kernel option to avoid to compile
> uart_base.c all the time, which will save a little bit of memory for us.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Thanks, queued this one.

  Ralf
