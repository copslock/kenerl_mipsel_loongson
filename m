Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 17:49:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45042 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827461Ab3FJPtrWJIrp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 17:49:47 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5AFnj3n011468;
        Mon, 10 Jun 2013 17:49:45 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5AFniqg011467;
        Mon, 10 Jun 2013 17:49:44 +0200
Date:   Mon, 10 Jun 2013 17:49:44 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Alchemy: fix wait function
Message-ID: <20130610154944.GB5303@linux-mips.org>
References: <1369315716-7408-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369315716-7408-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, May 23, 2013 at 03:28:36PM +0200, Manuel Lauss wrote:

> Only an interrupt can wake the core from 'wait', enable interrupts
> locally before executing 'wait'.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Ralf made me aware of the race in between enabling interrupts and
> entering wait.  While this patch does not eliminate it, it shrinks it
> to 1 instruction.  It's not perfect, but lets Alchemy boot until a
> more sophisticated solution (like __r4k_wait) can be implemented
> without having to duplicate the interrupt exception handler.

It doesn't shrink it - interrupts will be pending from the time they
were disabled to the point where they get re-enabled.  That can be quite
a few cycles and so the likelyhood for hitting the race is not that low.

  Ralf
