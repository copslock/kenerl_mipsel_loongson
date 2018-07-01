Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Jul 2018 13:40:21 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38348 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993104AbeGALjmgahc1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Jul 2018 13:39:42 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EBDFA720;
        Sun,  1 Jul 2018 11:39:35 +0000 (UTC)
Subject: Patch "time: Make sure jiffies_to_msecs() preserves non-zero time periods" has been added to the 4.17-stable tree
To:     20180622143357.7495-1-geert@linux-m68k.org, arnd@arndb.de,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        john.stultz@linaro.org, linux-mips@linux-mips.org,
        sboyd@kernel.org, tglx@linutronix.de
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 01 Jul 2018 13:38:45 +0200
Message-ID: <15304451257035@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64514
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

    time: Make sure jiffies_to_msecs() preserves non-zero time periods

to the 4.17-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     time-make-sure-jiffies_to_msecs-preserves-non-zero-time-periods.patch
and it can be found in the queue-4.17 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
