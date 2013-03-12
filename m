Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Mar 2013 14:54:45 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58146 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827485Ab3CLNyoHGzVG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Mar 2013 14:54:44 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r2CDsgGC014744;
        Tue, 12 Mar 2013 14:54:42 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r2CDsfCv014743;
        Tue, 12 Mar 2013 14:54:41 +0100
Date:   Tue, 12 Mar 2013 14:54:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Zhi-zhou Zhang <zhizhou.zh@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: lib/bitops.c: fix wrong return type
Message-ID: <20130312135441.GA13792@linux-mips.org>
References: <n>
 <1363093253-17595-1-git-send-email-zhizhou.zh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1363093253-17595-1-git-send-email-zhizhou.zh@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35879
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 12, 2013 at 09:00:53PM +0800, Zhi-zhou Zhang wrote:

> Here should return 64-bit types rather than 32-bit types. Or we
> may get wrong return value if high 32-bit isn't equal to zero.

David Daney's patch which I've applied not two hours before you posted
this patch solves the same issue though a different way.  So I'm just
going to drop this patch.

Thanks anyway!

  Ralf
