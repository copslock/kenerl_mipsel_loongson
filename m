Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f39AE2c01354
	for linux-mips-outgoing; Mon, 9 Apr 2001 03:14:02 -0700
Received: from mailgw3.netvision.net.il (mailgw3.netvision.net.il [194.90.1.11])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f39AE0M01351
	for <linux-mips@oss.sgi.com>; Mon, 9 Apr 2001 03:14:00 -0700
Received: from jungo.com ([194.90.113.98])
	by mailgw3.netvision.net.il (8.9.3/8.9.3) with ESMTP id NAA26539;
	Mon, 9 Apr 2001 13:12:07 +0300 (IDT)
Message-ID: <3AD18B4D.8070204@jungo.com>
Date: Mon, 09 Apr 2001 13:13:33 +0300
From: Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: David Jez <dave.jez@seznam.cz>
CC: Lisa.Hsu@taec.toshiba.com, linux-mips@oss.sgi.com
Subject: Re: ucLinux for MIPS
References: <OF82A2E51E.E2ACCD3B-ON88256A25.007F33AB@taec.toshiba.com> <20010408134919.A18546@stud.fee.vutbr.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

In uClinux mips/ subtree is pure 2.4.0, so I don't expect it to support 
any non-MMU architecture. On the other hand, you may try to write the 
support yourself. Take examples from armnommu/, which has been recently 
updated.


David Jez wrote:

>> Hi, All
> 
>   Hi Lisa,
> 
> 
>> Does anybody know where can I find the uCLinux release and patch  which
>> supports MIPS?    (The chip that I am using has MMU but is disabled)
>> 
>> Thanks,
> 
>   I find it here:
>   http://cvs.uclinux.org/cgi-bin/cvsweb/uClinux-2.4.x/arch/mips/
> 
>   (You can try download CVS verios of uClinux from cvs.uclinux.org or
> www.uclinux.org. It may supports MIPS architecture)
> 
> 
>> Lisa
> 
>   Best Regards,


-- 
Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
