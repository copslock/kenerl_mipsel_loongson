Return-Path: <SRS0=9MN8=TA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DACC43219
	for <linux-mips@archiver.kernel.org>; Tue, 30 Apr 2019 11:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6112421670
	for <linux-mips@archiver.kernel.org>; Tue, 30 Apr 2019 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625281;
	bh=VcpKBqHheq+0zxr5mfTmUUIAIN1pPJCWkgC44Ioi6eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VgZM7TJS2kLyOJbsxttjKCoViCULxDdXnjc0ce+wts6tNqnuJ3zBllbpe0qlYwRE9
	 L38Juq5gVEBqb9iUoZyvkXNsOeLiEMbNv71fbrUBtYAkZZc0Jpau6sqJwmMW1x76nt
	 3JCD/FAaZPRjl0JbPVL0I0ebMlo6n8jy2HqIZ6/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfD3LuA (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbfD3Lt7 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 30 Apr 2019 07:49:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1AD92173E;
        Tue, 30 Apr 2019 11:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624999;
        bh=VcpKBqHheq+0zxr5mfTmUUIAIN1pPJCWkgC44Ioi6eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ja10iL6bC1ja59PDwGnq91fkFVpz3izxjHkkx66HeOZ03GPP7lmFkG3oP4S6aYiGW
         Iipq571P0J5xPg4k1zbp2+Rm8MUYF58wlHdU867We89QJHWBuNpRYIqDI5Eiqf7mrp
         AG9kr3B4Xf7hb1ynzDePH3id645usdUYvVdNvo8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH 5.0 18/89] MIPS: scall64-o32: Fix indirect syscall number load
Date:   Tue, 30 Apr 2019 13:38:09 +0200
Message-Id: <20190430113610.599586112@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Aurelien Jarno <aurelien@aurel32.net>

commit 79b4a9cf0e2ea8203ce777c8d5cfa86c71eae86e upstream.

Commit 4c21b8fd8f14 (MIPS: seccomp: Handle indirect system calls (o32))
added indirect syscall detection for O32 processes running on MIPS64,
but it did not work correctly for big endian kernel/processes. The
reason is that the syscall number is loaded from ARG1 using the lw
instruction while this is a 64-bit value, so zero is loaded instead of
the syscall number.

Fix the code by using the ld instruction instead. When running a 32-bit
processes on a 64 bit CPU, the values are properly sign-extended, so it
ensures the value passed to syscall_trace_enter is correct.

Recent systemd versions with seccomp enabled whitelist the getpid
syscall for their internal  processes (e.g. systemd-journald), but call
it through syscall(SYS_getpid). This fix therefore allows O32 big endian
systems with a 64-bit kernel to run recent systemd versions.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Cc: <stable@vger.kernel.org> # v3.15+
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/scall64-o32.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -125,7 +125,7 @@ trace_a_syscall:
 	subu	t1, v0,  __NR_O32_Linux
 	move	a1, v0
 	bnez	t1, 1f /* __NR_syscall at offset 0 */
-	lw	a1, PT_R4(sp) /* Arg1 for __NR_syscall case */
+	ld	a1, PT_R4(sp) /* Arg1 for __NR_syscall case */
 	.set	pop
 
 1:	jal	syscall_trace_enter


