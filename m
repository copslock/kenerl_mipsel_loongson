Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2011 15:31:11 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52637 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491162Ab1EXNbI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 May 2011 15:31:08 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4ODVIWB030258;
        Tue, 24 May 2011 14:31:18 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4ODVHVk030254;
        Tue, 24 May 2011 14:31:17 +0100
Date:   Tue, 24 May 2011 14:31:17 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Pengfei Zhang <zoppof.zhang@gmail.com>
Subject: Re: [PATCH] MIPS: Use struct syscore_ops instead of sysdevs for i8259
Message-ID: <20110524133117.GA3292@linux-mips.org>
References: <20110520224141.5eb118ff.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110520224141.5eb118ff.yuasa@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 20, 2011 at 10:41:41PM +0900, Yoichi Yuasa wrote:

Thanks, applied.

  Ralf
