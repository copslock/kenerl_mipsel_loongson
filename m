Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Apr 2010 05:11:39 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:38446 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491078Ab0DCDLf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 3 Apr 2010 05:11:35 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1Nxtlj-0000xh-RJ; Sat, 03 Apr 2010 03:11:31 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1Nxtle-0005hy-4P; Sat, 03 Apr 2010 05:11:26 +0200
Date:   Sat, 3 Apr 2010 05:11:26 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v3 1/3] Loongson-2F: Flush the branch target history
        such as BTB and RAS
Message-ID: <20100403031126.GT27216@mails.so.argh.org>
References: <cover.1268453720.git.wuzhangjin@gmail.com> <05e2ba2596f23fa4dda64d63ce2480504b1be4ac.1268453720.git.wuzhangjin@gmail.com> <20100402145401.GS27216@mails.so.argh.org> <20100403015352.GA26168@woodpecker.gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100403015352.GA26168@woodpecker.gentoo.org>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@not.so.argh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips

* Zhang Le (r0bertz@gentoo.org) [100403 04:20]:
> On 16:54 Fri 02 Apr     , Andreas Barth wrote:
> > * Wu Zhangjin (wuzhangjin@gmail.com) [100313 05:45]:
> > > This patch did clear BTB(branch target buffer), forbid RAS(return
> > > address stack) via Loongson-2F's 64bit diagnostic register.
> > 
> > Unfortunatly the Loongson 2F here still fails with this patch,
> > compiled with the new binutils and both options enabled.
> 
> Which version of binutils exactly?
> The patch is in cvs, but latest binutils-2.20.1 still didn't include it.
> You need to patch it.

Yes, binutils are patched with
http://sourceware.org/ml/binutils/2009-11/msg00387.html


Andi
