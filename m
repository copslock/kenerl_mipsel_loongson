Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2018 16:28:50 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:50100 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994641AbeCPP230koap (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Mar 2018 16:28:29 +0100
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0424DD23;
        Fri, 16 Mar 2018 15:28:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.4 14/63] MIPS: ath25: Check for kzalloc allocation failure
Date:   Fri, 16 Mar 2018 16:22:46 +0100
Message-Id: <20180316152301.624796460@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63000
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 1b22b4b28fd5fbc51855219e3238b3ab81da8466 upstream.

Currently there is no null check on a failed allocation of board_data,
and hence a null pointer dereference will occurr. Fix this by checking
for the out of memory null pointer.

Fixes: a7473717483e ("MIPS: ath25: add board configuration detection")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.19+
Patchwork: https://patchwork.linux-mips.org/patch/18657/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ath25/board.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/ath25/board.c
+++ b/arch/mips/ath25/board.c
@@ -135,6 +135,8 @@ int __init ath25_find_config(phys_addr_t
 	}
 
 	board_data = kzalloc(BOARD_CONFIG_BUFSZ, GFP_KERNEL);
+	if (!board_data)
+		goto error;
 	ath25_board.config = (struct ath25_boarddata *)board_data;
 	memcpy_fromio(board_data, bcfg, 0x100);
 	if (broken_boarddata) {
