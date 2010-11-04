Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2010 16:31:07 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36897 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491875Ab0KDPbE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Nov 2010 16:31:04 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oA4FV1HE022694;
        Thu, 4 Nov 2010 15:31:02 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oA4FUwoK022693;
        Thu, 4 Nov 2010 15:30:58 GMT
Date:   Thu, 4 Nov 2010 15:30:57 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [BUG] The Perf support of MIPS is broken for the upstream changes
Message-ID: <20101104153055.GA22377@linux-mips.org>
References: <AANLkTinnya458ReBBaJtVFg3OP-XQE5MkeVnFT8zUeMN@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTinnya458ReBBaJtVFg3OP-XQE5MkeVnFT8zUeMN@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 04, 2010 at 11:20:19PM +0800, wu zhangjin wrote:

> $ git log {kernel/perf_event.c,include/linux/perf_event.h}
> 
> Of course, at first, you may need to clone/pull a latest mainline kernel.

Note that the linux-mips.org kernel repository is a superset of the
mainline kernel.  To reduce the confusion I just don't push any of Linus'
tags but the kernel objects are all there.

Anybody who wants to get Linus' tags or a linus branch as well can fetch
from Linus tree.  The size increase is minimal.

  Ralf
