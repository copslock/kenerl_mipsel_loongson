Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4A91RA27342
	for linux-mips-outgoing; Thu, 10 May 2001 02:01:27 -0700
Received: from mailgw1.netvision.net.il (mailgw1.netvision.net.il [194.90.1.14])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4A91PF27338
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 02:01:26 -0700
Received: from jungo.com ([194.90.113.98])
	by mailgw1.netvision.net.il (8.9.3/8.9.3) with ESMTP id MAA07506;
	Thu, 10 May 2001 12:01:18 +0300 (IDT)
Message-ID: <3AFA58B6.7010806@jungo.com>
Date: Thu, 10 May 2001 12:00:38 +0300
From: Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Nguyen <tnguyen@drawbridge3.simpletech.com>
CC: linux-mips@oss.sgi.com
Subject: Re: MIPS 5Kc
References: <4.3.2.7.2.20010509095019.00a90830@sti-sun4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Tim Nguyen wrote:

> Hello all,
> 
> Does anybody have any comments concerning the Alta board with a MIPS 5Kc 
> running Linux.  I hear that Linux modules aren't fully supported in 
> their reference 2.2.12 kernel.  Are there any other known issues with 
> that kernel -- how about the 2.4.1 kernel?  Any help will be greatly 
> appreciated.
> Regards,
> Tim Nguyen

Tim,

The kernel 2.2.12 form mips' ftp site has no modules support at all. The 
problem may be coming from the binutils bugs that were used to create 
the kernel image, which is 2.8.1 which reportedly (at least from our 
company) do not produce usable 'insmod'. It is not 5Kc - related stuff, 
we have several boards with such processors (including Malta and Atlas) 
and all of them exibited module problems with "old" toolchain (binutils 
2.8.1 - egcs 1.0.3a - glibc 2.0.6).

Newer kernel 2.4.x is also available from mips' ftp site, but we haven't 
checked it out yet.

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
