Return-Path: <SRS0=TQVq=ON=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD15C04EBF
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725362082B
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 20:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725362082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbeLDUUZ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:20:25 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:41658 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeLDUUY (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 4 Dec 2018 15:20:24 -0500
Received: from localhost.localdomain (85-76-96-200-nat.elisa-mobile.fi [85.76.96.200])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 13ABDB004E;
        Tue,  4 Dec 2018 22:12:50 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 5/6] MIPS: OCTEON: cvmx_gmxx_inf_mode: use oldest forward compatible definition
Date:   Tue,  4 Dec 2018 22:12:19 +0200
Message-Id: <20181204201220.12667-6-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181204201220.12667-1-aaro.koskinen@iki.fi>
References: <20181204201220.12667-1-aaro.koskinen@iki.fi>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Use oldest forward compatible definition.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-helper.c        | 4 ++--
 arch/mips/cavium-octeon/executive/cvmx-interrupt-rsl.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index c635a5ace83b..d2251bb1f369 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -218,7 +218,7 @@ static cvmx_helper_interface_mode_t __cvmx_get_mode_octeon2(int interface)
 	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
 
 	if (OCTEON_IS_MODEL(OCTEON_CN63XX)) {
-		switch (mode.cn63xx.mode) {
+		switch (mode.cn61xx.mode) {
 		case 0:
 			return CVMX_HELPER_INTERFACE_MODE_SGMII;
 		case 1:
@@ -342,7 +342,7 @@ cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int interface)
 	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
 
 	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN52XX)) {
-		switch (mode.cn56xx.mode) {
+		switch (mode.cn52xx.mode) {
 		case 0:
 			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
 		case 1:
diff --git a/arch/mips/cavium-octeon/executive/cvmx-interrupt-rsl.c b/arch/mips/cavium-octeon/executive/cvmx-interrupt-rsl.c
index fa327ec891cd..d23f46736dd6 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-interrupt-rsl.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-interrupt-rsl.c
@@ -84,7 +84,7 @@ void __cvmx_interrupt_gmxx_enable(int interface)
 
 	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN52XX)) {
 		if (mode.s.en) {
-			switch (mode.cn56xx.mode) {
+			switch (mode.cn52xx.mode) {
 			case 1: /* XAUI */
 				num_ports = 1;
 				break;
-- 
2.17.0

