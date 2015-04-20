Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2015 03:45:37 +0200 (CEST)
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:52664 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010481AbbDTBpeMd-MO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Apr 2015 03:45:34 +0200
Received: from resomta-ch2-06v.sys.comcast.net ([69.252.207.102])
        by resqmta-ch2-02v.sys.comcast.net with comcast
        id J1lG1q0032D5gil011lUtD; Mon, 20 Apr 2015 01:45:28 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-06v.sys.comcast.net with comcast
        id J1lS1q00342s2jH011lSAW; Mon, 20 Apr 2015 01:45:28 +0000
Message-ID: <55345A35.5000003@gentoo.org>
Date:   Sun, 19 Apr 2015 21:45:25 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alessandro Zummo <a.zummo@towertech.it>
CC:     LKML <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH]: MIPS: IP32: Fix two build errors in reset code introduced
 in DS1685 platform hook patch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1429494328;
        bh=d4rhZ2b5eMT6Zg2VVKZpd6syIrcwUPOWUZ6HpGjhtgE=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=IwZLDQgZQbK656HLChvO1dNxh/gr+3jDsBzCC1KsEficl+2AaVbu6syrJ6g/XKEVF
         tRBZM46N0pHLkV4JD4jP2FwL26mwH7SQJ6daDlecsBW3nYHyi7JGAom1bWbBN4yqFI
         6ybgjPdJ3CGrvUSgDU+tpRuCvjaKLWAAqdD+NOhodZoVaynxlC7tefcxzhsuskaUK6
         QB/fFWU/f/kg+X9nUK5kxoz0UPJIXRhCFVpIU7yYAndyyObHQBohwQWkdDTgd1v+OZ
         plmmfHiBc8W6JvYnlah+7c8ql7y/dk8SAAwiKpCXxTPeWpFvSTrDsCkyX6/rs0mnrG
         7xYA6orywruhQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Fix two build errors that somehow got into upstream.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
Fixes: 15beb694c661: "mips: ip32: add platform data hooks to use DS1685
driver"
---
 arch/mips/sgi-ip32/ip32-platform.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
index 0134db2..686a372 100644
--- a/arch/mips/sgi-ip32/ip32-platform.c
+++ b/arch/mips/sgi-ip32/ip32-platform.c
@@ -130,9 +130,9 @@ struct platform_device ip32_rtc_device = {
 	.resource		= ip32_rtc_resources,
 };
 
-+static int __init sgio2_rtc_devinit(void)
+static int __init sgio2_rtc_devinit(void)
 {
 	return platform_device_register(&ip32_rtc_device);
 }
 
-device_initcall(sgio2_cmos_devinit);
+device_initcall(sgio2_rtc_devinit);
