Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 13:40:01 +0200 (CEST)
Received: from mail7.hitachi.co.jp ([133.145.228.42]:44429 "EHLO
        mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009557AbbGJLj4ofmMT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 13:39:56 +0200
Received: from mlsv5.hitachi.co.jp (unknown [133.144.234.166])
        by mail7.hitachi.co.jp (Postfix) with ESMTP id 888D1B1D385;
        Fri, 10 Jul 2015 20:39:54 +0900 (JST)
Received: from mfilter05.hitachi.co.jp by mlsv5.hitachi.co.jp (8.13.1/8.13.1) id t6ABdscK001978; Fri, 10 Jul 2015 20:39:54 +0900
Received: from vshuts02.hitachi.co.jp (vshuts02.hitachi.co.jp [10.201.6.84])
        by mfilter05.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id t6ABdq2h019859;
        Fri, 10 Jul 2015 20:39:53 +0900
Received: from hsdlmain.sdl.hitachi.co.jp (unknown [133.144.14.194])
        by vshuts02.hitachi.co.jp (Postfix) with ESMTP id 9E5D0490041;
        Fri, 10 Jul 2015 20:39:52 +0900 (JST)
Received: from hsdlvgate2.sdl.hitachi.co.jp by hsdlmain.sdl.hitachi.co.jp (8.13.8/3.7W11021512) id t6ABdq03008822; Fri, 10 Jul 2015 20:39:52 +0900
X-AuditID: 85900ec0-9f5ccb9000001a57-6b-559faef188b9
Received: from sdl99w.sdl.hitachi.co.jp (sdl99w.yrl.intra.hitachi.co.jp [133.144.14.250])
        by hsdlvgate2.sdl.hitachi.co.jp (Symantec Mail Security) with ESMTP id 8E318236561;
        Fri, 10 Jul 2015 20:39:29 +0900 (JST)
Received: from mailb.sdl.hitachi.co.jp (sdl99b.yrl.intra.hitachi.co.jp [133.144.14.197])
        by sdl99w.sdl.hitachi.co.jp (Postfix) with ESMTP id 1107253C21A;
        Fri, 10 Jul 2015 20:39:52 +0900 (JST)
Received: from [10.198.219.30] (unknown [10.198.219.30])
        by mailb.sdl.hitachi.co.jp (Postfix) with ESMTP id C0FB5495B93;
        Fri, 10 Jul 2015 20:39:51 +0900 (JST)
X-Mailbox-Line: From nobody Fri Jul 10 20:33:31 2015
Subject: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump is
 not available
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>
From:   Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc:     linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
        linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Daniel Walker <dwalker@fifo99.com>,
        linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 10 Jul 2015 20:33:31 +0900
Message-ID: <20150710113331.4368.63745.stgit@softrs>
In-Reply-To: <20150710113331.4368.10495.stgit@softrs>
References: <20150710113331.4368.10495.stgit@softrs>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAA==
Return-Path: <hidehiro.kawai.ez@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hidehiro.kawai.ez@hitachi.com
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

You can call panic notifiers and kmsg dumpers before kdump by
specifying "crash_kexec_post_notifiers" as a boot parameter.
However, it doesn't make sense if kdump is not available.  In that
case, disable "crash_kexec_post_notifiers" boot parameter so that
you can't change the value of the parameter.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
---
 kernel/panic.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 04e91ff..5252331 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -502,12 +502,14 @@ __visible void __stack_chk_fail(void)
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
 
+#ifdef CONFIG_CRASH_DUMP
 static int __init setup_crash_kexec_post_notifiers(char *s)
 {
 	crash_kexec_post_notifiers = true;
 	return 0;
 }
 early_param("crash_kexec_post_notifiers", setup_crash_kexec_post_notifiers);
+#endif
 
 static int __init oops_setup(char *s)
 {
