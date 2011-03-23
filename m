Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 23:42:17 +0100 (CET)
Received: from wolverine02.qualcomm.com ([199.106.114.251]:38730 "EHLO
        wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491903Ab1CWWmN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 23:42:13 +0100
X-IronPort-AV: E=McAfee;i="5400,1158,6294"; a="81489850"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostssh02.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Mar 2011 15:42:08 -0700
Received: from localhost.qualcomm.com ([127.0.0.1] helo=huya.qualcomm.com)
        by mostssh02.qualcomm.com with esmtp (Exim 4.71)
        (envelope-from <davidb@codeaurora.org>)
        id 1Q2WkE-0006gX-W5; Wed, 23 Mar 2011 15:41:39 -0700
From:   David Brown <davidb@codeaurora.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
        Linus Walleij <linus.walleij@stericsson.com>,
        Daniel Walker <dwalker@fifo99.com>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-msm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [trivial PATCH 1/2] treewide: Fix iomap resource size miscalculations
References: <cover.1300909445.git.joe@perches.com>
        <c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
Date:   Wed, 23 Mar 2011 15:42:47 -0700
In-Reply-To: <c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
        (Joe Perches's message of "Wed, 23 Mar 2011 12:55:36 -0700")
Message-ID: <8ya39md7920.fsf@huya.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <davidb@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davidb@codeaurora.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 23 2011, Joe Perches wrote:

> Convert off-by-1 r->end - r->start to resource_size(r)
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/video/msm/mddi.c          |    2 +-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
