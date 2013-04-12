Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 10:21:41 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:35028 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827495Ab3DLIVNPIWVc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 10:21:13 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zVd5Kgqi6VE7; Fri, 12 Apr 2013 10:20:20 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 9900A2802BD;
        Fri, 12 Apr 2013 10:20:20 +0200 (CEST)
Message-ID: <5167C40E.50605@openwrt.org>
Date:   Fri, 12 Apr 2013 10:21:34 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 01/16] MIPS: ralink: add PCI IRQ handling
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365751663-5725-1-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36101
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

2013.04.12. 9:27 keltezéssel, John Crispin írta:
> From: Gabor Juhos <juhosg@openwrt.org>
> 
> The Ralink IRQ code was not handling the PCI IRQ yet. Add this functionaility
> to make PCI work on rt3883.
> 

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>

> Signed-off-by: John Crispin <blogic@openwrt.org>
