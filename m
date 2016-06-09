Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 16:38:49 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:58562 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27031940AbcFIOfPMYFdQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 16:35:15 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB139-0000Ua-Ev; Thu, 09 Jun 2016 14:35:11 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB136-00067g-PJ; Thu, 09 Jun 2016 07:35:08 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>,
        Petr Malat <oss@malat.biz>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Christopher Ferris <cferris@google.com>,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Mostafa <kamal@canonical.com>,
        kernel-team@lists.ubuntu.com
Subject: [4.2.y-ckt stable] Patch "SIGNAL: Move generic copy_siginfo() to signal.h" has been added to the 4.2.y-ckt tree
Date:   Thu,  9 Jun 2016 07:35:07 -0700
Message-Id: <1465482907-23501-1-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53946
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

    SIGNAL: Move generic copy_siginfo() to signal.h

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
