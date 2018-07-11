Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 12:16:56 +0200 (CEST)
Received: from forward104p.mail.yandex.net ([77.88.28.107]:54796 "EHLO
        forward104p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993514AbeGKKQuL4no4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jul 2018 12:16:50 +0200
Received: from mxback1g.mail.yandex.net (mxback1g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:162])
        by forward104p.mail.yandex.net (Yandex) with ESMTP id B3C52181BC3;
        Wed, 11 Jul 2018 13:14:57 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id QIlY3WS5VM-Eu1G4nPP;
        Wed, 11 Jul 2018 13:14:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1531304097;
        bh=XCCe7vZc7GQyW/Uk20RcYER7XQFfgxW8goHDS9VObxA=;
        h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References;
        b=WbgbahD0+vZJfY3jnRlpGa+xI1+WC81hJZdXBnPchpOduLhpn/jZRvMAZ+8rW8vpI
         KOxfFiGvAOvK9jE9PkbZQ6A4SsUnLCQRSLyy94R808f93VSpN5JhTiPtoU32YX/9dC
         9tEgueIFzhdbbd6/DnLpi4KmciYvZ7xscM/3BOHM=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id fDNQFekDBA-EmhCeUUh;
        Wed, 11 Jul 2018 13:14:53 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1531304094;
        bh=XCCe7vZc7GQyW/Uk20RcYER7XQFfgxW8goHDS9VObxA=;
        h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References;
        b=eCSIkuGGxcPhycRObxIrrwZk4lN1sPuTvO3aqvHXxpZvZefNyJllo4kHv+gkw4dh+
         RWbHVp4cBjBxmrYVpnHRPUW6P7P6Zs1xWkn2pgQKiQWB8D75meSOpG0ByfSFOICrVf
         XwXcAzmMoqMNG+zMQKj0C/EXrL2VcvzYeHMdgeRY=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@linux-mips.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Date:   Wed, 11 Jul 2018 18:05:51 +0800
Message-ID: <5471216.FKXZRxKFUI@flygoat-ry>
In-Reply-To: <20180710121727.GK2476@hirez.programming.kicks-ass.net>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com> <tencent_26F8B9E004D4512B2225FCE1@qq.com> <20180710121727.GK2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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

On 2018-7-10 Tue at 20:17:27，Peter Zijlstra Wrote：

Hi Peter
Since Huacai unable to send email via client, I'm going to reply for him 
 
> Sure.. we all got that far. And no, this isn't the _real_ problem. This
> is a manifestation of the problem.
> 
> The problem is that your SFB is broken (per the Linux requirements). We
> require that stores will become visible. That is, they must not
> indefinitely (for whatever reason) stay in the store buffer.
> 
> > I don't think this is a hardware bug, in design, SFB will flushed to
> > L1 cache in three cases:
> > 
> > 1, data in SFB is full (be a complete cache line);
> > 2, there is a subsequent read access in the same cache line;
> > 3, a 'sync' instruction is executed.
> 
> And I think this _is_ a hardware bug. You just designed the bug instead
> of it being by accident.
Yes, we understood that this hardware feature is not supported by LKML,
so it should be a hardware bug for LKML.
> 
> It doesn't happen an _any_ other architecture except that dodgy
> ARM11MPCore part. Linux hard relies on stores to become available
> _eventually_.
> 
> Still, even with the rules above, the best work-around is still the very
> same cpu_relax() hack.

As you say, SFB makes Loongson not fully SMP-coherent.
However, modify cpu_relax can solve the current problem,
but not so straight forward. On the other hand, providing a Loongson-specific 
WRITE_ONCE looks more reasonable, because it the eliminate the "non-cohrency".
So we can solve the bug from the root.

Thanks.
--
Jiaxun Yang
