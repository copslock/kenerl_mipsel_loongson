Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jul 2014 00:32:39 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:56141 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861405AbaGRWcefOyFx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jul 2014 00:32:34 +0200
Received: by mail-pa0-f51.google.com with SMTP id ey11so6250455pad.38
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 15:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EaJnqVjwsKq2SIMr8Jg1Vllx0lnBouK3/5FMaDQ3kdY=;
        b=k5ooiTBlpQFMyzZwKlcHBpC5oxG6fPFqvLmNNX60U8aRFiUEaVEbhtXpA6YfZ9PCmZ
         iSwOEQY83kBvsUmrPdNMbDI5Vb2cAe5pf9s+gYm9Z78TgVhS+nRtFqI2yq+KeuIodnpT
         RT6zROSo+3rfHgennXO3Fiz628zA9GUGVw7bKuE9+LlIjg+brVyK6VANTrg9XEIO299V
         TZ4MpUCIqUMWvzcmhVVMSoc9gauObbwkji84rrS6RFM/C+3kaqE/NqdvF07dK/cwIU8g
         S47Igaho2CPCxYcN+ofpj4PXcrDz4hUdUTUucF0vHTjgjiWSkV9NOzx7lhTCyQyL8bSP
         IcYw==
X-Gm-Message-State: ALoCoQlQY4681RwP4P/POYMA84D+PRyUpTKxZQCfzElhMf67MqD3+c0/n0YVlUCbbQeBi0pzea4x
X-Received: by 10.66.182.132 with SMTP id ee4mr8773600pac.64.1405722748140;
        Fri, 18 Jul 2014 15:32:28 -0700 (PDT)
Received: from localhost (50-76-60-73-ip-static.hfc.comcastbusiness.net. [50.76.60.73])
        by mx.google.com with ESMTPSA id ry10sm27422663pab.38.2014.07.18.15.32.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jul 2014 15:32:26 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2 8/7] seccomp: Document two-phase seccomp and arch-provided seccomp_data
Date:   Fri, 18 Jul 2014 15:32:00 -0700
Message-Id: <0a79fe55572054ac3b533548481ad1d2b6104eb6.1405722642.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1405717901.git.luto@amacapital.net>
References: <cover.1405717901.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

The description of how arches should implement seccomp filters was
still strictly correct, but it failed to describe the newly
available optimizations.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---

I lost this somehow.  Here it as an an extra patch.  If I end up sending
a v3, I'll fold it in.

 arch/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 0eae9df..05d7a8a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -323,6 +323,17 @@ config HAVE_ARCH_SECCOMP_FILTER
 	    results in the system call being skipped immediately.
 	  - seccomp syscall wired up
 
+	  For best performance, an arch should use seccomp_phase1 and
+	  seccomp_phase2 directly.  It should call seccomp_phase1 for all
+	  syscalls if TIF_SECCOMP is set, but seccomp_phase1 does not
+	  need to be called from a ptrace-safe context.  It must then
+	  call seccomp_phase2 if seccomp_phase1 returns anything other
+	  than SECCOMP_PHASE1_OK or SECCOMP_PHASE1_SKIP.
+
+	  As an additional optimization, an arch may provide seccomp_data
+	  directly to seccomp_phase1; this avoids multiple calls
+	  to the syscall_xyz helpers for every syscall.
+
 config SECCOMP_FILTER
 	def_bool y
 	depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP && NET
-- 
1.9.3
