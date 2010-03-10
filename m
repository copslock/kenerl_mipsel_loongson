Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2010 17:13:19 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49867 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492609Ab0CJQNP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Mar 2010 17:13:15 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2AGDDJk016130;
        Wed, 10 Mar 2010 17:13:13 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2AGDCow016128;
        Wed, 10 Mar 2010 17:13:12 +0100
Date:   Wed, 10 Mar 2010 17:13:12 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <mano@roarinelk.homelinux.net>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [RFC PATCH] MIPS: Alchemy: add sysdev for both irq controllers
Message-ID: <20100310161312.GB15118@linux-mips.org>
References: <1268076181-29642-1-git-send-email-manuel.lauss@gmail.com>
 <1268076181-29642-2-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1268076181-29642-2-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 08, 2010 at 08:23:00PM +0100, Manuel Lauss wrote:

> From: Manuel Lauss <mano@roarinelk.homelinux.net>
> 
> Use a sysdev to implement PM methods for the Au1000 interrupt controllers.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Works on DB1200, not sure though whether this is the correct approach. 
> Applies cleanly only on top of "sleepcode-without-compile-time-cputype"
> patch.

At a quick glance this looks good but since you marked your patch as RFC
I'll do the same in patchwork (http://patchwork.linux-mips.org/patch/1039/)
until you ask me to queue it or resubmit.

Thanks,

  Ralf
