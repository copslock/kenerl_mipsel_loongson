Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Apr 2013 09:27:43 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:44829 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823031Ab3DNH1lwoeIt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 14 Apr 2013 09:27:41 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fHv3eKDhkH4o; Sun, 14 Apr 2013 09:26:53 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id CF0C92802C2;
        Sun, 14 Apr 2013 09:26:53 +0200 (CEST)
Message-ID: <516A5A90.8080407@openwrt.org>
Date:   Sun, 14 Apr 2013 09:28:16 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 03/14] MIPS: ralink: fix RT305x clock setup
References: <1365842905-10906-1-git-send-email-blogic@openwrt.org> <1365842905-10906-3-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365842905-10906-3-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.04.13. 10:48 keltezéssel, John Crispin írta:
> Add a few missing clocks.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>

Acked-by: Gabor Juhos <juhosg@openwrt.org>
