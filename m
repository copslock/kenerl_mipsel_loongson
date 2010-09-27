Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Sep 2010 07:21:20 +0200 (CEST)
Received: from sh.osrg.net ([192.16.179.4]:51468 "EHLO sh.osrg.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491041Ab0I0FVR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Sep 2010 07:21:17 +0200
Received: from localhost (rose.osrg.net [10.76.0.1])
        by sh.osrg.net (8.14.3/8.14.3/OSRG-NET) with ESMTP id o8R5KGUP026873;
        Mon, 27 Sep 2010 14:20:16 +0900
Date:   Mon, 27 Sep 2010 14:20:16 +0900
To:     ddaney@caviumnetworks.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        fujita.tomonori@lab.ntt.co.jp, konrad.wilk@oracle.com,
        mingo@elte.hu, andre.goddard@gmail.com
Subject: Re: [PATCH 7/9] swiotlb: Make bounce buffer bounds non-static.
From:   FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1285282051-24907-2-git-send-email-ddaney@caviumnetworks.com>
References: <1285281496-24696-1-git-send-email-ddaney@caviumnetworks.com>
        <1285282051-24907-2-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20100927141616S.fujita.tomonori@lab.ntt.co.jp>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (sh.osrg.net [192.16.179.4]); Mon, 27 Sep 2010 14:20:21 +0900 (JST)
X-Virus-Scanned: clamav-milter 0.96.1 at sh
X-Virus-Status: Clean
X-archive-position: 27829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fujita.tomonori@lab.ntt.co.jp
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 20853

On Thu, 23 Sep 2010 15:47:31 -0700
David Daney <ddaney@caviumnetworks.com> wrote:

> Octeon PCI mapping has to be established to cover the bounce buffers,
> so it has to have access to the bounds.

Why can't you use swiotlb_init_with_tbl() instead?
