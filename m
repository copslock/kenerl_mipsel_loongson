Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 19:22:16 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:62138 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007608AbcBVSWOnY5gv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2016 19:22:14 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u1MIM6mX011005
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 22 Feb 2016 10:22:06 -0800 (PST)
Received: from [147.11.216.197] (147.11.216.197) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.248.2; Mon, 22 Feb 2016
 10:22:06 -0800
To:     <david.daney@cavium.com>
CC:     <linux-mips@linux-mips.org>
From:   Yang Shi <yang.shi@windriver.com>
Subject: Does CN68XX still need DCache prefetch workaround?
Message-ID: <56CB51CE.6070905@windriver.com>
Date:   Mon, 22 Feb 2016 10:22:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
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

I David,

When I booted up 4.5-rc4 kernel on CN68xx board, both pass 1.1 and pass 
2.2 reports:

Kernel panic - not syncing: OCTEON II DCache prefetch workaround not in 
place (cfa00000).
Please build kernel with proper options (CONFIG_CAVIUM_CN63XXP1).

According to the description of he option, it should just have impact on 
63xx pass 1.x. It looks confusing.

Any hint is appreciated?

Thanks,
Yang
