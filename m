Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jun 2013 15:09:23 +0200 (CEST)
Received: from alius.ayous.org ([89.238.89.44]:57284 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816022Ab3FVNJW35cAI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 22 Jun 2013 15:09:22 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@ayous.org>)
        id 1UqNZA-0000s1-5S; Sat, 22 Jun 2013 13:09:22 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@ayous.org>)
        id 1UqNZ4-00057W-Pa; Sat, 22 Jun 2013 15:09:14 +0200
Date:   Sat, 22 Jun 2013 15:09:14 +0200
From:   Andreas Barth <aba@ayous.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V10 06/13] MIPS: Loongson 3: Add HT-linked PCI support
Message-ID: <20130622130914.GC19237@mails.so.argh.org>
References: <1366030028-5084-1-git-send-email-chenhc@lemote.com> <1366030028-5084-7-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1366030028-5084-7-git-send-email-chenhc@lemote.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@ayous.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@ayous.org
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

* Huacai Chen (chenhc@lemote.com) [130415 14:49]:
> Loongson family machines use Hyper-Transport bus for inter-core
> connection and device connection. The PCI bus is a subordinate
> linked at HT1.
> 
> With UEFI-like firmware interface, We don't need fixup for PCI irq
> routing.

ops-loongson3 looks to my untrained eyes much like ops-loongson2.
Would it be possible to merge the two (without useing #ifdef)?


Andi
