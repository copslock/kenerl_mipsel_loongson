Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2008 00:05:21 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:12944 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23664315AbYKNAFT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Nov 2008 00:05:19 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CB5963ECC; Thu, 13 Nov 2008 16:05:14 -0800 (PST)
Message-ID: <491CC0B6.8020400@ru.mvista.com>
Date:	Fri, 14 Nov 2008 03:05:10 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-kernel@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] New IDE/block driver for OCTEON SOC Compact Flash interface.
References: <491C7F28.2070507@caviumnetworks.com>
In-Reply-To: <491C7F28.2070507@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Daney wrote:

> As part of our efforts to get the Cavium OCTEON processor support
> merged (see: http://marc.info/?l=linux-mips&m=122600487218824), we
> have this CF driver for your consideration.
>
> Most OCTEON variants have *no* DMA or interrupt support on the CF
> interface so a simple bit-banging approach is taken.  Although if DMA is
> available, we do take advantage of it.
>
> The register definitions are part of the chip support patch set
> mentioned above, and are not included here.
>
> At this point I would like to get feedback as to whether this is a
> good approach for the CF driver, or perhaps generate ideas about other
> possible approaches.

   It's totally unacceptable for drivers/ide/ as this is self-containeed 
driver no using IDE core for anything, so this can only fit well to 
drivers/block/.
OTOH, CF support via self-contained driver is certainly a waste of code 
since IDE core and (libata) are here to drive the CF devices as well. 
What we need is a "normal" IDE or libata (at your option) driver.

WBR, Sergei
