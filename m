Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Apr 2013 14:45:03 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38675 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825888Ab3DRMo6n07RQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Apr 2013 14:44:58 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r3ICiu17017228;
        Thu, 18 Apr 2013 14:44:56 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r3ICitNE017220;
        Thu, 18 Apr 2013 14:44:55 +0200
Date:   Thu, 18 Apr 2013 14:44:55 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lin Ming <minggr@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: hard lockup problem
Message-ID: <20130418124455.GA16655@linux-mips.org>
References: <CAF1ivSZXGY0dUSTVan-VuMVaQrtUOEZuRqhqmnNe-euCj03XAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1ivSZXGY0dUSTVan-VuMVaQrtUOEZuRqhqmnNe-euCj03XAA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36256
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

On Thu, Apr 18, 2013 at 03:13:55PM +0800, Lin Ming wrote:

> I encounter a problem that cpu stuck with irq disabled, which is known
> as hard lockup.
> I know there is NMI hard lockup detector for x86, which can dump the
> back trace of the hard lockup.
> 
> Is there any similar feature for MIPS?

No, there isn't, unfortunately.

This is because on MIPS an NMI is very different from for example x86.
An NMI goes straight to a firmware address and most firmware implementations
don't provided a suitable hook for an OS to gain control back from an NMI.

Generally on MIPS NMIs are used to signal catastrophic problems, things
like a machine check exception but external to the CPU.

One of the notable exceptions is Octeon where (see the Octeon watchdog
driver) an OS can regain control after an NMI.  Malta and SGI IP27 also
have somewhat useful NMIs.

  Ralf
