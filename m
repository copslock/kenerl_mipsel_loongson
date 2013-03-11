Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Mar 2013 18:14:28 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35206 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825885Ab3CKRO1klHg8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Mar 2013 18:14:27 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kL3K8dlECMQp; Mon, 11 Mar 2013 18:14:01 +0100 (CET)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 39712280471;
        Mon, 11 Mar 2013 18:14:00 +0100 (CET)
Message-ID: <513E10F3.8010306@openwrt.org>
Date:   Mon, 11 Mar 2013 18:14:27 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org, blogic@openwrt.org,
        kaloz@openwrt.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: use newly introduced devm_ioremap_resource()
References: <1363015477-29685-1-git-send-email-silviupopescu1990@gmail.com>
In-Reply-To: <1363015477-29685-1-git-send-email-silviupopescu1990@gmail.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-archive-position: 35867
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
Return-Path: <linux-mips-bounce@linux-mips.org>

2013.03.11. 16:24 keltezéssel, Silviu-Mihai Popescu írta:
> Convert all uses of devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.
> 
> devm_ioremap_resource() provides its own error messages so all explicit
> error messages can be removed from the failure code paths.
> 
> Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>

Acked-by: Gabor Juhos <juhosg@openwrt.org>
