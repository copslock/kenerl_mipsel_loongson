Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Sep 2016 15:56:09 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55846 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992262AbcIPN4CZOp7n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Sep 2016 15:56:02 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8GDtq5o022113;
        Fri, 16 Sep 2016 15:55:52 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8GDtb7K022096;
        Fri, 16 Sep 2016 15:55:37 +0200
Date:   Fri, 16 Sep 2016 15:55:37 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Baoyou Xie <baoyou.xie@linaro.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de, akpm@linux-foundation.org,
        paul.burton@imgtec.com, chenhc@lemote.com, david.daney@cavium.com,
        kumba@gentoo.org, yamada.masahiro@socionext.com,
        kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com,
        toshi.kani@hpe.com, dan.j.williams@intel.com, luto@kernel.org,
        JBeulich@suse.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        xie.baoyou@zte.com.cn
Subject: Re: [PATCH v2] mm: move phys_mem_access_prot_allowed() declaration
 to pgtable.h
Message-ID: <20160916135537.GA22042@linux-mips.org>
References: <1473751597-12139-1-git-send-email-baoyou.xie@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1473751597-12139-1-git-send-email-baoyou.xie@linaro.org>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Sep 13, 2016 at 03:26:37PM +0800, Baoyou Xie wrote:

> We get 1 warning when building kernel with W=1:
> drivers/char/mem.c:220:12: warning: no previous prototype for 'phys_mem_access_prot_allowed' [-Wmissing-prototypes]
>  int __weak phys_mem_access_prot_allowed(struct file *file,
> 
> In fact, its declaration is spreading to several header files
> in different architecture, but need to be declare in common
> header file.
> 
> So this patch moves phys_mem_access_prot_allowed() to pgtable.h.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
