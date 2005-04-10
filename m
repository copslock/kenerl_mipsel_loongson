Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Apr 2005 23:16:42 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.206]:39925 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225999AbVDJWQY>;
	Sun, 10 Apr 2005 23:16:24 +0100
Received: by wproxy.gmail.com with SMTP id 57so1072820wri
        for <linux-mips@linux-mips.org>; Sun, 10 Apr 2005 15:16:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Jb76gL8cgOFLhEQdkLO4JehHLq5lHxPmanN5japzh7zyTlJ60EoSpHjSeVrKkq+YxTaJ7iyavk1bHZytnY9RxVIdofkz1kmO+piiV9fghYBejp3TqBJjecLlfl465rD59jhDv9w3+UDDM+2H9CFlIPKmy5HpOtGXTl8envK7njo=
Received: by 10.54.24.9 with SMTP id 9mr417108wrx;
        Sun, 10 Apr 2005 15:16:17 -0700 (PDT)
Received: by 10.54.41.29 with HTTP; Sun, 10 Apr 2005 15:16:17 -0700 (PDT)
Message-ID: <ecb4efd10504101516482a9785@mail.gmail.com>
Date:	Sun, 10 Apr 2005 18:16:17 -0400
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: troubles mmaping PCI device on Au1550
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

I'm working on a Au1550 driver for a PCI based co-processor. The
processor exports a 4Mbyte BAR that I want to mmap() into user space.
From inside the driver I can read and write to the BAR using an
address from ioremap_nocache(). I can read location with known values
and get back the expected data and with JTAG on the co-processor I saw
that data written from the 1550 really makes it into the PCI device.
From userspace with the llseek/read interface I can read the data well
known data and the data written by the driver.

However, I'm not having any luck getting mmap() to work. I must just
be mapping the wrong address... I tried a bunch of different
combinations of addresses, but so far I haven't had any luck getting
the mmap() to work.

The mmap() handler calls remap_pfn_range with a physical address
returned from pci_resource_start().

My driver code has something like:
remap_pfn_range ( vma, vma->vm_start,
     ( pci_resource_start ( pdev, BAR ) >> PAGE_SHIFT ) + vma->pgoff,
     vma->vm_end - vma->vm_start, vma->vm_page_prot );

vma->pgoff is zero, so this should map starting at the beginning of
the BAR. From user space, the data at the mmap()ed address isn't what
I was expecting.

For a sanity check, I tried using /dev/mem to mmap the PCI address as
returned by lspci. This seems to return similar, but not identical
data as my device driver. But it isn't what I was expecting.

I tried a similar test using /dev/mem and the address the linear
framebuffer on my desktop machine (as returned by lspci). The mapped
data matches the pixels on the first line (as reported by xmag).

Has anyone tried something like this on the Alchemy processors with a
recent kernel?

                          Many thanks,
                          Clem Taylor
