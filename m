Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 11:46:14 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:58798 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S21468867AbYJNKqM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Oct 2008 11:46:12 +0100
Date:	Tue, 14 Oct 2008 11:46:12 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Weiwei Wang <weiwei.wang@windriver.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	weiwei wang <veivei.vang@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [Fwd: [bug report] 0xffffffffc0000000 can't be used on
 bcm1250]
In-Reply-To: <48F4706A.2010401@windriver.com>
Message-ID: <alpine.LFD.1.10.0810141131550.1618@ftp.linux-mips.org>
References: <48EC9894.4080201@gmail.com> <20081008115001.GA21596@linux-mips.org> <48ED5BA5.4070301@gmail.com> <20081009131554.GB22796@linux-mips.org> <48EEBFE8.1000501@gmail.com> <alpine.LFD.1.10.0810101138180.19747@ftp.linux-mips.org> <48F2BC15.70408@gmail.com>
 <alpine.LFD.1.10.0810131508390.9667@ftp.linux-mips.org> <20081013162906.GB7144@linux-mips.org> <alpine.LFD.1.10.0810131842430.9667@ftp.linux-mips.org> <48F3F499.3010508@windriver.com> <48F4706A.2010401@windriver.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 14 Oct 2008, Weiwei Wang wrote:

> I checked the sb-1 core user manual, and finally confirm the virtual
> address space is 44 bits wide, not 40 bits. so for function

 Lucky you to have access to this thing!  Anyway, Ralf has promised us a 
brand new wonderful alternative solution, so let's wait for that to happen 
first before fiddling with my proposal any further.  Thanks for the note 
though.

> But another issue is confusing me right now. Since the bit 44-61 in
> entryhi is not valid, and are read as 0,  so when issue command tlbwr,
> the cpu will copy the contents of EntryHi, EntryLo, and PageMask into
> the TLB entry, including the invalid bits in VPN2 of entryhi.  Here I
> think tlb entry conflict may appear. Take address 0xc0000fffc0000000 and
> 0xffffffffc0000000 for example, the two address may get the same tlb
> entry. am i getting it wrong? can you give me your understanding.

 If you have a close look at the MIPS64 architecture spec, then you'll 
notice that the last 2GB of the XKSEG space are reserved.  This is exactly 
so that the clash you are concerned about does not happen.  Any EntryHi 
value written with the value of R set to 0x3 and all the bits of VPN2 
starting from the most significant one down to the bit #31 set to 1 refers 
to the compatibility segment.

  Maciej
