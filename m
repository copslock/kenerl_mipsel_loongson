Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 07:29:34 +0000 (GMT)
Received: from bay15-f22.bay15.hotmail.com ([IPv6:::ffff:65.54.185.22]:31180
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8224942AbULHH33>; Wed, 8 Dec 2004 07:29:29 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Tue, 7 Dec 2004 23:29:01 -0800
Message-ID: <BAY15-F22AE91D0812E86B5F51579AFB60@phx.gbl>
Received: from 82.200.0.252 by by15fd.bay15.hotmail.msn.com with HTTP;
	Wed, 08 Dec 2004 07:28:30 GMT
X-Originating-IP: [82.200.0.252]
X-Originating-Email: [alexshinkin@hotmail.com]
X-Sender: alexshinkin@hotmail.com
From: "Alexey Shinkin" <alexshinkin@hotmail.com>
To: toch@dfpost.ru
Cc: linux-mips@linux-mips.org
Subject: Re: mmap problem
Date: Wed, 08 Dec 2004 13:28:30 +0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 08 Dec 2004 07:29:01.0439 (UTC) FILETIME=[9691D8F0:01C4DCF7]
Return-Path: <alexshinkin@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexshinkin@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi !

On Au1550 code like yours works

I use ioremap_nocache(PhysAddr,length)  to get access from kernel level.

For access from  userland I don't set any vm_flags in drivers' mmap() ,
  vma->vm_flags is set by kernel to  0x40FB (VM_IO is set and VM_LOCKED 
isn't).

And , as Dan said , pci_resource_* functions used for getting valid PCI 
memory address

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
