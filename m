Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49C7gD21884
	for linux-mips-outgoing; Wed, 9 May 2001 05:07:42 -0700
Received: from mailgw2.netvision.net.il (mailgw2.netvision.net.il [194.90.1.9])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49C7eF21881
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 05:07:40 -0700
Received: from jungo.com ([194.90.113.98])
	by mailgw2.netvision.net.il (8.9.3/8.9.3) with ESMTP id PAA13119;
	Wed, 9 May 2001 15:05:49 +0300 (IDT)
Message-ID: <3AF93224.6080304@jungo.com>
Date: Wed, 09 May 2001 15:03:48 +0300
From: Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4.4: mmap() fails for certain legal requests
References: <Pine.GSO.3.96.1010508235846.4713H-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

As a side question: does this patch apply to 2.2.x kernel too?

While working on ld.so.1-9 port on MIPS I seen there's a try to mmap() 
some address > 0x80000000 which fails due to the same 
if(...TASK_SIZE...) mentioned in the patch.

Just wondering if this applies to me too :-)

Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
