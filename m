Received:  by oss.sgi.com id <S42403AbQIOX3l>;
	Fri, 15 Sep 2000 16:29:41 -0700
Received: from u-214.karlsruhe.ipdial.viaginterkom.de ([62.180.19.214]:44553
        "EHLO u-214.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42366AbQIOX3R>; Fri, 15 Sep 2000 16:29:17 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868897AbQIOX2y>;
        Sat, 16 Sep 2000 01:28:54 +0200
Date:   Sat, 16 Sep 2000 01:28:54 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: trap handler for unaligned memory read/write
Message-ID: <20000916012853.A16047@bacchus.dhis.org>
References: <39C29018.9389FBCE@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39C29018.9389FBCE@mvista.com>; from jsun@mvista.com on Fri, Sep 15, 2000 at 02:09:44PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Sep 15, 2000 at 02:09:44PM -0700, Jun Sun wrote:

> I was trying to run some PCI ether drivers and always got bus error, at
> least when I use ipconfig bootp code.
> 
> However, the problem seems to be generic.
> 
> Ethernet device writes a whole packet in the memory.  Driver and network
> stack code often directly dereference a pointer in to the packet. 
> However, the ether header is 14 byte long.  If you align packet from the
> beginning, then IP header will be off-aligned.
> 
> Any suggestions?

The strategy is to get the alignment right for the IP header, that is
to make the received packet start on a address with bit 1 set.

> If this is a valid problem, I think the long term solution should be in
> network code, which should not assume they can dereference on an
> unaligned address.

It tries to avoid unaligned accesses - if necessary even at the price of
wasting some memory.

> For short-term solutions, we can have trap handler that supports the
> unaligned read/write.  Does anybody know if there is such a trap handler
> for MIPS?

It's right there in your kernel ...

You _really_ _really_ want to avoid relying on the unaligned trap handler.
Performancewise that's equivalent to a swapping on a floppy disk on the
Mars over NFS via avian carriers ...

However unaligned accesses will result in an address error exception not
bus error therefore I suspect you've got another problem.

  Ralf
