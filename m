Return-Path: <SRS0=+ZmA=SZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952B9C10F03
	for <linux-mips@archiver.kernel.org>; Tue, 23 Apr 2019 20:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EC7218D3
	for <linux-mips@archiver.kernel.org>; Tue, 23 Apr 2019 20:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NIm7S/05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfDWUz3 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:55:29 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:53574 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfDWUz3 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 23 Apr 2019 16:55:29 -0400
Received: by mail-pg1-f202.google.com with SMTP id f7so10701818pgi.20
        for <linux-mips@vger.kernel.org>; Tue, 23 Apr 2019 13:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EMjKTluV8E+qBr/4JM2DWbyEMJk+9Wk2onaYSOfzL3s=;
        b=NIm7S/05ZnH3qtSdKADbfTY64hdv5puEmb7cOttJ23jX52RR8fRJsVEYkmjLF/niXk
         YTIbsO2K8SM/EdFXrfI+5AkBhka6+UMRMajoINN60ZhFDIeTgmWHRR9JLbag5vwvHZn6
         91OO8vbyzb89Dja+8e5HqPyZ/L/C5YYakWNe+f9MtPR7MWu6YN+zKBCS6gv/jS/dd8Jx
         6jJNSgk5Sn1x4rxgcgai1aayaDo5PxU4rNXle+s4o6Lf61unG9R/4LCwl47P12Kei6sI
         /E23WgzfDuVUO/Q6Ibw3S3fhO6hkTwfB68qvjemloY/tyKt2otsjPCLwjMoVeO4T0Olx
         At4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EMjKTluV8E+qBr/4JM2DWbyEMJk+9Wk2onaYSOfzL3s=;
        b=U7EPKyfeDfjafP7KfR9sxd7SVmQWl6gQ2T7H6N31HysPVvPluPAtlZkNlUkBxTdpww
         wwa428yax41pEgg00IoAbeMryGrH/DUa9beQwToEL5U1vi/h837JP3ALA30xpYcQrS6p
         FZKGt43Tix06M9JWWoerwQUvYV5o8NkHlebVshaPZDTpyrhCvG16k2SO0nwzIF89Z7oB
         DB6X7RJkziGnXZpOvWYw1+sCbyzdcnFZKgY2yiSh1kog51TCZOP5IuxIclvoc09w28pO
         383ggUD7BdtQpOpcwR6l4ZnzR3W/1pKGGFK9I+Z6LCq+K+WCKZn1OIMNQA3SuhbrAC2u
         jtDg==
X-Gm-Message-State: APjAAAUrq8NWQ4wurkQYx9IY91MjPwjMma0ugw/lRf/aYY97tbpGdnlp
        B2aYtJNMnx3hUH25mY/4f8uQaTQ7ElUHTqFvtgA=
X-Google-Smtp-Source: APXvYqz4gAhA8k5Maz6flj/armSFK/B7DYFTv591B0Q4kozBMJs1VxRJUbgCP+ZR3eXLbvMT5uQBs7xd44PmAuvSalU=
X-Received: by 2002:a63:2b0d:: with SMTP id r13mr27028919pgr.400.1556052928509;
 Tue, 23 Apr 2019 13:55:28 -0700 (PDT)
Date:   Tue, 23 Apr 2019 13:55:19 -0700
Message-Id: <20190423205521.246828-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] mips: vdso: drop unnecessary cc-ldoption
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Joel Stanley <joel@jms.id.au>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Towards the goal of removing cc-ldoption, it seems that --hash-style=
was added to binutils 2.17.50.0.2 in 2006. The minimal required version
of binutils for the kernel according to
Documentation/process/changes.rst is 2.20.

--build-id was added in 2.18 according to binutils-gdb/ld/NEWS.

Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
Cc: clang-built-linux@googlegroups.com
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/mips/vdso/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 0ede4deb8181..7221df24cb23 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -46,9 +46,7 @@ endif
 VDSO_LDFLAGS := \
 	-Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1 \
 	$(addprefix -Wl$(comma),$(filter -E%,$(KBUILD_CFLAGS))) \
-	-nostdlib -shared \
-	$(call cc-ldoption, -Wl$(comma)--hash-style=sysv) \
-	$(call cc-ldoption, -Wl$(comma)--build-id)
+	-nostdlib -shared -Wl,--hash-style=sysv -Wl,--build-id
 
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
-- 
2.21.0.593.g511ec345e18-goog

