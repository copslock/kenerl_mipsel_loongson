Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 13:11:46 +0000 (GMT)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:58756 "EHLO
	mail.dfpost.ru") by linux-mips.org with ESMTP id <S8225220AbULINLm>;
	Thu, 9 Dec 2004 13:11:42 +0000
Received: from toch.dfpost.ru (toch.dfpost.ru [192.168.7.60])
	by mail.dfpost.ru (Postfix) with SMTP id 9130C3E517
	for <linux-mips@linux-mips.org>; Thu,  9 Dec 2004 16:05:58 +0300 (MSK)
Date: Thu, 9 Dec 2004 16:12:07 +0300
From: Dmitriy Tochansky <toch@dfpost.ru>
To: linux-mips@linux-mips.org
Subject: mmap problem another :)
Message-Id: <20041209161207.39140f0d.toch@dfpost.ru>
Organization: Special Technology Center
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

Seems like I found problem.

Look ret = io_remap_page_range(start, offset, size, vma->vm_page_prot); remaps
from "offset" which I got from pci_resource_start (curdev, IOMEM0); its ok
from first board where it eq 0x40000000 but on second it 0x40002040

Then I'm reading from x = mmap (NULL, MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0); with
shift 0x3C>>2 where I expect board register. But for second board x points to where?
0x40000000 or 0x40002040 or as I think remap_page_range or sonething realign offset to 
PAGE so x points to 0x40002000 or 0x40003000 and reading with shift 0x3C have no sense.

Am I rigth?
