Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Sep 2014 17:28:03 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:58260 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008469AbaIHP1Zb4euG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Sep 2014 17:27:25 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.14.3/8.14.3) with ESMTP id s88FRIPR002154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 8 Sep 2014 15:27:18 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.35.206])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id s88FRGFX002806;
        Mon, 8 Sep 2014 17:27:17 +0200
From:   Aaro Koskinen <aaro.koskinen@nsn.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@nsn.com>
Subject: [PATCH 0/4] MIPS: OCTEON: cvmx_fuse_read_byte cleanup
Date:   Mon,  8 Sep 2014 18:25:39 +0300
Message-Id: <1410189943-4573-1-git-send-email-aaro.koskinen@nsn.com>
X-Mailer: git-send-email 2.1.0
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 781
X-purgate-ID: 151667::1410190038-00002A30-85162651/0/0
Return-Path: <aaro.koskinen@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nsn.com
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

Hi,

Here's a small cleanup to follow up the /proc/cpuinfo fix, and eliminates
the possibility of cvmx_fuse_read_byte completely after the kernel has
completed the init.

Aaro Koskinen (4):
  MIPS: OCTEON: move cvmx_fuse_read_byte()
  MIPS: OCTEON: delete potentially dangerous feature checks
  MIPS: OCTEON: move code to avoid forward declaration
  MIPS: OCTEON: mark octeon_model_get_string() with __init

 arch/mips/cavium-octeon/executive/octeon-model.c | 49 ++++++++++++------
 arch/mips/include/asm/octeon/cvmx.h              | 63 ------------------------
 arch/mips/include/asm/octeon/octeon-feature.h    | 52 -------------------
 arch/mips/include/asm/octeon/octeon-model.h      |  3 +-
 4 files changed, 36 insertions(+), 131 deletions(-)

-- 
2.1.0
