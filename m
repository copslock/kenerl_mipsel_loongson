Received: with ECARTIS (v1.0.0; list linux-mips);
	Thu, 26 Jul 2012 23:21:47 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:37374 "EHLO
	mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1903827Ab2GZVVk (ORCPT
	<rfc822; linux-mips@linux-mips.org>); Thu, 26 Jul 2012 23:21:40 +0200
Received: by ghbf11 with SMTP id f11so2625512ghb.36
	for <linux-mips@linux-mips.org>; Thu, 26 Jul 2012 14:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
	:user-agent:x-gm-message-state;
	bh=o59BJ0tPhRhgsWemssR4Hx3W0wzRvmy60QntA9tFC6k=;
	b=IQY7xt7eVoyuuV4TxwA+GcjpLPUCW69ramh4rD+S4clr2cUzcfINwecrSGG7vMMlDM
	WN69eRi8lKHpHMgYQExgiQkX4TxUkhRdqYhQAQ7Q5mJ6Co37XvAxMeJx0G7m2t0ikN1m
	q8dLqY9tZq9S4FAytFdtp+jLxNaoGy68qaa/OD+eplPvhTRp/cnGGZ1ce2wqf//EI8BM
	PaLoVQ0vYR/yHdgtWs4wIih5NwgSy24oA/dsIWijScF02Oobym204BdgfycUsuQF/WkL
	Sa+Zm8rpRo4Asmr4F0jowTotL+4GCYfsI7Y7twK4yW0OdgJ4yGtPY5QHBSwRrVSaFJiR
	yjRA==
Received: by 10.66.74.36 with SMTP id q4mr550178pav.13.1343337689757;
	Thu, 26 Jul 2012 14:21:29 -0700 (PDT)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net.
	[67.168.183.230]) by mx.google.com with ESMTPS id
	rz10sm422016pbc.32.2012.07.26.14.21.27
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 26 Jul 2012 14:21:28 -0700 (PDT)
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	alan@lxorguk.ukuu.org.uk, David Daney <david.daney@cavium.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [ 14/23] MIPS: Properly align the .data..init_task section.
Date: Thu, 26 Jul 2012 14:19:53 -0700
Message-Id: <20120726211407.157467961@linuxfoundation.org>
X-Mailer: git-send-email 1.7.10.1.362.g242cab3
In-Reply-To: <20120726211405.959857593@linuxfoundation.org>
References: <20120726211420.GA7678@kroah.com>
	<20120726211405.959857593@linuxfoundation.org>
User-Agent: quilt/0.60-20.4
X-Gm-Message-State: ALoCoQmLF9owZAHUvGJ9pWExFSQQUCNts6J2RJZ+6Y9PJGdsvGtDrtDIqtK6gjefvVcXqkwF4xHM
X-archive-position: 33988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Greg KH <gregkh@linuxfoundation.org>

3.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Daney <david.daney@cavium.com>

commit 7b1c0d26a8e272787f0f9fcc5f3e8531df3b3409 upstream.

Improper alignment can lead to unbootable systems and/or random
crashes.

[ralf@linux-mips.org: This is a lond standing bug since
6eb10bc9e2deab06630261cd05c4cb1e9a60e980 (kernel.org) rsp.
c422a10917f75fd19fa7fe070aaaa23e384dae6f (lmo) [MIPS: Clean up linker script
using new linker script macros.] so dates back to 2.6.32.]

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/3881/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
arch/mips/include/asm/thread_info.h |    4 ++--
 arch/mips/kernel/vmlinux.lds.S      |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -60,6 +60,8 @@ struct thread_info {
 register struct thread_info *__current_thread_info __asm__("$28");
 #define current_thread_info()  __current_thread_info
 
+#endif /* !__ASSEMBLY__ */
+
 /* thread information allocation */
 #if defined(CONFIG_PAGE_SIZE_4KB) && defined(CONFIG_32BIT)
 #define THREAD_SIZE_ORDER (1)
@@ -97,8 +99,6 @@ register struct thread_info *__current_t
 
 #define free_thread_info(info) kfree(info)
 
-#endif /* !__ASSEMBLY__ */
-
 #define PREEMPT_ACTIVE		0x10000000
 
 /*
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -1,5 +1,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/page.h>
+#include <asm/thread_info.h>
 #include <asm-generic/vmlinux.lds.h>
 
 #undef mips
@@ -73,7 +74,7 @@ SECTIONS
 	.data : {	/* Data */
 		. = . + DATAOFFSET;		/* for CONFIG_MAPPED_KERNEL */
 
-		INIT_TASK_DATA(PAGE_SIZE)
+		INIT_TASK_DATA(THREAD_SIZE)
 		NOSAVE_DATA
 		CACHELINE_ALIGNED_DATA(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
 		READ_MOSTLY_DATA(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
>From patchwork Thu Jul 26 21:19:53 2012
Received: from localhost.localdomain ([127.0.0.1]:49942 "EHLO
	eddie.linux-mips.org" rhost-flags-OK-OK-OK-FAIL)
	by eddie.linux-mips.org with ESMTP id S1903787Ab2GZVal (ORCPT
	<rfc822;patchwork@linux-mips.org>); Thu, 26 Jul 2012 23:30:41 +0200
Received: with ECARTIS (v1.0.0; list linux-mips);
	Thu, 26 Jul 2012 23:30:24 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:38446 "EHLO
	mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1903782Ab2GZVaT (ORCPT
	<rfc822; linux-mips@linux-mips.org>); Thu, 26 Jul 2012 23:30:19 +0200
Received: by ggcs5 with SMTP id s5so2630301ggc.36
	for <linux-mips@linux-mips.org>; Thu, 26 Jul 2012 14:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
	:user-agent:x-gm-message-state;
	bh=MiDzq5Kk0iwo/c1nHYZO3Ozr7JXCWxeXk7Z2OZl37pw=;
	b=AUabfj3IfkIGfqF42OdAI8ssH0FY6AzKkDHil+FI6MZZ8j/C0qOwaQNEwrELQ5doKo
	UFOr//IMnWkQsX7XJCKp8BKS4MOpc6wfcKNyKzni5rl+SKNv293KlmoPPY3SF9tFSARI
	CSDulxkEtmGvHGKWpgaVnzi2qa+3qi1GUozjRLWKV/G7UZT+VvD2CULAFO8cuchiJHsZ
	HvoAxNqMUNclangSGcajUP6yraf7mMNJUcEY9M02IGr8ngBJ2Sk2MI+Z/QLK7ZziZbgw
	oJxioAD82LprZdQAnPb43jCwFClJ60Jq1ePjuRXHzvWTJNh47c0CQu6Ef0xXXhALkhhK
	5Ikw==
Received: by 10.66.87.2 with SMTP id t2mr560252paz.22.1343338212476;
	Thu, 26 Jul 2012 14:30:12 -0700 (PDT)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net.
	[67.168.183.230])
	by mx.google.com with ESMTPS id wi6sm433224pbc.35.2012.07.26.14.30.10
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 26 Jul 2012 14:30:11 -0700 (PDT)
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	alan@lxorguk.ukuu.org.uk, David Daney <david.daney@cavium.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [ 04/40] MIPS: Properly align the .data..init_task section.
Date: Thu, 26 Jul 2012 14:29:22 -0700
Message-Id: <20120726211411.443368067@linuxfoundation.org>
X-Mailer: git-send-email 1.7.10.1.362.g242cab3
In-Reply-To: <20120726211411.164006056@linuxfoundation.org>
References: <20120726211424.GA7709@kroah.com>
	<20120726211411.164006056@linuxfoundation.org>
User-Agent: quilt/0.60-20.4
X-Gm-Message-State: ALoCoQlyrynR6POXahUUboagsvOGcv8ctEaTKn6doJyP7M5vVFpgr2dd7NMsA4SRca6CLT3gzroR
X-archive-position: 33989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>
Content-Length: 2076
Lines: 66

From: Greg KH <gregkh@linuxfoundation.org>

3.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Daney <david.daney@cavium.com>

commit 7b1c0d26a8e272787f0f9fcc5f3e8531df3b3409 upstream.

Improper alignment can lead to unbootable systems and/or random
crashes.

[ralf@linux-mips.org: This is a lond standing bug since
6eb10bc9e2deab06630261cd05c4cb1e9a60e980 (kernel.org) rsp.
c422a10917f75fd19fa7fe070aaaa23e384dae6f (lmo) [MIPS: Clean up linker script
using new linker script macros.] so dates back to 2.6.32.]

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/3881/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
arch/mips/include/asm/thread_info.h |    4 ++--
 arch/mips/kernel/vmlinux.lds.S      |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -60,6 +60,8 @@ struct thread_info {
 register struct thread_info *__current_thread_info __asm__("$28");
 #define current_thread_info()  __current_thread_info
 
+#endif /* !__ASSEMBLY__ */
+
 /* thread information allocation */
 #if defined(CONFIG_PAGE_SIZE_4KB) && defined(CONFIG_32BIT)
 #define THREAD_SIZE_ORDER (1)
@@ -97,8 +99,6 @@ register struct thread_info *__current_t
 
 #define free_thread_info(info) kfree(info)
 
-#endif /* !__ASSEMBLY__ */
-
 #define PREEMPT_ACTIVE		0x10000000
 
 /*
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -1,5 +1,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/page.h>
+#include <asm/thread_info.h>
 #include <asm-generic/vmlinux.lds.h>
 
 #undef mips
@@ -72,7 +73,7 @@ SECTIONS
 	.data : {	/* Data */
 		. = . + DATAOFFSET;		/* for CONFIG_MAPPED_KERNEL */
 
-		INIT_TASK_DATA(PAGE_SIZE)
+		INIT_TASK_DATA(THREAD_SIZE)
 		NOSAVE_DATA
 		CACHELINE_ALIGNED_DATA(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
 		READ_MOSTLY_DATA(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
>From linux-mips-bounce@linux-mips.org  Fri Jul 27 11:38:48 2012
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on eddie.linux-mips.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FROM,RDNS_NONE,T_TO_NO_BRKTS_FREEMAIL autolearn=no version=3.3.2
Received: from localhost.localdomain ([127.0.0.1]:47262 "EHLO
        eddie.linux-mips.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1903523Ab2G0Jir (ORCPT
        <rfc822;ralf@linux-mips.org>); Fri, 27 Jul 2012 11:38:47 +0200
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2012 11:38:31 +0200 (CEST)
Received: from sam.nabble.com ([216.139.236.26]:55450 "EHLO sam.nabble.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903480Ab2G0Ji0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jul 2012 11:38:26 +0200
Received: from telerig.nabble.com ([192.168.236.162])
        by sam.nabble.com with esmtp (Exim 4.72)
        (envelope-from <lists@nabble.com>)
        id 1Suh04-0007sg-9f
        for linux-mips@linux-mips.org; Fri, 27 Jul 2012 02:38:24 -0700
Message-ID: <34219711.post@talk.nabble.com>
Date:   Fri, 27 Jul 2012 02:38:24 -0700 (PDT)
From:   JoeJ <tttechmail@gmail.com>
To:     linux-mips@linux-mips.org
Subject: SMVP Support on MIPS34KC (linux-2.6.35)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: tttechmail@gmail.com
X-archive-position: 33990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tttechmail@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>
Content-Length: 1040
Lines: 24


Hi,
 we are using mips34Kc processor & are facing some issues while enabling
SMVP (2 VPEs with 1 TC attached to each VPE) support on the same. We are
using linux-2.6.35 kernel downloaded from malta repository. The issue is
seen during system boot-up with the control looping in the function
stop_machine_cpu_stop. The CPU freezes after the message "Switching to
clocksource" . On further debugging, we observed that the function
stop_machine_cpu_stop (defined in kernel/stop_machine.c) loops continuously
in the 'do while' loop with the condition 'if (smdata->state != curstate)'
never matching. The value of curstate is '1' even after we try to
re-initialize to 0. What could be going wrong here?

We use External timer interrupt as clocksource. One timer interrupt routed
on to vpe0 & another timer interrupt routed on to vpe1. 

Regards,
Joe


-- 
View this message in context: http://old.nabble.com/SMVP-Support-on-MIPS34KC-%28linux-2.6.35%29-tp34219711p34219711.html
Sent from the linux-mips main mailing list archive at Nabble.com.
