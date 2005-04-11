Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 05:08:26 +0100 (BST)
Received: from bay15-f5.bay15.hotmail.com ([IPv6:::ffff:65.54.185.5]:58183
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8224936AbVDKEIL>; Mon, 11 Apr 2005 05:08:11 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Sun, 10 Apr 2005 21:08:04 -0700
Message-ID: <BAY15-F564283E78372BB36A999AAF320@phx.gbl>
Received: from 82.200.0.252 by by15fd.bay15.hotmail.msn.com with HTTP;
	Mon, 11 Apr 2005 04:08:03 GMT
X-Originating-IP: [82.200.0.252]
X-Originating-Email: [alexshinkin@hotmail.com]
X-Sender: alexshinkin@hotmail.com
In-Reply-To: <20050410230001Z8226002-1340+5508@linux-mips.org>
From:	"Alexey Shinkin" <alexshinkin@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: RE: troubles mmaping PCI device on Au1550
Date:	Mon, 11 Apr 2005 11:08:03 +0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 11 Apr 2005 04:08:04.0228 (UTC) FILETIME=[0F227440:01C53E4C]
Return-Path: <alexshinkin@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexshinkin@hotmail.com
Precedence: bulk
X-list: linux-mips


>Has anyone tried something like this on the Alchemy processors with a
>recent kernel?
>
>                           Many thanks,
>                           Clem Taylor

Hi !
Something like this works  on Au1550 with montavista kernel 2.4.20 . Dont 
know about more recent...

I use the followinng in  drivers'  mmap() :

vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
remap_page_range(... , vma->vm_page_prot)

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
