Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 13:03:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57480 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026026AbcDDLDXmieqC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Apr 2016 13:03:23 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u34B3L1v019097;
        Mon, 4 Apr 2016 13:03:21 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u34B3Kbu019096;
        Mon, 4 Apr 2016 13:03:20 +0200
Date:   Mon, 4 Apr 2016 13:03:20 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org, alex.smith@imgtec.com,
        sergei.shtylyov@cogentembedded.com,
        "# v4 . 4+" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: vdso: flush the vdso data page to update it on
 all processes
Message-ID: <20160404110320.GC15222@linux-mips.org>
References: <1456074518-13163-1-git-send-email-hauke@hauke-m.de>
 <56FAF575.4070607@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56FAF575.4070607@hauke-m.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52873
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

On Tue, Mar 29, 2016 at 11:36:53PM +0200, Hauke Mehrtens wrote:

> On 02/21/2016 06:08 PM, Hauke Mehrtens wrote:
> > Without flushing the vdso data page the vdso call is working on dated
> > or unsynced data. This resulted in problems where the clock_gettime
> > vdso call returned a time 6 seconds later after a 3 seconds sleep,
> > while the syscall reported a time 3 sounds later, like expected. This
> > happened very often and I got these ping results for example:
> > 
> > root@OpenWrt:/# ping 192.168.1.255
> > PING 192.168.1.255 (192.168.1.255): 56 data bytes
> > 64 bytes from 192.168.1.3: seq=0 ttl=64 time=0.688 ms
> > 64 bytes from 192.168.1.3: seq=1 ttl=64 time=4294172.045 ms
> > 64 bytes from 192.168.1.3: seq=2 ttl=64 time=4293968.105 ms
> > 64 bytes from 192.168.1.3: seq=3 ttl=64 time=4294055.920 ms
> > 64 bytes from 192.168.1.3: seq=4 ttl=64 time=4294671.913 ms
> > 
> > This was tested on a Lantiq/Intel VRX288 (MIPS BE 34Kc V5.6 CPU with
> > two VPEs)
> > 
> > Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> > Cc: <stable@vger.kernel.org> # v4.4+
> 
> This patch flushes the complete dcache of the CPU if cpu_has_dc_aliases
> is set.
> 
> Calling flush_dcache_page(virt_to_page(&vdso_data)); improved the
> situation a litte bit but did not fix my problem.
> 
> Could someone from Imagination please look into this problem. The page
> is linked into many virtual address spaces and when it gets modified by
> the kernel the user space processes are still accessing partly old data,
> even when lush_dcache_page() was called.

This is because there may be a stale cache entry on the user virtual
address.  In order to correctly flush the cache one either has to do
one of the following.

 - use indexed cache ops to flush all matching cache ways
 - flush the user space address while running in the mm context of the
   affected process.  Since this would need to be done for all processes
   this is not a very practical approach.
 - pick a suitable VA for example in KSEG0 or XKPHYS and user that for
   the flush operation.

Indexed cacheops are not globalized by the MIPS CM so I'd go for the
last operation.

  Ralf
