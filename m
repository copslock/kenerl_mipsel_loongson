Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2018 11:30:13 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:21342 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990946AbeGVJaKl1ep4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2018 11:30:10 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id E2ED041F11;
        Sun, 22 Jul 2018 11:30:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id nAQQ5fssY1Ek; Sun, 22 Jul 2018 11:30:03 +0200 (CEST)
Subject: Re: [PATCH 4/4] net: dsa: Add Lantiq / Intel DSA driver for vrx200
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-5-hauke@hauke-m.de>
 <20180721.201735.301763862002485076.davem@davemloft.net>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <73fa073e-fac2-1adf-3aff-be208c9aa2f7@hauke-m.de>
Date:   Sun, 22 Jul 2018 11:29:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180721.201735.301763862002485076.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: de-LU
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 07/22/2018 05:17 AM, David Miller wrote:
> From: Hauke Mehrtens <hauke@hauke-m.de>
> Date: Sat, 21 Jul 2018 21:13:58 +0200
> 
>> +		// start the table access:
> 
> Please stick to C-style comments, except perhaps in the SPDX
> identifiers.
> 
> Thank you.
> 

Sorry that I missed that, it is fixed now.

Hauke
