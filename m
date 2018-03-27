Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 18:35:09 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59206 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994687AbeC0Qedu-wBe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2018 18:34:33 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 80C101225;
        Tue, 27 Mar 2018 16:34:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Kresin <dev@kresin.me>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 005/101] MIPS: lantiq: ase: Enable MFD_SYSCON
Date:   Tue, 27 Mar 2018 18:26:37 +0200
Message-Id: <20180327162750.330367967@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63257
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Kresin <dev@kresin.me>

commit a821328c2f3003b908880792d71b2781b44fa53c upstream.

Enable syscon to use it for the RCU MFD on Amazon SE as well.

The Amazon SE also has similar reset controller system as Danube and
XWAY and use their drivers mostly. As these drivers now need syscon also
activate the syscon subsystem for for Amazon SE.

Fixes: 2b6639d4c794 ("MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD")
Signed-off-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.14+
Patchwork: https://patchwork.linux-mips.org/patch/18817/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lantiq/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -13,6 +13,8 @@ choice
 config SOC_AMAZON_SE
 	bool "Amazon SE"
 	select SOC_TYPE_XWAY
+	select MFD_SYSCON
+	select MFD_CORE
 
 config SOC_XWAY
 	bool "XWAY"
