Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 03:51:00 +0200 (CEST)
Received: from mail-pd0-f179.google.com ([209.85.192.179]:60163 "EHLO
        mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821198AbaGVBtyU3q1r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 03:49:54 +0200
Received: by mail-pd0-f179.google.com with SMTP id ft15so10125157pdb.24
        for <linux-mips@linux-mips.org>; Mon, 21 Jul 2014 18:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sqawMfiK1To/ZSD72ook3pV9OW9w8NdRhlta7YjsL1I=;
        b=GDiCNrSOldoky3IkSRg9USRzSRkaYtU6CEm2bTO4aUbMd2he/6REmj+7Axl/FcGm+X
         KbEzehcVNTEVC3mT+fGZbQXSN/EP4nJUH9Mv8cEncIS8A7YAbOTCaM1yrx9JFTknMr1G
         +Kxc2NYqN4Ni78fn6DzjKuAVhD10MP/PQC2i2Z7AzBE835T+aQqvm62l5093i/Q/ETXK
         2iN2DbH0oO/E59Mjg3ivdv35cQzUbCOoBOBBoMUG/ROlOtAyPIiPosW7MQmznC/DgqzJ
         TFpjr4n/pzaXlMvwdNlw6lv/gdqXCxbSxStTugRAhRLOzdOXpuMwjvck/QhszUIAKWiQ
         qAYg==
X-Gm-Message-State: ALoCoQlJ3xPXrCQoGIyGtihmSsS9ZUmGUR6M01ITaMVahyVfg2p/yg1KaupLu9AWuj1B6oo5r9PH
X-Received: by 10.68.114.65 with SMTP id je1mr12554620pbb.124.1405993788116;
        Mon, 21 Jul 2014 18:49:48 -0700 (PDT)
Received: from localhost ([2600:1010:b01b:59a8:9138:8dc8:286b:79c0])
        by mx.google.com with ESMTPSA id p5sm2853612pdg.35.2014.07.21.18.49.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jul 2014 18:49:47 -0700 (PDT)
From:   Andy Lutomirski <luto@amacapital.net>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v3 4/8] seccomp: Document two-phase seccomp and arch-provided seccomp_data
Date:   Mon, 21 Jul 2014 18:49:17 -0700
Message-Id: <7dc27063cc38b4b5a0d800ee16c1aa2a89953533.1405992946.git.luto@amacapital.net>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1405992946.git.luto@amacapital.net>
References: <cover.1405992946.git.luto@amacapital.net>
In-Reply-To: <cover.1405992946.git.luto@amacapital.net>
References: <cover.1405992946.git.luto@amacapital.net>
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41415
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

The description of how archs should implement seccomp filters was
still strictly correct, but it failed to describe the newly
available optimizations.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
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
