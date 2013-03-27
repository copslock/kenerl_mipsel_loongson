Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Mar 2013 15:02:21 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:1109 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817974Ab3C0OCTb2NNz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Mar 2013 15:02:19 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2RE29RZ025594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 27 Mar 2013 10:02:09 -0400
Received: from mail.random (ovpn-116-30.ams2.redhat.com [10.36.116.30])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r2RE27q3027898;
        Wed, 27 Mar 2013 10:02:08 -0400
Date:   Wed, 27 Mar 2013 15:02:07 +0100
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: mm/huge_memory.c:221:7: error: incompatible types when assigning
 to type 'pmd_t' from type 'int'
Message-ID: <20130327140207.GL27472@redhat.com>
References: <5152b651.JKLmvRYh1bEEyapp%fengguang.wu@intel.com>
 <20130327092631.GB13351@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130327092631.GB13351@localhost>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-archive-position: 35982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aarcange@redhat.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

On Wed, Mar 27, 2013 at 05:26:31PM +0800, Fengguang Wu wrote:
> Hi Andrea,
> 
> FYI, kernel build failed on
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
> head:   a12183c62717ac4579319189a00f5883a18dff08
> commit: 71e3aac0724ffe8918992d76acfe3aad7d8724a5 thp: transparent hugepage core
> date:   2 years, 2 months ago
> config: make ARCH=mips allmodconfig
> 
> All error/warnings:
> 
>    mm/huge_memory.c:19:15: error: expected identifier or '(' before numeric constant
>    mm/huge_memory.c: In function 'double_flag_show':
>    mm/huge_memory.c:28:24: error: lvalue required as unary '&' operand
>    mm/huge_memory.c:29:3: error: lvalue required as unary '&' operand
>    mm/huge_memory.c:31:32: error: lvalue required as unary '&' operand

It's certainly mips specific, TRANSPARENT_HUGEPAGE gets set but
there's likely some asm header screwup, maybe hidden by
setting/unsetting some other config option. Wondering if there's any
pending push that may be fixing this already. If you need I can build
the cross compiler and solve it but it's good idea to check if there's
a pending push somewhere (or in -mm) first.

Thanks,
Andrea
