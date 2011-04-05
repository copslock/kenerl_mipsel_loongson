Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2011 14:21:40 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33443 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491778Ab1DEMVh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Apr 2011 14:21:37 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p35CLWHD009222;
        Tue, 5 Apr 2011 14:21:32 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p35CLSXd009215;
        Tue, 5 Apr 2011 14:21:28 +0200
Date:   Tue, 5 Apr 2011 14:21:28 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "wilbur.chan" <wilbur512@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "Jayachandran C." <jayachandranc@netlogicmicro.com>
Subject: Re: System suffers frequent TLB miss
Message-ID: <20110405122128.GB31210@linux-mips.org>
References: <BANLkTikpqk-UcFHHD6MGyZgv6LociaETtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTikpqk-UcFHHD6MGyZgv6LociaETtg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 03, 2011 at 11:49:13AM +0800, wilbur.chan wrote:

> We have a system running on mips64 xlr 732.  Our major application
> process is binded on CPU5,
> 
> In order to reduce the tlb miss of our major process, we took the
> following steps:

What page size are you using?  If you're still using 4K pages, try switching
to 16K or even 64K pages.  You also may want to look into using hugetlbfs.

  Ralf
