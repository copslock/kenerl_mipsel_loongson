Return-Path: <SRS0=LSmN=SY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4967BC282E1
	for <linux-mips@archiver.kernel.org>; Mon, 22 Apr 2019 19:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A052075A
	for <linux-mips@archiver.kernel.org>; Mon, 22 Apr 2019 19:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfDVTyA (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:54:00 -0400
Received: from verein.lst.de ([213.95.11.211]:41690 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731237AbfDVTyA (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 22 Apr 2019 15:54:00 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 44CDD68B02; Mon, 22 Apr 2019 21:53:43 +0200 (CEST)
Date:   Mon, 22 Apr 2019 21:53:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 03/11] arm64: Consider stack randomization for mmap
 base only when necessary
Message-ID: <20190422195341.GB2224@lst.de>
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-4-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417052247.17809-4-alex@ghiti.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, Apr 17, 2019 at 01:22:39AM -0400, Alexandre Ghiti wrote:
> Do not offset mmap base address because of stack randomization if
> current task does not want randomization.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
