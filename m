Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 13:59:02 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:57372 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903669Ab2HNL64 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 13:58:56 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 3810023C0072;
        Tue, 14 Aug 2012 13:58:54 +0200 (CEST)
Message-ID: <502A3D7D.2010403@openwrt.org>
Date:   Tue, 14 Aug 2012 13:58:53 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3 1/4] MIPS: ath79: fix number of GPIO lines for AR724[12]
References: <1344096087-25044-1-git-send-email-juhosg@openwrt.org> <1344096087-25044-2-git-send-email-juhosg@openwrt.org> <20120814092542.GA28466@linux-mips.org>
In-Reply-To: <20120814092542.GA28466@linux-mips.org>
X-Enigmail-Version: 1.4.3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 34146
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

2012.08.14. 11:25 keltezéssel, Ralf Baechle írta:
> Applied.  

Thanks!

> Lemme know if this one also is required for any of the -stable
> branches.

The patch should go into the 3.0+ stable branches.

It has been introduced by the following commit:
6eae43c57ee92de91f6cc7c391cea97c43295da0 (MIPS: ath79: add GPIOLIB support)

git describe --contains 6eae43c57ee92de91f6cc7c391cea97c43295da0 --match 'v*'
v2.6.38-rc1~4^2~12

Although the issues is present since 2.6.38, but 2.6.38 and 2.6.39 is EOL already.

-Gabor
