Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2014 14:46:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52094 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6842554AbaHNMqz1r0s0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Aug 2014 14:46:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7ECkrPZ015169;
        Thu, 14 Aug 2014 14:46:53 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7ECkqYr015168;
        Thu, 14 Aug 2014 14:46:52 +0200
Date:   Thu, 14 Aug 2014 14:46:52 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: MSP71xx: remove unused plat_irq_dispatch()
 argument
Message-ID: <20140814124652.GE21008@linux-mips.org>
References: <1407967776-7320-1-git-send-email-ryazanov.s.a@gmail.com>
 <1407967776-7320-2-git-send-email-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1407967776-7320-2-git-send-email-ryazanov.s.a@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42095
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

On Thu, Aug 14, 2014 at 02:09:35AM +0400, Sergey Ryazanov wrote:

> Remove unused argument to make the plat_irq_dispatch() function
> declaration similar to the realization of other platforms.

The issue may be harmless but the regs argument of the false argument
isn't even being passed in!

  Ralf
