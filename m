Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2018 11:50:23 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:36430
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992494AbeFLJuPhvJOf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2018 11:50:15 +0200
Received: by mail-pf0-x243.google.com with SMTP id a12-v6so11823201pfi.3;
        Tue, 12 Jun 2018 02:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=lu4OhWwCKU9BxaQ2oT4wJGfxQCLGkMzek7tNIjqHvOY=;
        b=XgaF1PW3PdEQMbnZLiUOFTMOTJhoIroUx8nPKOGOzV5XQsjJOuG5vuR8wlhsfvxC4b
         12vYiHO1yvmDlA0OyV1t78w300zYxvPamayaDQWMmfatiYPN9HLpVgAc9gKH9tHYZ3+o
         XNSwZ+E5VgMx1cQHoG+GAqfHVTi4Vn/HMLkTNu0ZUkkyTRU9SfqKvJGVPtUH1B3iSLwC
         xqanWsreWzHDALq2bwtnXQNjXEQ0vCKRmgiqjrFle+HJiXCJq4hKLutClQqPyGBh6W8V
         MH7g9YPloNcBQde8sH3qSk99bzS8zmflNpZqdNz1feOWArT1nflynpYjPO2PWVXewiaA
         9JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=lu4OhWwCKU9BxaQ2oT4wJGfxQCLGkMzek7tNIjqHvOY=;
        b=OvDWsbxNGq0FJXrUAG4HaqXM8CFOutzP7BcNupa7adYEf3stFdXqnxeZ5Gc7mdGv2a
         2jb13HIoya1gia9dr0SW5yQ0VLmd/PBSuFhXloOuwJRdWgVud+NmICQySzYdYlfYyTBM
         RCdWrbYt0vNBa/fbXHYsQP6Q7FXD9dkNY4qedmVoTj6J12eN96NL2yzvJ6OMTUJV9OC1
         viFnSGguvFcXGKgPWDRr1y79iSTlefg78HiDB5h5nuE36MmE+BKAEKBqbvMHrQe8dJ/t
         gDT/B6hrNWqkCJsTxkHPQ5CcW9z9GMWzWB98mys7EbQqWiL72aaCseslFY7qPKclkqwp
         fHyQ==
X-Gm-Message-State: APt69E3I9VAIjwgBkbVeRrRfV+NRP+YMR7gvD4Tpx2Cq+t9RP7+Cb0fZ
        0F5uGkwNzye3GNyPg3a09Q8fQw==
X-Google-Smtp-Source: ADUXVKJCrl7kayfkc6jRDU7NzhsNHsVx+TSRqaR4B7vWCnn1TA6tx8OvXmbC7fXWWHoHlSAPwJDLVw==
X-Received: by 2002:a62:d712:: with SMTP id b18-v6mr3125600pfh.70.1528797008783;
        Tue, 12 Jun 2018 02:50:08 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id o66-v6sm1881485pfi.157.2018.06.12.02.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 02:50:07 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH Resend 1/2] MIPS: io: Add barrier after register read in inX()
Date:   Tue, 12 Jun 2018 17:54:42 +0800
Message-Id: <1528797283-16577-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64239
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

While a barrier is present in the outX() functions before the register
write, a similar barrier is missing in the inX() functions after the
register read. This could allow memory accesses following inX() to
observe stale data.

This patch is very similar to commit a1cc7034e33d12dc1 ("MIPS: io: Add
barrier after register read in readX()"). Because war_io_reorder_wmb()
is both used by writeX() and outX(), if readX() need a barrier then so
does inX().

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index a7d0b83..cea8ad8 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -414,6 +414,8 @@ static inline type pfx##in##bwlq##p(unsigned long port)			\
 	__val = *__addr;						\
 	slow;								\
 									\
+	/* prevent prefetching of coherent DMA data prematurely */	\
+	rmb();								\
 	return pfx##ioswab##bwlq(__addr, __val);			\
 }
 
-- 
2.7.0
