Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 17:10:56 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:4921 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831953Ab3ANQKKs4VYZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Jan 2013 17:10:10 +0100
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Jan 2013 08:07:33 -0800
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 14 Jan 2013 08:09:18 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 858E740FE4; Mon, 14
 Jan 2013 08:09:27 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 01/10] MIPS: Netlogic: add XLS6xx to FMN config
Date:   Mon, 14 Jan 2013 21:41:53 +0530
Message-ID: <1358179922-26663-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
References: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7CEAF2CF1ZS6640503-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add support for XLS6xx CPUs to the Fast Message Network (FMN)
configuration.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/xlr/fmn-config.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/netlogic/xlr/fmn-config.c b/arch/mips/netlogic/xlr/fmn-config.c
index bed2cff..e8071d6 100644
--- a/arch/mips/netlogic/xlr/fmn-config.c
+++ b/arch/mips/netlogic/xlr/fmn-config.c
@@ -216,6 +216,8 @@ void xlr_board_info_setup(void)
 	case PRID_IMP_NETLOGIC_XLS404B:
 	case PRID_IMP_NETLOGIC_XLS408B:
 	case PRID_IMP_NETLOGIC_XLS416B:
+	case PRID_IMP_NETLOGIC_XLS608B:
+	case PRID_IMP_NETLOGIC_XLS616B:
 		setup_fmn_cc(&gmac[0], FMN_STNID_GMAC0,
 					FMN_STNID_GMAC0_TX3, 8, 8, 32);
 		setup_fmn_cc(&gmac[1], FMN_STNID_GMAC1_FR_0,
-- 
1.7.9.5
