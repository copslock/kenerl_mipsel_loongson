Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 02:48:56 +0100 (CET)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:34842
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992916AbeAXBrpLI9oZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 02:47:45 +0100
Received: by mail-qt0-x241.google.com with SMTP id g14so6617247qti.2;
        Tue, 23 Jan 2018 17:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BnDTluNVEiTRNtn6MkoodG0OyYj08+RmuECmthT6LgM=;
        b=TaK0b1hf0Iy05zglWazPjMS7sq/O/hPDPVf3I8h0VHrFTw6WNX0RDheLELFBSk2r2k
         WL2haHC+izdm/RxeHSPO4ZL3Tj9Z1++4YBBzU9+4B/YWvu/hLmpN31IfbYx1+ZJyP7QC
         QADlI/xcJMVlLSLJYp9Y7wV63z58KE7XbPpHsc05H+V0UiqmAb9ed2LqqB2Gk9sF0v1H
         w2zWOYDcwu8vcImU1bFrpC6A43AdpfrCp/cwd2lOQpqy8ENXDxd9IsUiZqVAXpIlxFq5
         XfA/aSWJipUzUQWaC96qhCddacsALRYxXjsuxJuGA7shwYpkNbQlMISR0S0NGixRxv9+
         E+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BnDTluNVEiTRNtn6MkoodG0OyYj08+RmuECmthT6LgM=;
        b=Dl7qGnwtLVY2QMhmzElBoP6v7LOwNs0t5lJxk/NGs+ZUJialiNxTdHYchIZzePlIvn
         brb/1zeLzrXrG1xjdNcwTWiv34GjtOIcG1T6OWjx8LGB+AxIqhE1peqFRNXu4KJl8TCM
         MthpeTbKYZ6p32mAJjky5xY3KicAnDqGjptGdBruNVQUoaseE5IrLIvyrrKdYa0DtjZ9
         iKLdvWb23Q2TrCC8r929BFSoaJSm+n4twWDg5HRruTKk5t+bJUk8Jp/8lW9jJNfdGfG0
         vQqseUxS20IWW7QkQ3hBs1CgoSPHd7g5Wcyb3ZE+iypaAIUXJvxxUZmpxbYto4Mg4n44
         I/Dw==
X-Gm-Message-State: AKwxytfb2NPvddeTt3s+2NFsczLQ69tYvu9aDPkSGspjIcH5dvQqhvfp
        DPR4WDlEEeq1bmPQ6krrrnFyNI+A
X-Google-Smtp-Source: AH8x224Ebz8BMUOhGh4Q4m5SU9BYT8Wic9u6AXCYLOW4VdMltlKiVwjUjL7gl5LEarD3+LR6usOIog==
X-Received: by 10.55.16.160 with SMTP id 32mr6735469qkq.151.1516758459058;
        Tue, 23 Jan 2018 17:47:39 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x7sm1465605qtx.51.2018.01.23.17.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jan 2018 17:47:38 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Meyer <thomas@m3y3r.de>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 3/6] MIPS: BMIPS: Avoid referencing CKSEG1
Date:   Tue, 23 Jan 2018 17:47:03 -0800
Message-Id: <1516758426-8127-4-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1516758426-8127-1-git-send-email-f.fainelli@gmail.com>
References: <1516758426-8127-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Florian Fainelli <florian.fainelli@broadcom.com>

bmips_smp_movevec() references the CKSEG1 constant, which is about to be
updated in order to support processors that might enable eXtended
KSEG0/1. In doing so, we will generate a reference to a function, which
is obviously not permissible within assembly. Fortunately,
bmips_smp_movevec() is only used on BMIPS4350 which does not support
eXtended KSEG0/1.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/kernel/bmips_vec.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
index 921a5fa55da6..10ea69f3859f 100644
--- a/arch/mips/kernel/bmips_vec.S
+++ b/arch/mips/kernel/bmips_vec.S
@@ -39,7 +39,7 @@
 
 LEAF(bmips_smp_movevec)
 	la	k0, 1f
-	li	k1, CKSEG1
+	li	k1, 0xa0000000
 	or	k0, k1
 	jr	k0
 
@@ -58,7 +58,7 @@ LEAF(bmips_smp_movevec)
 	mfc0	k1, $22, 3
 	srl	k1, 16
 	andi	k1, 0x8000
-	or	k1, CKSEG1 | BMIPS_RELO_VECTOR_CONTROL_0
+	or	k1, 0xa0000000 | BMIPS_RELO_VECTOR_CONTROL_0
 	or	k0, k1
 	li	k1, 0xa0080000
 	sw	k1, 0(k0)
@@ -67,7 +67,7 @@ LEAF(bmips_smp_movevec)
 	wait
 
 	la	k0, bmips_reset_nmi_vec
-	li	k1, CKSEG1
+	li	k1, 0xa0000000
 	or	k0, k1
 	jr	k0
 END(bmips_smp_movevec)
-- 
2.7.4
