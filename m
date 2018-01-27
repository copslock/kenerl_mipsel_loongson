Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2018 04:22:33 +0100 (CET)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:44983
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993497AbeA0DWBBAWSB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2018 04:22:01 +0100
Received: by mail-pg0-x243.google.com with SMTP id m20so1363796pgc.11;
        Fri, 26 Jan 2018 19:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YQrGN0WcQfOOHvEfNM2oHE+9pJNa3UNDd9JwT8Eg2T8=;
        b=pB1EbiDaDDFd0XGgF/DC5kfmDuvULy865UBGd4blEx4/JIqPyA3rgJ/SrpJaLT/qa8
         3eKkXrVmAYbBCHbndKSmFbTHYcp7ijJHHmsDJAXFPdPL3cW+h6swf5Wk9RLtNgnMmIEX
         9wy1+90vNG+Arkta2qQLcpEYFFE6u/BY9ywR8UAUorVYa6X4iCt37TqT5eJxk0kSVGPf
         xL97daDx8K2SuFVnSUAFMCBAGiTuzaZcZRZhsnutB95usRE03FUo3YLkPBTFtmRAXctm
         nB/N1MTF6qEWNEej4pHvH0NqoiZaPPAjNpw2vmWfNe0anCoAOrNJ8a6bVECSklCBc+dc
         Xwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=YQrGN0WcQfOOHvEfNM2oHE+9pJNa3UNDd9JwT8Eg2T8=;
        b=smHF0Em0dsdaIiXHBGvpu0RYjJMlcQnaFi0+9f0SzSW6ddAY2sgaOlnK2gbLtm/xnB
         svjAHul8IBULA6FhtwhPkvx3S/JiNNWN009hpOzQgHhPrsa+Mr+FPQKUJxbLqVTrWdu0
         UCjlPFByg3Ht4O3lxkzmnUJqL3WMUAFgUBfHtf9emEnYXFet1DW8jLpZ59zXNbfmez9+
         Xiv2WlcZowLLnHPPCMta61CaXBEanNgdAGAe6iaKLS5t0ry84kSmlt4P/Vr+316C2VuE
         Bj5CTc3Cizm7JBB04Z2r1RlxLGnuwlXzAnIkqUWpuqUMiAK2g9cbvuHGYhuylOaVEq26
         kdbg==
X-Gm-Message-State: AKwxytdoBIJ+Xu5VnURWrhlyBFeV9hKmYs2YtOCpnSiw2v4hDdC+m/bR
        xc5eJsxXt3kZFOA9jAU69hQATw==
X-Google-Smtp-Source: AH8x224UFp+CVS18wKvyFtXCAHHZKPmzecjxGGtFWMomBcfCdK2PrD/2ASTr9KsauINRIovwISrsvw==
X-Received: by 10.98.234.19 with SMTP id t19mr6261356pfh.74.1517023314737;
        Fri, 26 Jan 2018 19:21:54 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id 8sm26843303pfh.170.2018.01.26.19.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 19:21:54 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 08/12] MIPS: Align kernel load address to 64KB
Date:   Sat, 27 Jan 2018 11:22:15 +0800
Message-Id: <1517023336-17575-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1517023336-17575-1-git-send-email-chenhc@lemote.com>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517023336-17575-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

KEXEC assume kernel align to PAGE_SIZE, and 64KB is the largest
PAGE_SIZE.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
index 37fe58c..1dcaef4 100644
--- a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
+++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
@@ -45,11 +45,10 @@ int main(int argc, char *argv[])
 	vmlinuz_load_addr = vmlinux_load_addr + vmlinux_size;
 
 	/*
-	 * Align with 16 bytes: "greater than that used for any standard data
-	 * types by a MIPS compiler." -- See MIPS Run Linux (Second Edition).
+	 * Align with 64KB: KEXEC assume kernel align to PAGE_SIZE
 	 */
 
-	vmlinuz_load_addr += (16 - vmlinux_size % 16);
+	vmlinuz_load_addr += (65536 - vmlinux_size % 65536);
 
 	printf("0x%llx\n", vmlinuz_load_addr);
 
-- 
2.7.0
