Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 16:34:34 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:58387 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006657AbcFIOecvAAlQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 16:34:32 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB12U-0000Qe-S7; Thu, 09 Jun 2016 14:34:31 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB12S-0005gS-6A; Thu, 09 Jun 2016 07:34:28 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Christopher Ferris <cferris@google.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>,
        kernel-team@lists.ubuntu.com
Subject: [4.2.y-ckt stable] Patch "MIPS: Fix siginfo.h to use strict posix types" has been added to the 4.2.y-ckt tree
Date:   Thu,  9 Jun 2016 07:34:27 -0700
Message-Id: <1465482867-21813-1-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53934
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

    MIPS: Fix siginfo.h to use strict posix types

to the linux-4.2.y-queue branch of the 4.2.y-ckt extended stable tree 
which can be found at:

    https://git.launchpad.net/~canonical-kernel/linux/+git/linux-stable-ckt/log/?h=linux-4.2.y-queue

This patch is scheduled to be released in version 4.2.8-ckt12.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 4.2.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

---8<------------------------------------------------------------
