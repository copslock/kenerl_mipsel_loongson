Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 17:49:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27291 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012266AbbHEPt3k2Bc0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 17:49:29 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id ADA1D38290C32;
        Wed,  5 Aug 2015 16:49:20 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 5 Aug 2015 16:49:23 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 5 Aug 2015 16:49:23 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-arch@vger.kernel.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/7] test_user_copy improvements
Date:   Wed, 5 Aug 2015 16:48:48 +0100
Message-ID: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

These patches extend the test_user_copy test module to handle lots more
cases of user accessors which architectures can override separately, and
in particular those which are important for checking the MIPS Enhanced
Virtual Addressing (EVA) implementations, which need to handle
overlapping user and kernel address spaces, with special instructions
for accessing user address space from kernel mode.

- Checking that kernel pointers are accepted when user address limit is
  set to KERNEL_DS, as done by the kernel when it internally invokes
  system calls with kernel pointers.
- Checking of the unchecked accessors (which don't call access_ok()).
  Some of the tests are special cased for EVA at the moment which has
  stricter hardware guarantees for bad user accesses than other
  configurations.
- Checking of other sets of user accessors, including the inatomic user
  copies, copy_in_user, clear_user, the user string accessors, and the
  user checksum functions, all of which need special handling in arch
  code with EVA.

Tested on MIPS with and without EVA, and on x86_64.

James Hogan (7):
  test_user_copy: Check legit kernel accesses
  test_user_copy: Check unchecked accessors
  test_user_copy: Check __clear_user()/clear_user()
  test_user_copy: Check __copy_in_user()/copy_in_user()
  test_user_copy: Check __copy_{to,from}_user_inatomic()
  test_user_copy: Check user string accessors
  test_user_copy: Check user checksum functions

 lib/test_user_copy.c | 221 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)

Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
-- 
2.3.6
