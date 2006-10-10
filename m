Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 20:42:13 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:62535 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039915AbWJJTmM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Oct 2006 20:42:12 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 1B08E3ED5; Tue, 10 Oct 2006 12:41:52 -0700 (PDT)
Message-ID: <452BF775.6090504@ru.mvista.com>
Date:	Tue, 10 Oct 2006 23:41:41 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Dan Malek <dan@embeddedalley.com>
Cc:	Rodolfo Giometti <giometti@linux.it>, linux-mips@linux-mips.org
Subject: Re: Problem on au1100 USB device support
References: <20061010182747.GA14539@enneenne.com> <29381BAC-4A96-4BFE-8E86-836A3564F2F5@embeddedalley.com>
In-Reply-To: <29381BAC-4A96-4BFE-8E86-836A3564F2F5@embeddedalley.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Dan Malek wrote:

> The device interface just requires too much babysitting
> by the CPU to function, and the Linux interrupts
> have too much latency to guarantee the CPU can do
> what is necessary in a timely fashion.  The same is

    Note that AMD claims that the latency (and other) errata fixed in the late 
revs of their SOCs.
For Au1100, BE and BF revs are claimed to be errata-free.

WBR, Sergei
