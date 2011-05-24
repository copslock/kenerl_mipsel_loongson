Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2011 15:59:33 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43161 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491162Ab1EXN7a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 May 2011 15:59:30 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4ODxf7S000470;
        Tue, 24 May 2011 14:59:41 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4ODxfHd000466;
        Tue, 24 May 2011 14:59:41 +0100
Date:   Tue, 24 May 2011 14:59:40 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Pengfei Zhang <zoppof.zhang@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS:i8259.c remove resume and shutdown to syscore_ops
Message-ID: <20110524135940.GA30117@linux-mips.org>
References: <1306239558-4997-1-git-send-email-zoppof.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1306239558-4997-1-git-send-email-zoppof.zhang@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 24, 2011 at 08:19:18PM +0800, Pengfei Zhang wrote:

> Remove the resume and shutdown of i8259A from the sysdev_class
> to the syscore_ops since these members had removed from the
> structure sysdev_class.

I don't see why one would want to want to first call register_syscore_ops
then sysdev_class_register and sysdev_register?

  Ralf
