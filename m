Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 19:33:25 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:51447 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013873AbcBYSdVQ0Zal (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 19:33:21 +0100
Received: from av-217-129-142-138.netvisao.pt ([217.129.142.138] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <luis.henriques@canonical.com>)
        id 1aZ0j2-0000Es-Jh; Thu, 25 Feb 2016 18:33:20 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Milko Leporis <milko.leporis@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>,
        kernel-team@lists.ubuntu.com
Subject: [3.16.y-ckt stable] Patch "MIPS: Fix buffer overflow in syscall_get_arguments()" has been added to the 3.16.y-ckt tree
Date:   Thu, 25 Feb 2016 18:33:19 +0000
Message-Id: <1456425199-16687-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52271
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

    MIPS: Fix buffer overflow in syscall_get_arguments()

to the linux-3.16.y-queue branch of the 3.16.y-ckt extended stable tree 
which can be found at:

    http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=linux-3.16.y-queue

This patch is scheduled to be released in version 3.16.7-ckt25.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.16.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

---8<------------------------------------------------------------
