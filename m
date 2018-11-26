Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 12:05:44 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:33530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994800AbeKZLFfFTSfO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Nov 2018 12:05:35 +0100
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D7F2146F;
        Mon, 26 Nov 2018 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230334;
        bh=N3bGNCITPaJfJRcAr88hMCQMVdHi/SVfbGHQn3UHgmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FBO6Y4InrkKvViyjXzvXNBymhLrf72b1ViTDKKfL+aqXuM8CIZ+TW4XezYgmPvA+3
         aPwYg9jTNGM3RaFj49Mvp6QG7hAZRhY5r5CvD/ryPQTcoleqtt5kcmmOc12jwZ4/Tt
         w9Ka9MDpUMhoi8cB8kSXgVaZCcTFpFo9WxCaryAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.19 096/118] MIPS: OCTEON: cavium_octeon_defconfig: re-enable OCTEON USB driver
Date:   Mon, 26 Nov 2018 11:51:30 +0100
Message-Id: <20181126105105.550994668@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <SRS0=UhMK=OF=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67487
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit 82fba2df7f7c019627f24c5036dc99f41731d770 upstream.

Re-enable OCTEON USB driver which is needed on older hardware
(e.g. EdgeRouter Lite) for mass storage etc. This got accidentally
deleted when config options were changed for OCTEON2/3 USB.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: f922bc0ad08b ("MIPS: Octeon: cavium_octeon_defconfig: Enable more drivers")
Patchwork: https://patchwork.linux-mips.org/patch/21077/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # 4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/configs/cavium_octeon_defconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -140,6 +140,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_STAGING=y
 CONFIG_OCTEON_ETHERNET=y
+CONFIG_OCTEON_USB=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_RAS=y
 CONFIG_EXT4_FS=y
