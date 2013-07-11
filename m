Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jul 2013 00:08:14 +0200 (CEST)
Received: from scrooge.tty.gr ([62.217.125.135]:43270 "EHLO mail.tty.gr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835038Ab3GKWIMeXiFH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Jul 2013 00:08:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tty.gr; s=x;
        h=Message-Id:Date:Subject:Cc:To:From; bh=nuAbwwn3ILsUvVp3T/u3UQ7ahsbqvjmL0UDqkennPQM=;
        b=NWldSZTu7+g+SmnvxWuQYjqL7yMSeT7i2PWP9TdP+pPEftWCD9LYni3ezovxUxRvJvKt+DoU13ge2/1tLtWk9LaavE1YnWQQqnauRiSqTcoqYkCq/lhtqZH7qCvoFW5/;
Received: from [2001:648:2001:f000:223:aeff:fe91:b5f4] (helo=serenity.void.home)
        by mail.tty.gr (envelope-from <paravoid@tty.gr>)
        with esmtpsa (tls_cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80 (Debian GNU/Linux))
        id 1UxP21-000545-J0; Fri, 12 Jul 2013 01:08:09 +0300
Received: from paravoid by serenity.void.home with local (Exim 4.80)
        (envelope-from <paravoid@tty.gr>)
        id 1UxP21-00061i-3g; Fri, 12 Jul 2013 01:08:09 +0300
From:   Faidon Liambotis <paravoid@debian.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: octeon: fix DT pruning bug with pip ports
Date:   Fri, 12 Jul 2013 01:08:09 +0300
Message-Id: <1373580489-23142-1-git-send-email-paravoid@debian.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <paravoid@tty.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paravoid@debian.org
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

During the pruning of the device tree octeon_fdt_pip_iface() is called
for each PIP interface and every port up to the port count is removed
from the device tree. However, the count was set to the return value of
cvmx_helper_interface_enumerate() which doesn't actually return the
count but just returns zero on success. This effectively removed *all*
ports from the tree.

Use cvmx_helper_ports_on_interface() instead to fix this. This
successfully restores the 3 ports of my ERLite-3 and fixes the "kernel
assigns random MAC addresses" issue.

Signed-off-by: Faidon Liambotis <paravoid@debian.org>
---
 arch/mips/cavium-octeon/octeon-platform.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 389512e..250eb20 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -334,9 +334,10 @@ static void __init octeon_fdt_pip_iface(int pip, int idx, u64 *pmac)
 	char name_buffer[20];
 	int iface;
 	int p;
-	int count;
+	int count = 0;
 
-	count = cvmx_helper_interface_enumerate(idx);
+	if (cvmx_helper_interface_enumerate(idx) == 0)
+		count = cvmx_helper_ports_on_interface(idx);
 
 	snprintf(name_buffer, sizeof(name_buffer), "interface@%d", idx);
 	iface = fdt_subnode_offset(initial_boot_params, pip, name_buffer);
-- 
1.8.3.2
