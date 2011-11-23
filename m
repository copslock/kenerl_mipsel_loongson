Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 12:50:21 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:60442 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903547Ab1KWLuP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Nov 2011 12:50:15 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 9015A23C00A2;
        Wed, 23 Nov 2011 12:50:10 +0100 (CET)
Message-ID: <4ECCDDF1.7060605@openwrt.org>
Date:   Wed, 23 Nov 2011 12:50:09 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     =?UTF-8?B?UmVuw6kgQm9sbGRvcmY=?= <xsecute@googlemail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v4 4/7] MIPS: ath79: add a common PCI registration function
References: <1321887999-14546-1-git-send-email-juhosg@openwrt.org> <1321887999-14546-5-git-send-email-juhosg@openwrt.org> <CAEWqx5-05WSPYfWOO=TBtQAJ0NmvCGvtJ1LEgfiJ3UdzJF+q2g@mail.gmail.com>
In-Reply-To: <CAEWqx5-05WSPYfWOO=TBtQAJ0NmvCGvtJ1LEgfiJ3UdzJF+q2g@mail.gmail.com>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19826

2011.11.23. 11:34 keltezéssel, René Bolldorf írta:
> And where is 'arch/mips/ath79/pci.h' ?

That is introduced in the previous (3/7) patch.
