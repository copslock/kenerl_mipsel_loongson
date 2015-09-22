Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 02:32:54 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:43333 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009071AbbIVAcho7NdW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 02:32:37 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ZeBVc-00050r-Lt; Tue, 22 Sep 2015 00:32:36 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1ZeBVa-0004Bc-Ep; Mon, 21 Sep 2015 17:32:34 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>,
        kernel-team@lists.ubuntu.com
Subject: [3.13.y-ckt stable] Patch "MIPS: Make set_pte() SMP safe." has been added to staging queue
Date:   Mon, 21 Sep 2015 17:32:33 -0700
Message-Id: <1442881953-16035-1-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
X-Extended-Stable: 3.13
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

    MIPS: Make set_pte() SMP safe.

to the linux-3.13.y-queue branch of the 3.13.y-ckt extended stable tree 
which can be found at:

    http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=linux-3.13.y-queue

This patch is scheduled to be released in version 3.13.11-ckt27.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.13.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

------
