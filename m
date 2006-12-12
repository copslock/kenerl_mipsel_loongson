Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2006 23:07:42 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47065 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S20037830AbWLLXHh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Dec 2006 23:07:37 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.8/8.13.4) with ESMTP id kBCNFeji021336;
	Tue, 12 Dec 2006 23:15:41 GMT
Date:	Tue, 12 Dec 2006 23:15:40 +0000
From:	Alan <alan@lxorguk.ukuu.org.uk>
To:	ashlesha@kenati.com
Cc:	linux-mips@linux-mips.org
Subject: Re: 8250 Flag definitions
Message-ID: <20061212231540.4dad65e1@localhost.localdomain>
In-Reply-To: <1165954142.6539.1.camel@sandbar.kenati.com>
References: <1165954142.6539.1.camel@sandbar.kenati.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Tue, 12 Dec 2006 12:09:02 -0800
Ashlesha Shintre <ashlesha@kenati.com> wrote:

> Hi,
> 
> Is there a document that outlines the meaning of these flags in the 8250
> serial driver?

Try include/linux/serial.h - each ASYNC_ entry has a comment explaining
what it does, and that covers your UP_ stuff fairly completely.
