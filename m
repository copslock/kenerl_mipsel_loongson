Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Sep 2018 14:32:09 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992328AbeIPMcFvNxWN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Sep 2018 14:32:05 +0200
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A0EA3904;
        Sun, 16 Sep 2018 12:31:58 +0000 (UTC)
Subject: Patch "MIPS: VDSO: Match data page cache colouring when D$ aliases" has been added to the 4.14-stable tree
To:     alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org,
        hauke@hauke-m.de, jhogan@kernel.org, linux-mips@linux-mips.org,
        paul.burton@mips.com, rene.nielsen@microsemi.com
Cc:     <stable-commits@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Sep 2018 14:31:15 +0200
Message-ID: <15371010755354@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66343
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

    MIPS: VDSO: Match data page cache colouring when D$ aliases

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mips-vdso-match-data-page-cache-colouring-when-d-aliases.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.
