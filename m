Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2016 23:02:36 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:40360 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992197AbcGFVAtjivUJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jul 2016 23:00:49 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bKtw7-0000ZJ-Eh; Wed, 06 Jul 2016 21:00:47 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bKtw4-0004QA-9V; Wed, 06 Jul 2016 14:00:44 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C3=84=C2=8Dm=C3=83=C2=A1=C3=85=E2=84=A2?= 
        <rkrcmar@redhat.com>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org,
        Kamal Mostafa <kamal@canonical.com>,
        kernel-team@lists.ubuntu.com
Subject: [3.19.y-ckt stable] Patch "MIPS: KVM: Fix timer IRQ race when freezing timer" has been added to the 3.19.y-ckt tree
Date:   Wed,  6 Jul 2016 14:00:43 -0700
Message-Id: <1467838843-16959-1-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Extended-Stable: 3.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54237
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

    MIPS: KVM: Fix timer IRQ race when freezing timer

to the linux-3.19.y-queue branch of the 3.19.y-ckt extended stable tree 
which can be found at:

    https://git.launchpad.net/~canonical-kernel/linux/+git/linux-stable-ckt/log/?h=linux-3.19.y-queue

This patch is scheduled to be released in version 3.19.8-ckt23.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.19.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

---8<------------------------------------------------------------
