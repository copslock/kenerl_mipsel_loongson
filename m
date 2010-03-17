Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2010 16:11:42 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43811 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492386Ab0CQPLZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Mar 2010 16:11:25 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2HFBOYY006921;
        Wed, 17 Mar 2010 16:11:24 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2HFBO8q006919;
        Wed, 17 Mar 2010 16:11:24 +0100
Date:   Wed, 17 Mar 2010 16:11:24 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org,
        Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Subject: Re: [PATCH v3 1/3] Loongson-2F: Flush the branch target history such
 as BTB and RAS
Message-ID: <20100317151124.GC4554@linux-mips.org>
References: <cover.1268453720.git.wuzhangjin@gmail.com>
 <05e2ba2596f23fa4dda64d63ce2480504b1be4ac.1268453720.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05e2ba2596f23fa4dda64d63ce2480504b1be4ac.1268453720.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 13, 2010 at 12:34:15PM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> As the Chapter 15: "Errata: Issue of Out-of-order in loongson"[1] shows, to
> workaround the Issue of Loongson-2F，We need to do:
> 
> "When switching from user mode to kernel mode, you should flush the
> branch target history such as BTB and RAS."
> 
> This patch did clear BTB(branch target buffer), forbid RAS(return
> address stack) via Loongson-2F's 64bit diagnostic register.
> 
> [1] Chinese Version: http://www.loongson.cn/uploadfile/file/200808211
> [2] English Version of Chapter 15:
> http://groups.google.com.hk/group/loongson-dev/msg/e0d2e220958f10a6?dmode=source

Thanks, applied.

  Ralf
