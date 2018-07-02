Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jul 2018 15:55:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51476 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993849AbeGBNzjXJ-3r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Jul 2018 15:55:39 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id w62DskWt433159;
        Mon, 2 Jul 2018 15:54:46 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id w62Dsgf1433158;
        Mon, 2 Jul 2018 15:54:42 +0200
Date:   Mon, 2 Jul 2018 15:54:42 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     paul.burton@mips.com, jhogan@kernel.org, linux-mips@linux-mips.org,
        ak@linux.intel.com, Matthew Fortune <mfortune@gmail.com>
Subject: Re: [PATCH] MIPS: define __current_thread_info inside of function
Message-ID: <20180702135442.GB431230@linux-mips.org>
References: <20180616155815.31230-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180616155815.31230-1-hauke@hauke-m.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64539
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

On Sat, Jun 16, 2018 at 05:58:15PM +0200, Hauke Mehrtens wrote:

> __current_thread_info is currently defined in the header file, but when
> we link the kernel with LTO it shows up in all files which include this
> header file and causes conflicts with itself. Move the definition into
> the only function which uses it to prevent these problems.
> 
> This fixes the build with LTO.

Not a new issue, see

  https://git.linux-mips.org/cgit/ralf/linux-lto.git/commit/arch/mips/include/asm/thread_info.h?id=969890d139ee53f61fc6ed3f534335802c733e1b

This was never upstreamed since LTO never received much love from upstream
back then and there might be more well ripened code in there.

To me this appeared like a compiler issue; I think this global register
variable should be treated like a cmmon variable.

Maybe Matthew can shed some light on this?

  Ralf
