Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 13:04:43 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:44582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994841AbeE1LEYt-jQ0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 May 2018 13:04:24 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB662087E;
        Mon, 28 May 2018 11:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527505458;
        bh=Ck+NfNQvJ9XsSXu5bSBhatSFr4c+P1DjKJBf5zXw87M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HEz80Xc6kHQGF80TBwf9vU+s5ERlVqlsUufzlMasI55p67COZLIycy9/NNHFGGfeu
         JwbzTiNqyOAtHeiAdMcoL6sVNbRwu0O+zh550ZNjF55UmOPzv6B6RzFKMW2VpP32Kj
         qgQpqWmpQRFHYDyfZqdzRrnYsxn0mVQDVj22cGIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.16 002/272] MIPS: xilfpga: Actually include FDT in fitImage
Date:   Mon, 28 May 2018 12:00:35 +0200
Message-Id: <20180528100240.411696974@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <SRS0=WbIs=IP=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64110
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

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit 947bc875116042d5375446aa29bc1073c2d38977 upstream.

Commit b35565bb16a5 ("MIPS: generic: Add support for MIPSfpga") added
and its.S file for xilfpga but forgot to add it to
arch/mips/generic/Platform so it is never used.

Fixes: b35565bb16a5 ("MIPS: generic: Add support for MIPSfpga")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.15+
Patchwork: https://patchwork.linux-mips.org/patch/19245/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/generic/Platform |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/generic/Platform
+++ b/arch/mips/generic/Platform
@@ -16,3 +16,4 @@ all-$(CONFIG_MIPS_GENERIC)	:= vmlinux.gz
 its-y					:= vmlinux.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+= board-boston.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= board-ni169445.its.S
+its-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= board-xilfpga.its.S
