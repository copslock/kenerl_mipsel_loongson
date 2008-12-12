Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2008 16:16:24 +0000 (GMT)
Received: from mail-bw0-f16.google.com ([209.85.218.16]:28048 "EHLO
	mail-bw0-f16.google.com") by ftp.linux-mips.org with ESMTP
	id S24207832AbYLLQQV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Dec 2008 16:16:21 +0000
Received: by bwz9 with SMTP id 9so4067003bwz.0
        for <linux-mips@linux-mips.org>; Fri, 12 Dec 2008 08:16:13 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=X34Dr6X7H3h7ekOQDmaal5hKhXWF3J4/y6Qc8Mwk/B0=;
        b=l1zJX+QFk6T7CALLbGlPMZW8gRU9ync+RgIrDp5X7JMMetIY3fhVBrMXO4QBHdi58v
         gXYHwid/W5CXQdpWamRuRDkhzbeOBSyjehMqky3wx5WUAOrZJKCSuVtLx+i7m5oCgOXL
         /qqSB/RLzhb2ztMmD1lOBceae2YC7my1AN3U8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=LZTN+wul4I5lwWK6YOJ0q4zCQmKYKHv/LUoRfEFIrla3UuJL7aa4gePW4sporG6b4D
         tuFVinTz3Jy64zUyuz8eZt/EjoDZwWZHLMmB9vbcBpKxvJSlneFSRNZws5DKDV3JxfSh
         xORzgMFKLNJGSJneDrUUkztRSPUL3MnkBksio=
Received: by 10.223.106.68 with SMTP id w4mr4357054fao.19.1229098568541;
        Fri, 12 Dec 2008 08:16:08 -0800 (PST)
Received: by 10.223.109.72 with HTTP; Fri, 12 Dec 2008 08:16:08 -0800 (PST)
Message-ID: <83f0348b0812120816p3d09ca8avafb7b9aca761b6e9@mail.gmail.com>
Date:	Fri, 12 Dec 2008 10:16:08 -0600
From:	"Ed Okerson" <ed.okerson@gmail.com>
To:	linux-mips@linux-mips.org
Subject: SPARSEMEM, HIGHMEM and the SMP8634
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <ed.okerson@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ed.okerson@gmail.com
Precedence: bulk
X-list: linux-mips

I am having great difficulty trying to get memory allocation from
DRAM1 on the Sigma SMP8634.  It seems that some hybrid between
SPARSEMEM and HIGHMEM would be needed.  I have read all the previous
threads on this topic, but it appears no one has been successful yet.

I am working with the 2.6.22.19 kernel (latest release from Sigma).
At this point, I have it kinda recognizing the memory:

On node 0 totalpages: 31712
  DMA zone: 1024 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 22496 pages, LIFO batch:3
  Normal zone: 0 pages used for memmap
  HighMem zone: 256 pages used for memmap
  HighMem zone: 7936 pages, LIFO batch:0
Built 1 zonelists.  Total pages: 30432

But the memory output from the end of mem_init() does not show it:

Memory: 82432k/94080k available (2856k kernel code, 11604k reserved,
468k data, 5932k init, 0k highmem)

On the kernel command line I am passing:

mem=92M mem=32M@0x26000000

Which, as I understand it, should give me 32M out of the bottom of the
128M on bank DRAM1.  The output of 'free' also does not indicate any
more memory than if I just pass 'mem=92M' to the kernel.

So what needs to be done to get the high memory added to usable
memory?  I think I have gone beyond my understanding of memory
management.  If the memory is in fact available, how can I tell, and
how can it be allocated for user space programs?

Ed Okerson
