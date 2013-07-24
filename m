Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jul 2013 19:15:31 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:1521 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835051Ab3GXROknldt0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jul 2013 19:14:40 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 24 Jul 2013 09:02:37 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 24 Jul 2013 09:12:20 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 24 Jul 2013 09:12:19 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsb-10.bri.broadcom.com [10.178.7.10]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id A6590F2D73; Wed, 24
 Jul 2013 09:12:18 -0700 (PDT)
From:   "Florian Fainelli" <f.fainelli@gmail.com>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        blogic@openwrt.org, "Florian Fainelli" <florian@openwrt.org>
Subject: [PATCH 0/2] MIPS: BMIPS: couple of SMP fixes
Date:   Wed, 24 Jul 2013 17:12:09 +0100
Message-ID: <1374682331-14171-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
X-WSS-ID: 7DF125172L851696336-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Florian Fainelli <florian@openwrt.org>

Ralf,

Here are two more BMIPS SMP fixes targetted at 3.11-rcX, thanks!

Florian Fainelli (2):
  MIPS: BMIPS: do not change interrupt routing depending on boot CPU
  MIPS: BMIPS: fix slave CPU booting when physical CPU is not 0

 arch/mips/kernel/bmips_vec.S |  6 +++++-
 arch/mips/kernel/smp-bmips.c | 18 +++++++++---------
 2 files changed, 14 insertions(+), 10 deletions(-)

-- 
1.8.1.2
