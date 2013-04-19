Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Apr 2013 21:22:37 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:54447 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827516Ab3DSTWQwJUYu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Apr 2013 21:22:16 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id glrOG7BArGtu; Fri, 19 Apr 2013 21:21:24 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 57B0728086A;
        Fri, 19 Apr 2013 21:21:24 +0200 (CEST)
Message-ID: <51719967.7030700@openwrt.org>
Date:   Fri, 19 Apr 2013 21:22:15 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [RFC] MIPS: ath79: make use of the new memory detection code
References: <1366022709-8485-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1366022709-8485-1-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36273
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

2013.04.15. 12:45 keltezéssel, John Crispin írta:
> There is now a generic function for detecting memory size. Use this instead of
> the one found in the ath79 support.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>

Although this was sent only as an RFC, it is working on top of v2 of the
detect_memory_region patch series.

Acked-by: Gabor Juhos <juhosg@openwrt.org>
