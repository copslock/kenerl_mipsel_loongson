Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 14:01:42 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:57830 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903669Ab2HNMBf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 14:01:35 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id F023723C0072;
        Tue, 14 Aug 2012 14:01:29 +0200 (CEST)
Message-ID: <502A3E19.5080504@openwrt.org>
Date:   Tue, 14 Aug 2012 14:01:29 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3 2/4] MIPS: ath79: use correct IRQ number for the OHCI
 controller on AR7240
References: <1344096087-25044-1-git-send-email-juhosg@openwrt.org> <1344096087-25044-3-git-send-email-juhosg@openwrt.org> <20120814092554.GB28466@linux-mips.org>
In-Reply-To: <20120814092554.GB28466@linux-mips.org>
X-Enigmail-Version: 1.4.3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 34147
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
> Applied. Lemme know if this one also is required for any of the -stable
> branches.

It is broken since:
7e98aa4639cba9ef5c99b1484bc86ddb04f67b80 (MIPS: ath79: add common USB Host
Controller device)

git describe --contains 7e98aa4639cba9ef5c99b1484bc86ddb04f67b80 --match 'v*'
v3.3-rc1~65^2^3~23

3.3 is EOL already, so this should go only into 3.4+ stable branches.

Thanks,
Gabor
