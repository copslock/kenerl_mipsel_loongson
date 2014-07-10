Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2014 13:18:39 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:58170 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860045AbaGJLSfMgjva (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Jul 2014 13:18:35 +0200
Received: from [188.251.62.23] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <luis.henriques@canonical.com>)
        id 1X5CMw-00023E-ER; Thu, 10 Jul 2014 11:18:30 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     Alex Smith <alex.smith@imgtec.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>,
        kernel-team@lists.ubuntu.com
Subject: [3.11.y.z extended stable] Patch "recordmcount/MIPS: Fix possible incorrect mcount_loc table entries in modules" has been added to staging queue
Date:   Thu, 10 Jul 2014 12:18:29 +0100
Message-Id: <1404991109-13707-1-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 1.9.1
X-Extended-Stable: 3.11
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41112
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

    recordmcount/MIPS: Fix possible incorrect mcount_loc table entries in modules

to the linux-3.11.y-queue branch of the 3.11.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.11.y-queue

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.11.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------
