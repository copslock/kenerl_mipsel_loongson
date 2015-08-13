Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 15:26:47 +0200 (CEST)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:53704 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012340AbbHMNZBAmoph (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 15:25:01 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.15.1/8.15.1) with ESMTPS id t7DDOe6J009743
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Aug 2015 13:24:41 GMT
Received: from localhost.localdomain ([10.144.34.184])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t7DDObQL030804;
        Thu, 13 Aug 2015 15:24:39 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Janne Huttunen <janne.huttunen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 02/14] MIPS: OCTEON: support additional interfaces on CN68XX
Date:   Thu, 13 Aug 2015 16:21:34 +0300
Message-Id: <1439472106-7750-3-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
References: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 816
X-purgate-ID: 151667::1439472281-0000676C-92FB34C2/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

From: Janne Huttunen <janne.huttunen@nokia.com>

CN68XX has 9 interfaces.

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/mips/cavium-octeon/executive/cvmx-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 7e5cf7a..ed4816c2 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -83,6 +83,8 @@ static cvmx_helper_link_info_t
  */
 int cvmx_helper_get_number_of_interfaces(void)
 {
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
+		return 9;
 	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN52XX))
 		return 4;
 	else
-- 
2.4.3
