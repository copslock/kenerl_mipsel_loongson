Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2017 22:38:45 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:50014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993913AbdJIUie4LYvG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Oct 2017 22:38:34 +0200
Received: from kernel.org (unknown [199.201.64.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F338A218C5;
        Mon,  9 Oct 2017 20:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F338A218C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shli@kernel.org
Date:   Mon, 9 Oct 2017 13:38:30 -0700
From:   Shaohua Li <shli@kernel.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-raid@vger.kernel.org, Linux/MIPS <linux-mips@linux-mips.org>
Subject: Re: commit 8031c3ddc70a breaks RAID5 on MIPS kernel where PAGE_SIZE
 == 64K
Message-ID: <20171009203830.qu75s3i6ghdaf6s2@kernel.org>
References: <db0e511c-f5db-99fe-70ac-150864432db0@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db0e511c-f5db-99fe-70ac-150864432db0@gentoo.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <shli@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shli@kernel.org
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

On Sun, Oct 08, 2017 at 04:34:52PM -0400, Joshua Kinard wrote:
> Hi,
> 
> Testing 4.13.5 out on my SGI Octane, I discovered that my RAID5 arrays were no
> longer auto-assembling.  The error being thrown was an "attempt to access
> beyond the end of the device".  I've hand-transcribed a block of these errors
> from a manual attempt to assemble the array via mdadm from a netboot image:
> 
> / # mdadm -A /dev/md0 /dev/sda1 /dev/sdb1 /dev/sdc1
> [   56.303339] md: md0 stopped.
> [   56.323565] md/raid:md0: device sda1 operational as raid disk 0
> [   56.334556] md/raid:md0: device sdb1 operational as raid disk 2
> [   56.345396] md/raid:md0: device sdc1 operational as raid disk 1
> [   56.350750] md/raid:md0: raid level 5 active with 3 out of 3 devices,
> algorithm 2
> [   56.369529] attempt to access beyond end of device
> [   56.380149] sda1: rw=2048, want=4194312, limit=4194305
> [   56.390823] attempt to access beyond end of device
> [   56.401500] sdc1: rw=2048, want=4194312, limit=4194305
> [   56.412313] attempt to access beyond end of device
> [   56.423146] sdb1: rw=2048, want=4194312, limit=4194305
> [   56.433985] md0: failed to create bitmap (-5)
> mdadm: failed to RUN_ARRAY /dev/md0: input/output error
> [   56.457979] md: md0 stopped.
> / #
> 
> I've traced the offending commit down to 8031c3ddc70a ("md/bitmap: copy correct
> data for bitmap super"):
> 
> https://git.linux-mips.org/cgit/ralf/linux.git/commit/?id=8031c3ddc70ab93099e7d1814382dba39f57b43e
> 
> Per the commit message, it makes an assumption that PAGE_SIZE is 4K.  MIPS
> kernels allow you to change the value of PAGE_SIZE at compile time to something
> other than 4K.  It appears that 4K and 16K both work, while 64K, which is what
> I use on this machine, is broken with this commit applied.
> 
> Reverting this patch or setting PAGE_SIZE to 4K or 16K will resolve the issue,
> but there are advantages to using 64K PAGE_SIZEs on these platforms.  I am not
> sure that 16K is wholly safe either, FWIW, given the assumption made in the commit.

Can you try below one?


diff --git a/drivers/md/bitmap.c b/drivers/md/bitmap.c
index d2121637b4ab..f68ec973fbdd 100644
--- a/drivers/md/bitmap.c
+++ b/drivers/md/bitmap.c
@@ -153,6 +153,7 @@ static int read_sb_page(struct mddev *mddev, loff_t offset,
 
 	struct md_rdev *rdev;
 	sector_t target;
+	int target_size;
 
 	rdev_for_each(rdev, mddev) {
 		if (! test_bit(In_sync, &rdev->flags)
@@ -161,9 +162,12 @@ static int read_sb_page(struct mddev *mddev, loff_t offset,
 			continue;
 
 		target = offset + index * (PAGE_SIZE/512);
+		target_size = min_t(u64, size, i_size_read(rdev->bdev->bd_inode) -
+			((target + rdev->sb_start) << 9));
+		target_size = roundup(target_size,
+			bdev_logical_block_size(rdev->bdev));
 
-		if (sync_page_io(rdev, target,
-				 roundup(size, bdev_logical_block_size(rdev->bdev)),
+		if (sync_page_io(rdev, target, target_size,
 				 page, REQ_OP_READ, 0, true)) {
 			page->index = index;
 			return 0;
