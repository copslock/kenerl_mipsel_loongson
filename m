Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g24L8Bc26174
	for linux-mips-outgoing; Mon, 4 Mar 2002 13:08:11 -0800
Received: from ayrnetworks.com (64-166-72-137.ayrnetworks.com [64.166.72.137])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g24L89926171
	for <linux-mips@oss.sgi.com>; Mon, 4 Mar 2002 13:08:09 -0800
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g24K83S03332
	for linux-mips@oss.sgi.com; Mon, 4 Mar 2002 12:08:03 -0800
Date: Mon, 4 Mar 2002 12:08:03 -0800
From: William Jhun <wjhun@ayrnetworks.com>
To: linux-mips@oss.sgi.com
Subject: Compressed images?
Message-ID: <20020304120803.A1247@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've been looking through the recent linux-mips archives and it seems
there isn't a concensus about where to build compressed ((b)zImage)
images. We have been placing our code under arch/mips/boot/compressed,
though it seems that the latest oss tree doesn't have such a directory,
and the only reference I can find to building a compressed image is in
galileo-boards/ev64120/compressed/.

Should we be placing our boot image compression stuff in our
platform-specific directory? Are most MIPS-based Linux platforms not
using compressed images?

Thanks,
Will
