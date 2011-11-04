Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 13:21:13 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42132 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904102Ab1KDMVJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 13:21:09 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA4CL7wa008435;
        Fri, 4 Nov 2011 12:21:07 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA4CL6cM008429;
        Fri, 4 Nov 2011 12:21:06 GMT
Date:   Fri, 4 Nov 2011 12:21:06 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yong Zhang <yong.zhang0@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 12/49] MIPS: irq: Remove IRQF_DISABLED
Message-ID: <20111104122106.GA7581@linux-mips.org>
References: <1319277421-9203-1-git-send-email-yong.zhang0@gmail.com>
 <1319277421-9203-13-git-send-email-yong.zhang0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1319277421-9203-13-git-send-email-yong.zhang0@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3555

Thanks, queued for 3.3.  I resolved a conflict in dbdma.c and remove
one IRQF_DISABLED which had been missed in arch/mips/kernel/perf_event.c.

Thanks!

  Ralf
