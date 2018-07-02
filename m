Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jul 2018 20:25:04 +0200 (CEST)
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:31707 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993880AbeGBSY5VFd0U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Jul 2018 20:24:57 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 6EF893FAD8;
        Mon,  2 Jul 2018 20:24:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2a0XjVLzBnaz; Mon,  2 Jul 2018 20:24:56 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 0AEFA3F827;
        Mon,  2 Jul 2018 20:24:55 +0200 (CEST)
Date:   Mon, 2 Jul 2018 20:24:54 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [RFC] MIPS: Align vmlinuz load address to a page boundary
Message-ID: <20180702182453.GA2537@localhost.localdomain>
References: <20180610182056.GA15738@localhost.localdomain>
 <20180702131158.GA431230@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180702131158.GA431230@linux-mips.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Ralf,

On Mon, Jul 02, 2018 at 03:11:58PM +0200, Ralf Baechle wrote:
> Basically MIPS supports page sizes 4k, 8k, 16k, 32k, 64k.  Not every system
> supports all page sizes.  4k is the safe bet while larger systems prefer 16k
> or 64k.  Details are complicated.
> 
> And of course with kexec the kexecing and the kexecuted kernels do not even
> have to have the same page size.  It would appear that the userland code you
> were refering to in your 2nd email in
> 
>   https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/kexec/kexec.c?id=HEAD#n343
> 
> might erroneously fail if pagesize on the kexecing kernel is larger than of
> the kernel being kexed.

The comment in kexec.c suggests that it might be possible to find a way to
"cope with this problem". What could that mean? It came with the initial
commit, so the log is unfortunately not informative.

If we align vmlinuz to 64 KiB then it will work on all systems, I suppose.
Would there be drawbacks? Can the kernel make use of all memory regardless
of its base address, for example?

Fredrik
