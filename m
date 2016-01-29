Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2016 15:04:58 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:47569 "EHLO
        linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010757AbcA2ODiUxM-r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2016 15:03:38 +0100
Received: from localhost (handman.bmw-carit.intra [192.168.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linuxmail.bmw-carit.de (Postfix) with ESMTPS id 9482A59CFC;
        Fri, 29 Jan 2016 14:47:27 +0100 (CET)
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, linux-mips@linux-mips.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Maik Broemme <mbroemme@plusserver.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH tip v7 4/7] kbuild: Add option to turn incompatible pointer check into error
Date:   Fri, 29 Jan 2016 15:03:25 +0100
Message-Id: <1454076208-28354-5-git-send-email-daniel.wagner@bmw-carit.de>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
References: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
Return-Path: <daniel.wagner@oss.bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.wagner@bmw-carit.de
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

With the introduction of the simple wait API we have two very
similar APIs in the kernel. For example wake_up() and swake_up()
is only one character away. Although the compiler will warn
happily the wrong usage it keeps on going an even links the kernel.
Thomas and Peter would rather like to see early missuses reported
as error early on.

In a first attempt we tried to wrap all swait and wait calls
into a macro which has an compile time type assertion. The result
was pretty ugly and wasn't able to catch all wrong usages.
woken_wake_function(), autoremove_wake_function() and wake_bit_function()
are assigned as function pointers. Wrapping them with a macro around is
not possible. Prefixing them with '_' was also not a real option
because there some users in the kernel which do use them as well.
All in all this attempt looked to intrusive and too ugly.

An alternative is to turn the pointer type check into an error which
catches wrong type uses. Obviously not only the swait/wait ones. That
isn't a bad thing either.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 9d94ade..adfb6a08 100644
--- a/Makefile
+++ b/Makefile
@@ -767,6 +767,9 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=strict-prototypes)
 # Prohibit date/time macros, which would make the build non-deterministic
 KBUILD_CFLAGS   += $(call cc-option,-Werror=date-time)
 
+# enforce correct pointer usage
+KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
+
 # use the deterministic mode of AR if available
 KBUILD_ARFLAGS := $(call ar-option,D)
 
-- 
2.5.0
