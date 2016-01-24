Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jan 2016 01:21:21 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46384 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010131AbcAXAVUVhr5f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 24 Jan 2016 01:21:20 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u0O0LJYM026078;
        Sun, 24 Jan 2016 01:21:19 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u0O0LI9C026077;
        Sun, 24 Jan 2016 01:21:18 +0100
Date:   Sun, 24 Jan 2016 01:21:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Chen Gang <gang.chen.5i5j@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] MIPS: fix double definition of MADV_FREE
Message-ID: <20160124002118.GA25940@linux-mips.org>
References: <1453541623-710122-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453541623-710122-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51342
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

On Sat, Jan 23, 2016 at 10:33:43AM +0100, Manuel Lauss wrote:

> Commit ef58978f1eaab140081ec1808d96ee06e933e760
> ("mm: define MADV_FREE for some arches") introduced MADV_FREE to MIPS,
> commit 21f55b018ba57897f4d3590ecbe11516bdc540af
> ("arch/*/include/uapi/asm/mman.h: : let MADV_FREE have same value for all architectures")
> added another instance, which resulted in this build error:
> 
> In file included from include/uapi/linux/mman.h:4:0,
>                  from include/linux/mman.h:8,
>                  from kernel/fork.c:28:
> arch/mips/include/uapi/asm/mman.h:79:0: warning: "MADV_FREE" redefined
>  #define MADV_FREE 8  /* free pages only if memory pressure */
>  ^
> arch/mips/include/uapi/asm/mman.h:76:0: note: this is the location of the previous definition
>  #define MADV_FREE 5  /* free pages only if memory pressure */
> 
> 
> This patch removes the "MADV_FREE 5" introduced by the first commit
> ("mm: define MADV_FREE for some arches").

Guenter Roeck's commit dcd6c87cc59af1b4fe7664b35c6344bbe1c9928f
("mm: arch: remove duplicate definitions of MADV_FREE") already fixed the
issue.

Thanks,

  Ralf
