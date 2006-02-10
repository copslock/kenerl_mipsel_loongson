Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2006 15:52:44 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38310 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S3467599AbWBJPwg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Feb 2006 15:52:36 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id k1AG169K013129;
	Fri, 10 Feb 2006 16:01:06 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id k1AG13n2013128;
	Fri, 10 Feb 2006 16:01:03 GMT
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: changing the page properties to cached/uncached
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	pulsar@kpsws.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <13126.194.171.252.101.1139502756.squirrel@mail.kpsws.com>
References: <20060210.005104.63742308.anemo@mba.ocn.ne.jp>
	 <13126.194.171.252.101.1139502756.squirrel@mail.kpsws.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Fri, 10 Feb 2006 16:01:02 +0000
Message-Id: <1139587262.12521.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Iau, 2006-02-09 at 17:32 +0100, Niels Sterrenburg wrote:
> - Do not use swapping in the system
> - Limit Linux memory usage via the mem= option in the kernel command line.
> - From MIPS user space: do a mmap for the shared memory area.
> - From MIPS user space: call (our selfwritten) shmemipc driver with the
> request to set the mapped pages to cached (by passing virtual address and
> length).
> - From kernel space: find the vma for the supplied virtual address range
> and change cache properties of all pages in that virtual range.

You don't need to worry about swapping. You can simply mark the pages in
question reserved just as i386 does with the 640K-1Mb hole or since when
a page has a use count it won't swap out, mark it as having a user. In
your case the "user" is the DSP so you just need to account fine

> - As we mmap outside the kernel sdram (<48MB), mmap creates new pages
> which are initialized to uncached, e.g. it assumes I/O)

You can provide your own "nopage" method. Good example is
sound/oss/via82cxxx_audio.c 
