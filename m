Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Nov 2015 17:37:38 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:48615 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012274AbbKOQheQDX4S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 15 Nov 2015 17:37:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To; bh=B9HzrgV1aet5RQA/ekuwSt6Ol2/UtsOoD1pF8Iq44uk=;
        b=cSTyjHYrgNGfr5RkWZW6VuJd6YHfpJUcuVR1gQmZYKK+NbnEI5gYPIKmKxG5O7T6/NBxEufrnTQiNtyZHouPsPvmxaWdtA0xP1jhLnVTW+J1ZT1NpfkHeHgfRxdahxKSdeF9fqTOwZ9hGr6An/vOwni5HYRzUqU3DZeA/DI6wJpwwqhdJ1PzIU1pYSoAQcXLFF0pa6dhWoYx4rKlijlxCBGe8YpJ/i9UduxXCYriwwPP511kFZ/tt/i6wKp0T8bBm8lU2w4lBRaMtzf0PM/jdDbq0O/uqxFs97F4wEXZyEmnVaLaPH/h7TTn4VAFjtwW9ezSM9/FaQuB/TAGSwjlJg==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:39831 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1Zy0Ix-0007W0-92 (Exim); Sun, 15 Nov 2015 16:37:28 +0000
To:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Subject: [PATCH] MIPS: bmips: Support SMP on BCM63168
Message-ID: <5648B4C3.3090508@simon.arlott.org.uk>
Date:   Sun, 15 Nov 2015 16:37:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

The BCM63168 requires the same CPU1 fix as BCM6368.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 arch/mips/bmips/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 526ec27..00409db 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -105,6 +105,7 @@ static const struct bmips_quirk bmips_quirk_list[] = {
 	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
 	{ "brcm,bcm6328",		&bcm6328_quirks			},
 	{ "brcm,bcm6368",		&bcm6368_quirks			},
+	{ "brcm,bcm63168",		&bcm6368_quirks			},
 	{ },
 };
 
-- 
2.1.4

-- 
Simon Arlott
