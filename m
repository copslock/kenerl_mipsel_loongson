Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 12:32:16 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:33894 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013203AbaKJLbnmiiqP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 12:31:43 +0100
Received: from bl20-155-74.dsl.telepac.pt ([2.81.155.74] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <luis.henriques@canonical.com>)
        id 1XnnC5-000179-7C; Mon, 10 Nov 2014 11:31:37 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     David Daney <david.daney@cavium.com>
Cc:     Huacai Chen <chenhc@lemote.com>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>,
        kernel-team@lists.ubuntu.com
Subject: [3.16.y-ckt extended stable] Patch "MIPS: tlbex: Properly fix HUGE TLB Refill exception handler" has been added to staging queue
Date:   Mon, 10 Nov 2014 11:31:36 +0000
Message-Id: <1415619096-8324-1-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 2.1.0
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

This is a note to let you know that I have just added a patch titled

    MIPS: tlbex: Properly fix HUGE TLB Refill exception handler

to the linux-3.16.y-queue branch of the 3.16.y-ckt extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.16.y-queue

This patch is scheduled to be released in version 3.16.7-ckt1.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.16.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------
