Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5PE4Sh31281
	for linux-mips-outgoing; Mon, 25 Jun 2001 07:04:28 -0700
Received: from dea.waldorf-gmbh.de (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id f5PE4RV31277
	for <linux-mips@oss.sgi.com>; Mon, 25 Jun 2001 07:04:27 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5P6sxG01285;
	Mon, 25 Jun 2001 08:54:59 +0200
Date: Mon, 25 Jun 2001 08:54:59 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Raghav P <raghav@ishoni.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: KSEG2 Segment not used on Linux?
Message-ID: <20010625085459.B1220@bacchus.dhis.org>
References: <E0FDC90A9031D511915D00C04F0CCD2503999D@leonoid.in.ishoni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E0FDC90A9031D511915D00C04F0CCD2503999D@leonoid.in.ishoni.com>; from raghav@ishoni.com on Thu, Jun 21, 2001 at 08:08:06PM +0530
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jun 21, 2001 at 08:08:06PM +0530, Raghav P wrote:

> From: "Raghav P" <raghav@ishoni.com>
> To: <owner-linux-mips@oss.sgi.com>
       ^^^^^^^^^^^^^^^^

Don't send email to the owner address - it may stay unread forever!

> Is KSEG2 used on Linux ports for R2300?

Yes, ioremap and kernel modules use that address space on all 32-bit kernels.

> Also does Linux recognise physical memory more than 512MB on MIPS system? Is
> there any equivalent of highmem for MIPS?

Not yet.

  Ralf
