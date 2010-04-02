Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Apr 2010 17:04:03 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:33636 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491892Ab0DBPD6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Apr 2010 17:03:58 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1NxiG8-0004JD-WA; Fri, 02 Apr 2010 14:54:11 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1NxiG1-00052Y-Fa; Fri, 02 Apr 2010 16:54:01 +0200
Date:   Fri, 2 Apr 2010 16:54:01 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v3 1/3] Loongson-2F: Flush the branch target history
        such as BTB and RAS
Message-ID: <20100402145401.GS27216@mails.so.argh.org>
References: <cover.1268453720.git.wuzhangjin@gmail.com> <05e2ba2596f23fa4dda64d63ce2480504b1be4ac.1268453720.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05e2ba2596f23fa4dda64d63ce2480504b1be4ac.1268453720.git.wuzhangjin@gmail.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@not.so.argh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips

* Wu Zhangjin (wuzhangjin@gmail.com) [100313 05:45]:
> This patch did clear BTB(branch target buffer), forbid RAS(return
> address stack) via Loongson-2F's 64bit diagnostic register.

Unfortunatly the Loongson 2F here still fails with this patch,
compiled with the new binutils and both options enabled.

Testcase: plain debian unstable chroot, build binutils in that chroot.

More ideas, codes, whatever welcome.



Andi
