Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 18:46:50 +0000 (GMT)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:13328 "EHLO
	smtp2.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23819802AbYKUSqm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Nov 2008 18:46:42 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by smtp2.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492702060000>; Fri, 21 Nov 2008 13:46:30 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 21 Nov 2008 10:43:46 -0800
Received: from [192.168.162.106] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 21 Nov 2008 10:43:46 -0800
Message-ID: <4927015E.6080205@caviumnetworks.com>
Date:	Fri, 21 Nov 2008 10:43:42 -0800
From:	Chad Reese <kreese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.14eol) Gecko/20070505 Iceape/1.0.9 (Debian-1.0.13~pre080323b-0etch3)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
References: <49261BE5.2010406@caviumnetworks.com> <4926E467.9020305@ru.mvista.com> <4926EFEE.2010701@caviumnetworks.com> <4926FA97.201@ru.mvista.com>
In-Reply-To: <4926FA97.201@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2008 18:43:46.0260 (UTC) FILETIME=[15E64940:01C94C09]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kreese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
>> We need to be careful not to be anti-social by filling the FIFO.  Once 
>> the FIFO is filled other cores will be starved of I/O resources.
> 
>     It's not the first time I'm seeing this driver, so I'm familiar with the 
> trick. Altho I didn't realize that this abuses the shared write buffer.

There is a FIFO between the bootbus and the cores separate from the
normal Octeon per core write buffer. This fifo is shared will all other
cores and IO units for bootbus access. If the fifo overflows then IOs
other than the bootbus are affected.

Chad
