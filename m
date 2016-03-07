Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2016 23:31:59 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:49101 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006883AbcCGWb5hscfa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Mar 2016 23:31:57 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ad3gy-0007G5-Vl; Mon, 07 Mar 2016 22:31:57 +0000
Received: from kamal by fourier with local (Exim 4.86)
        (envelope-from <kamal@whence.com>)
        id 1ad3gw-00074R-Aa; Mon, 07 Mar 2016 14:31:54 -0800
From:   Kamal Mostafa <kamal@canonical.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Milko Leporis <milko.leporis@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>,
        kernel-team@lists.ubuntu.com
Subject: [4.2.y-ckt stable] Patch "MIPS: Fix buffer overflow in syscall_get_arguments()" has been added to the 4.2.y-ckt tree
Date:   Mon,  7 Mar 2016 14:31:53 -0800
Message-Id: <1457389913-27144-1-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.0
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52544
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

    MIPS: Fix buffer overflow in syscall_get_arguments()

to the linux-4.2.y-queue branch of the 4.2.y-ckt extended stable tree 
which can be found at:

    http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=linux-4.2.y-queue

This patch is scheduled to be released in version 4.2.8-ckt5.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 4.2.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

---8<------------------------------------------------------------
