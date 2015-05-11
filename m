Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 19:58:59 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35758 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027477AbbEKRzuvAyYl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:50 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9EAEEBBD;
        Mon, 11 May 2015 17:55:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Crispin <blogic@openwrt.org>,
        Paul Bolle <pebolle@tiscali.nl>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 23/72] MIPS: ralink: Fix bad config symbol in PCI makefile.
Date:   Mon, 11 May 2015 10:54:29 -0700
Message-Id: <20150511175437.812038841@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47322
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: John Crispin <blogic@openwrt.org>

Commit 93a7de8819a661d06eb11f4de3d6888b9a842b30 upstream.

A wrong symbol is referenced by commit 187c26ddf0b2 ("MIPS: ralink: add rt2880
pci driver"). Fix this by changing it to the correct symbol.

Signed-off-by: John Crispin <blogic@openwrt.org>
Reported-by: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9298/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/pci/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -43,7 +43,7 @@ obj-$(CONFIG_SIBYTE_BCM1x80)	+= pci-bcm1
 obj-$(CONFIG_SNI_RM)		+= fixup-sni.o ops-sni.o
 obj-$(CONFIG_LANTIQ)		+= fixup-lantiq.o
 obj-$(CONFIG_PCI_LANTIQ)	+= pci-lantiq.o ops-lantiq.o
-obj-$(CONFIG_SOC_RT2880)	+= pci-rt2880.o
+obj-$(CONFIG_SOC_RT288X)	+= pci-rt2880.o
 obj-$(CONFIG_SOC_RT3883)	+= pci-rt3883.o
 obj-$(CONFIG_TANBAC_TB0219)	+= fixup-tb0219.o
 obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
