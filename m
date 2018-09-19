Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2018 16:33:39 +0200 (CEST)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:46366
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994648AbeISOdSk4lS9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Sep 2018 16:33:18 +0200
Received: by mail-qt0-x242.google.com with SMTP id l42-v6so5238270qtf.13;
        Wed, 19 Sep 2018 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5CAdxzfQRZkTFemiYjkqqIoF4GDpAHDHcjK2CfrXn5w=;
        b=Nm4g6iVu/HPpeihXVQQUggUndDSvf1d8DqMliRztGdJxzt3BqX5MFZACkRsb7vBnG+
         CnwzVF+IrIoBfgo8czUC4zOvxopSZgaTOG6w+rwoXhTwqOKOZgv+fO8yFaGRYK4wBVxl
         28RiaIAwWaJKisoqPOs0me+DA0SOQmc+7G9FtN+vkk9SZaarw47HKzhb6QWg+chaow2F
         mLj1/x/6XA9HppzhU+cI1tX3EeYxesow+/Zmi9rHp2kAoF9hrs/nnfuD3G+gRz648Uho
         zJnGAWweXEwtpstiCNHhvKdovFwM9cBRiXHXIKYjSVVmdInYYDi2Vlar70GXVl4VThYw
         M1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5CAdxzfQRZkTFemiYjkqqIoF4GDpAHDHcjK2CfrXn5w=;
        b=VHxEdR6NUB6oGDUj8ManJBt9DlyaiRR1S9IFvoMyDR91L43UjdDE0lZWaKHNCQCmfv
         KqHEOVRbdS7GIgH/PKOXamkMb+UCL0xb4QMefhVyjoQmOA7jgECdsSJywT8SF1Qq+5Qx
         Sccjrj/iPyQfVzIk7wIyZS8daW45ld4T+4UpjPECk8zm2Ij30h2+VTCHAjF8zP9cg5mL
         JoGRlUB18KUCl3/J987nprG6WXRhPVrx2zWt2hdE7SHgoy/UECGDflWvuioBksQbG9Jo
         qJfRo0o5UZj+fBgL6pm3sTd78G+jccFcA1FyYSmAWzkkzLMUUFiN2AJs5ONjxg1Wm4h7
         4KTw==
X-Gm-Message-State: APzg51BGx9mCl/aroj15/UvL+0xeZeheC/FwQtm8lHF2jYNy849gH6z0
        PY99t6LTikkpP5kj43SOyTM=
X-Google-Smtp-Source: ANB0VdbPw9AEiedEG+dEAsF8Nr3fkirVuMrQ4adwENEbxm4DnwQACoDGpvrEDMoZlSmbPNqvQX/R8Q==
X-Received: by 2002:ac8:198c:: with SMTP id u12-v6mr25220283qtj.86.1537367592915;
        Wed, 19 Sep 2018 07:33:12 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 17-v6sm2104051qkf.74.2018.09.19.07.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:33:12 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 09/12] MIPS: BMIPS: enable PCI
Date:   Wed, 19 Sep 2018 10:32:04 -0400
Message-Id: <1537367527-20773-10-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

Adds the Kconfig hooks to enable the Broadcom STB PCIe root complex
driver for Broadcom MIPS systems.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3551199..a15c0da 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -220,6 +220,9 @@ config BMIPS_GENERIC
 	select BOOT_RAW
 	select NO_EXCEPT_FILL
 	select USE_OF
+	select HW_HAS_PCI
+	select PCI_DRIVERS_GENERIC
+	select PCI
 	select CEVT_R4K
 	select CSRC_R4K
 	select SYNC_R4K
-- 
1.9.0.138.g2de3478
