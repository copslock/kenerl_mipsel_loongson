Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2005 02:48:43 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:62915 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225271AbVAXCsh>; Mon, 24 Jan 2005 02:48:37 +0000
Received: from localhost ([127.0.0.1])
	by real.realitydiluted.com with esmtp (Exim 4.34 #1 (Debian))
	id 1CsuHI-0005tB-FN; Sun, 23 Jan 2005 20:48:32 -0600
Message-ID: <41F46372.3010906@realitydiluted.com>
Date:	Sun, 23 Jan 2005 20:54:42 -0600
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To:	Manish Lachwani <m_lachwani@yahoo.com>
CC:	Manish Lachwani <mlachwani@mvista.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] Support for backplane on TX4927 based board
References: <20050123033553.6917.qmail@web52809.mail.yahoo.com>
In-Reply-To: <20050123033553.6917.qmail@web52809.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Manish Lachwani wrote:
> Hi Steve,
> 
> Thanks for applying the PCI patch. 
> 
> This patch is complete as well. This file
> "arch/mips/tx4927/common/tx4927_setup.c" already
> exists in CVS and this specific change below removes a
> couple of lines from the file (uneeded lines). What
> part of the patch is missing? 
> 
That's what I was clarifying. I will let Ralf apply this patch
since I did not do a good job on the last one.

-Steve
