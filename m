Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Mar 2010 18:13:19 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:42375 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492051Ab0C0RNP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 27 Mar 2010 18:13:15 +0100
Received: by smtp.gentoo.org (Postfix, from userid 2181)
        id CED241B400C; Sat, 27 Mar 2010 17:13:02 +0000 (UTC)
Date:   Sat, 27 Mar 2010 17:13:02 +0000
From:   Zhang Le <r0bertz@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Subject: Re: [PATCH v3 3/3] Loongson-2F: Fixup of problems introduced by
        -mfix-loongson2f-jump of binutils 2.20.1
Message-ID: <20100327171302.GB19154@woodpecker.gentoo.org>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Shinya Kuribayashi <shinya.kuribayashi@necel.com>
References: <cover.1268453720.git.wuzhangjin@gmail.com> <169f2daa3d623fe56c5b0be30feeda10bc79a478.1268453720.git.wuzhangjin@gmail.com> <20100317150207.GB4554@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100317150207.GB4554@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 16:02 Wed 17 Mar     , Ralf Baechle wrote:
> The workaround in http://sourceware.org/ml/binutils/2009-11/msg00387.html
> will also cause problems calling functions with bits 28..29 set, that is

Yes. If all functions address doesn't have 28..29 set, this patch will not have
any side effect. That means all functions should reside in two ranges:
0x80000000..0x8fffffff
0xc0000000..0xcfffffff

> in the ranges 0x81000000..0xbffffff and 0xd0000000..0xffffffff.  The
                ^^^^^^^^^^
I think you mean 0x90000000, right?

> first range is not much of a problem as only the kernel proper resides
> there and the kernel load address is manually selected in the Makefile.
> The 2nd range might be used for under certain circumstances.

It seems the Loongson kernel I compiled satisfies the requirement I listed
above:

ffffffff80200000 A _text
...
ffffffff8089bbe0 A _end

So, if I understand it correctly, as long as the kernel size is smaller than
254MB, the patch should be ok. Is there anything I overlooked?

Zhang, Le
