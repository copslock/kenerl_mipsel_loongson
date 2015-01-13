Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2015 16:05:16 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:62762 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014445AbbAMPFOUtj4L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jan 2015 16:05:14 +0100
Received: by mail-pa0-f52.google.com with SMTP id eu11so4115661pac.11;
        Tue, 13 Jan 2015 07:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=q6YTE7MxUn/jAQj65VXttxPYaPA+cI4ieCK0LzDnaFE=;
        b=d7iDxh4k8S5UCxoSYdJ8kQozAlx/GfRtqGRzDToxpO3QhusxcVtRgoy9beEjrAPlEz
         /rB7hKFxjIdgjeQC5iBEXyK1N+wY3rY7HjDc8I6rzUTjT3WwOyk63WcYP+HFCJb5WL8W
         ljqH7+E3dERR3YM42y9pi8nTW7NahnCNtw/JXa8gYqsHsvastYuefgaUUBNW2YnsYpq3
         IBOkEZafhUATr8FY6WIaV+/PribixyB+hQuqd0li1mWramnTG8gqw46UbhsBhK7VXlpS
         t7x4ELJWXOVQLDNyGX4yzpZch2buVZYAULP0KI8pXKfJZ3i3pRfsMHX3ga8iV4t4x6yE
         KO+A==
X-Received: by 10.68.224.6 with SMTP id qy6mr51172458pbc.155.1421161508321;
        Tue, 13 Jan 2015 07:05:08 -0800 (PST)
Received: from yggdrasil (114-25-181-102.dynamic.hinet.net. [114.25.181.102])
        by mx.google.com with ESMTPSA id sl5sm17264617pbc.45.2015.01.13.07.05.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jan 2015 07:05:07 -0800 (PST)
Date:   Tue, 13 Jan 2015 23:05:02 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Fix MIPS32_COMPAT recursive dependency
Message-ID: <20150113230344-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

Commit f92b81f16 (MIPS: Compat: Fix build error if CONFIG_MIPS32_COMPAT
but no compat ABI.) introduced a recursive dependency on MIPS32_COMPAT,
shown as follows:

arch/mips/Kconfig:2681:error: recursive dependency detected!
arch/mips/Kconfig:2681:	symbol MIPS32_N32 depends on MIPS32_COMPAT
arch/mips/Kconfig:2658:	symbol MIPS32_COMPAT is selected by MIPS32_N32

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 73983e1..33c0b88 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2680,7 +2680,6 @@ config MIPS32_O32
 
 config MIPS32_N32
 	bool "Kernel support for n32 binaries"
-	depends on MIPS32_COMPAT
 	select COMPAT
 	select MIPS32_COMPAT
 	select SYSVIPC_COMPAT if SYSVIPC
