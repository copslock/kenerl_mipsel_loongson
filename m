Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 10:50:24 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:36481 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835069Ab3DLI3iC0l07 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 10:29:38 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kQAmrtOxbJhB; Fri, 12 Apr 2013 10:28:20 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id A6734280520;
        Fri, 12 Apr 2013 10:28:20 +0200 (CEST)
Message-ID: <5167C5EE.4010408@openwrt.org>
Date:   Fri, 12 Apr 2013 10:29:34 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 04/16] MIPS: ralink: add RT5350 sdram register defines
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org> <1365751663-5725-4-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365751663-5725-4-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36105
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

2013.04.12. 9:27 keltez�ssel, John Crispin �rta:
> Add a few missing defines that are needed to make memory detection work on the
> RT5350.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>

Acked-by: Gabor Juhos <juhosg@openwrt.org>
