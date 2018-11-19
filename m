Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 17:59:07 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:51644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994766AbeKSQ7BS0VoK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Nov 2018 17:59:01 +0100
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC6F12148E;
        Mon, 19 Nov 2018 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646740;
        bh=r9IRLAFyyCcHpPyDbmwiwitQIjS8GU+v6RSyayBtP5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+Ay+WXtqq58fbtpEKd/6K6Y2AGdlyJcfawudp7aQkbB9zsya/6KVHXEGbc8FYrh2
         pOc0KAEletB6wSTbRpozxwca/23/UtcHFbTD+q5Pmjzd2BnrP4uNtyyGU9vac3b/IE
         FjK4hGdH/H+BlE+B4UewjdLhQCXxY94j/6WrQmGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.4 073/160] MIPS: OCTEON: fix out of bounds array access on CN68XX
Date:   Mon, 19 Nov 2018 17:28:32 +0100
Message-Id: <20181119162638.335410305@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <SRS0=OXTl=N6=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67373
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

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit c0fae7e2452b90c31edd2d25eb3baf0c76b400ca upstream.

The maximum number of interfaces is returned by
cvmx_helper_get_number_of_interfaces(), and the value is used to access
interface_port_count[]. When CN68XX support was added, we forgot
to increase the array size. Fix that.

Fixes: 2c8c3f0201333 ("MIPS: Octeon: Support additional interfaces on CN68XX")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20949/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # v4.3+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/cavium-octeon/executive/cvmx-helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -67,7 +67,7 @@ void (*cvmx_override_pko_queue_priority)
 void (*cvmx_override_ipd_port_setup) (int ipd_port);
 
 /* Port count per interface */
-static int interface_port_count[5];
+static int interface_port_count[9];
 
 /* Port last configured link info index by IPD/PKO port */
 static cvmx_helper_link_info_t
