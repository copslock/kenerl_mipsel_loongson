Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2004 14:02:16 +0100 (BST)
Received: from [IPv6:::ffff:212.80.76.43] ([IPv6:::ffff:212.80.76.43]:9659
	"HELO smtp.seznam.cz") by linux-mips.org with SMTP
	id <S8224787AbUJRNCK>; Mon, 18 Oct 2004 14:02:10 +0100
Received: (qmail 2369 invoked from network); 18 Oct 2004 12:25:50 -0000
Received: from unknown (HELO umax645sx) (Ladislav.Michl@62.77.73.201)
  by smtp.seznam.cz with SMTP; 18 Oct 2004 12:25:50 -0000
Received: from ladis by umax645sx with local (Exim 3.36 #1 (Debian))
	id 1CJWbK-0003Zw-00; Mon, 18 Oct 2004 14:26:58 +0200
Date: Mon, 18 Oct 2004 14:26:57 +0200
To: Alexey Shinkin <alexshinkin@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Question on Au1550 ...
Message-ID: <20041018122657.GA13718@umax645sx>
References: <BAY15-F37yRLVbNDN4C0000d65e@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY15-F37yRLVbNDN4C0000d65e@hotmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 18, 2004 at 07:01:30PM +0700, Alexey Shinkin wrote:
[snip]
> What I have  tried :
>     - to insert   vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot)
> in driver?s implementation of mmap() ;
>   -  to use  remap_page_range() instead of vm_ops .

Did you SetPageReserved bit?

	ladis
