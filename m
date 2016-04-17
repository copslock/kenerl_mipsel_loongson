Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Apr 2016 13:11:17 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:58613 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026803AbcDQLLPh4xZL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Apr 2016 13:11:15 +0200
Received: from localhost (unknown [64.88.227.134])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 13D2CB78;
        Sun, 17 Apr 2016 11:11:08 +0000 (UTC)
Subject: Patch "pcmcia: db1xxx_ss: fix last irq_to_gpio user" has been added to the 4.4-stable tree
To:     manuel.lauss@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 17 Apr 2016 03:32:42 -0700
Message-ID: <146088916265243@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53029
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

    pcmcia: db1xxx_ss: fix last irq_to_gpio user

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     pcmcia-db1xxx_ss-fix-last-irq_to_gpio-user.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
