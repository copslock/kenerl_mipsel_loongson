Received:  by oss.sgi.com id <S42332AbQFTRNh>;
	Tue, 20 Jun 2000 10:13:37 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:52079 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42328AbQFTRN0>; Tue, 20 Jun 2000 10:13:26 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA09016
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 10:18:33 -0700 (PDT)
	mail_from (bh40@calva.net)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA94439
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Jun 2000 10:12:52 -0700 (PDT)
	mail_from (bh40@calva.net)
Received: from [62.161.177.33] (mailhost.mipsys.com [62.161.177.33]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA09483
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jun 2000 10:12:47 -0700 (PDT)
	mail_from (bh40@calva.net)
Received: from [192.168.1.19] by [192.168.1.2]
     with SMTP (QuickMail Pro Server for Mac 2.0); 20 JUN 00 15:32:09 UT
From:   Benjamin Herrenschmidt <bh40@calva.net>
To:     De Schrijver Peter <schrijvp@rc.bel.alcatel.be>
Cc:     Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>
Subject: Re: Proposal: non-PC ISA bus support
Date:   Tue, 20 Jun 2000 15:30:01 +0200
Message-Id: <20000620133001.23202@mailhost.mipsys.com>
In-Reply-To: <20000620152509.O1177@rc.bel.alcatel.be>
References: <20000620152509.O1177@rc.bel.alcatel.be>
X-Mailer: CTM PowerMail 3.0.3 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jun 20, 2000, De Schrijver Peter <schrijvp@rc.bel.alcatel.be> wrote:

>> We still can decide (and that's what I currently do in the kernel) that
>> IO space is only supported on one of those 3 busses (the one on which the
>> external PCI is). This prevents however use of IOs on the AGP slot, which
>> is a problem for things like XFree who may try to use VGA addresses on
>> the card.
>> 
>
>Is this really a problem ? I would expect AGP cards to be fully
>addresseable via 
>the I/O space assigned in the PCI IO resource base ?

But even that doesn't work. If it's a kernel driver, then we can fixup
the io resources passed by the new kernel resources mecanism to handle
the IO base of this specific card. But this won't for userland.

I mean, if you read the PCI IO resource base from the card's config
space, then you have an IO address on which you need to add an iobase
(the base at which the IO bus is mapped). The problem is how to figure
out this IO base, especially since the machine has several IO busses at
different addresses, but all of them on the same PCI bus number (it's
actually 3 separate busses with the same bus number).

The kernel can figure this out from the dev_fn since there's fortunately
no overlap of dev_fn's between those busses. But how to translate this to
userland ?

Ben.
