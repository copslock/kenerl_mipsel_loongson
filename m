Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Feb 2008 15:30:12 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:24994 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026846AbYBSPaK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Feb 2008 15:30:10 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1JFU9KT028891;
	Tue, 19 Feb 2008 15:30:10 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1JFU8WV028883;
	Tue, 19 Feb 2008 15:30:08 GMT
Date:	Tue, 19 Feb 2008 15:30:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Michael Buesch <mb@bu3sch.de>, linux-mips@linux-mips.org
Subject: Re: Linux MIPS PCI resource sanity check
Message-ID: <20080219153008.GA28788@linux-mips.org>
References: <200802161139.10791.mb@bu3sch.de> <47B6BFD4.5050404@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47B6BFD4.5050404@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 16, 2008 at 01:49:56PM +0300, Sergei Shtylyov wrote:

>   It makes sure that a PCI resource is allocated (base of 0 means that it's 
> unallocated due to previously detected resource conlict (or some other 
> reason).
>
>> It triggers for me on a BCM4318 device which is behind a BCM4710 PCI bridge.
>> r->start is 0 and r->end is 0x1FFF when this triggers.
>> If I simply comment out that check the device is detected correctly
>> and seems to initialize just fine.
>
>    No, that failnig resource should be relocated.

The resources were assigned during the PCI bus scan so at least with the
current implementation it's too late to reassign resources.  I get the
feeling this is an indication of a problem elsewhere.

  Ralf
