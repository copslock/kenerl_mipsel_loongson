Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 May 2006 19:59:04 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:31818 "EHLO
	smtp2.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S8133915AbWERR6z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 May 2006 19:58:55 +0200
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by smtp2.caviumnetworks.com with NetIQ MailMarshal (v6,0,3,8)
	id <B446cb5cd0000>; Thu, 18 May 2006 13:58:37 -0400
Received: from [192.168.16.29] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 18 May 2006 10:58:48 -0700
Message-ID: <446CB5D8.107@caviumnetworks.com>
Date:	Thu, 18 May 2006 10:58:48 -0700
From:	Chad Reese <kreese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20060422 Debian/1.7.8-1sarge5
X-Accept-Language: en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Any examples / docs for getting SPARSEMEM to work?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 May 2006 17:58:48.0436 (UTC) FILETIME=[B6A88340:01C67AA4]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kreese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Hello All,

I've spent the last few days trying to get SPARSEMEM to work on a 64bit Mips 
kernel. The processor I'm using has large wholes in its memory map.

Memory layout:
0 - 0x10000000			First 256MB
0x410000000 - 0x420000000 	Second 256MB
0x20000000 - ? 			The rest of memory

Up until now I've used the flat memory model and not mapped the 2nd 256MB. This 
is rather wasteful for boards with 512MB of memory. SPARSEMEM look like what I 
need, but I've been unable to get it working. My attempts to configure it always
end with sparse_index_alloc calling alloc_bootmem_node which fails to allocate 
4KB. In prom_init I've added memory using add_memory_region.

Are there any reasonably easy to follow implementations of sparsemem? I figure 
I'm missing something very basic, but perusal of Mips and the other 
architectures haven't helped much.

My baseline is linux-mips 2.6.14.

Any help would be appreciated,

Chad

-- 

Chad Reese <kreese@caviumnetworks.com>
Cavium Networks
