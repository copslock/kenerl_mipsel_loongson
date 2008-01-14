Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 21:28:00 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.157]:35735 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20035259AbYANV1u (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 21:27:50 +0000
Received: by fg-out-1718.google.com with SMTP id d23so2266620fga.32
        for <linux-mips@linux-mips.org>; Mon, 14 Jan 2008 13:27:50 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=9gHP/UwVKtlJ1tt5ddt7JSH5pnwBCu06IviSuMwFA1o=;
        b=QXR+yS08R/WcggWqmbqc05SPfULcP7tgbkW4D7doV9+Hj0Y2bCKtWXTmuBQIgzVrgEQ1afQkJs9Vkz59Iog/Dh8o5u1Hj0W9UVF8vKTpXSkcsR5T6cYIbmOtU/uv67vI35tAKbRIthgiuCPDdh2/GnC9QySmV4n48CbpXS1vvqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=LuyAKMIMMQpWjx2ZOwB/DrBNqxf0b9Ea0Z2vD7U9mLxkhMaIb6mNpDi84fojbyHdBKZpd+vTwJOQHBqeSJnSJ/G1W/KnDxAqGvoMBgYe1E4qGEbic9BJNqY/I5TIlOtDXCxNKL2jU/FFiPIn83swLT371ya+xU7aCC9T+Id4w5w=
Received: by 10.86.25.17 with SMTP id 17mr4797889fgy.15.1200346069896;
        Mon, 14 Jan 2008 13:27:49 -0800 (PST)
Received: from ?192.168.1.3? ( [91.76.31.85])
        by mx.google.com with ESMTPS id l12sm5568077fgb.9.2008.01.14.13.27.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jan 2008 13:27:49 -0800 (PST)
Message-ID: <478BD3D2.3060807@gmail.com>
Date:	Tue, 15 Jan 2008 00:27:46 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
CC:	Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][MIPS] Malta: Fix reading the PCI clock frequency on big-endian
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

The JMPRS register on Malta boards keeps a 32-bit CPU-endian
value. The readw() function assumes that the value it reads is a
little-endian 16-bit number. Therefore, using readw() to obtain
the value of the JMPRS register is a mistake. This error leads
to incorrect reading of the PCI clock frequency on big-endian
during board start-up.

Change readw() to __raw_readl().

This was tested by injecting a call to printk() and verifying
that the value of the jmpr variable was consistent with current
setting of the JP4 "PCI CLK" jumper.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/malta/malta_setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_setup.c b/arch/mips/mips-boards/malta/malta_setup.c
index 9a2636e..bc43a5c 100644
--- a/arch/mips/mips-boards/malta/malta_setup.c
+++ b/arch/mips/mips-boards/malta/malta_setup.c
@@ -149,7 +149,7 @@ void __init plat_mem_setup(void)
 	/* Check PCI clock */
 	{
 		unsigned int __iomem *jmpr_p = (unsigned int *) ioremap(MALTA_JMPRS_REG, sizeof(unsigned int));
-		int jmpr = (readw(jmpr_p) >> 2) & 0x07;
+		int jmpr = (__raw_readl(jmpr_p) >> 2) & 0x07;
 		static const int pciclocks[] __initdata = {
 			33, 20, 25, 30, 12, 16, 37, 10
 		};
-- 
1.5.3
