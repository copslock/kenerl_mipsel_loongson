Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 May 2006 20:07:36 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:6731 "EHLO
	smtp2.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S8133916AbWERSH2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 May 2006 20:07:28 +0200
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by smtp2.caviumnetworks.com with NetIQ MailMarshal (v6,0,3,8)
	id <B446cb7ce0000>; Thu, 18 May 2006 14:07:10 -0400
Received: from [192.168.16.29] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 18 May 2006 11:07:21 -0700
Message-ID: <446CB7D9.9030906@caviumnetworks.com>
Date:	Thu, 18 May 2006 11:07:21 -0700
From:	Chad Reese <creese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20060422 Debian/1.7.8-1sarge5
X-Accept-Language: en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Any examples / docs for getting SPARSEMEM to work? (2nd try)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 May 2006 18:07:21.0473 (UTC) FILETIME=[E873BF10:01C67AA5]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: creese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Looks like my first attempt fail. If not, sorry for the duplicate.

---

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

Chad Reese <creese@caviumnetworks.com>
Cavium Networks
