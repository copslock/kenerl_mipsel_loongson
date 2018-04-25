Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 18:01:58 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42358 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990502AbeDYQBushJfB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 18:01:50 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9701293C;
        Wed, 25 Apr 2018 16:01:43 +0000 (UTC)
Subject: Patch "irqchip/mips-gic: Fix local interrupts" has been added to the 4.9-stable tree
To:     amit.pundir@linaro.org, gregkh@linuxfoundation.org,
        jason@lakedaemon.net, linux-mips@linux-mips.org,
        marc.zyngier@arm.com, marcin.nowakowski@imgtec.com,
        paul.burton@imgtec.com, tglx@linutronix.de
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 25 Apr 2018 18:01:25 +0200
Message-ID: <1524672085206172@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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


This is a note to let you know that I've just added the patch titled

    irqchip/mips-gic: Fix local interrupts

to the 4.9-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     irqchip-mips-gic-fix-local-interrupts.patch
and it can be found in the queue-4.9 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
