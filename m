Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 06:32:49 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44534 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991726AbdHHEcelGtZZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Aug 2017 06:32:34 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v784WXr3005856;
        Tue, 8 Aug 2017 06:32:33 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v784WXnK005855;
        Tue, 8 Aug 2017 06:32:33 +0200
Date:   Tue, 8 Aug 2017 06:32:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Nathan Sullivan <nathan.sullivan@ni.com>
Subject: Re: [PATCH 4/4] MIPS: NI 169445: Fix lack of ITS root node
Message-ID: <20170808043233.GG3509@linux-mips.org>
References: <20170807223724.19408-1-paul.burton@imgtec.com>
 <20170807223724.19408-5-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170807223724.19408-5-paul.burton@imgtec.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59416
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

On Mon, Aug 07, 2017 at 03:37:24PM -0700, Paul Burton wrote:

> For some reason the root node was missing in the NI 169445 flattened
> image tree source, leading to the following build error when attempting
> to generate the flattened image tree binary:
> 
>   ITB     arch/mips/boot/vmlinux.gz.itb
> Error: arch/mips/boot/vmlinux.gz.its:90.1-2 syntax error
> FATAL ERROR: Unable to parse input tree
> /usr/bin/mkimage: Can't read arch/mips/boot/vmlinux.gz.itb.tmp: Invalid argument
> make[1]: *** [arch/mips/boot/Makefile:165: arch/mips/boot/vmlinux.gz.itb] Error 255
> make: *** [arch/mips/Makefile:371: vmlinux.gz.itb] Error 2
> 
> Fix this by adding in the root node.

My bad, I messed this up when fixing a merge conflict in
arch/mips/generic/vmlinux.its.S.  I fixed the original
commit instead.

Thanks,

  Ralf
