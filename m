Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2O0GCq14047
	for linux-mips-outgoing; Fri, 23 Mar 2001 16:16:12 -0800
Received: from clrsrv1.clearcore.com (@www.clearcore.com [208.141.182.168])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2O0GBM14044
	for <linux-mips@oss.sgi.com>; Fri, 23 Mar 2001 16:16:11 -0800
Received: from clearcore.net (nephi.clearcore.com [192.168.3.3])
	by clrsrv1.clearcore.com (8.10.1/8.10.1) with ESMTP id f2O0Fjd26311;
	Fri, 23 Mar 2001 17:15:45 -0700
Message-ID: <3ABBE6BC.1040005@clearcore.net>
Date: Fri, 23 Mar 2001 17:13:48 -0700
From: Joe George <joeg@clearcore.net>
Organization: ClearCore
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010321
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Dharm <mdharm@momenco.com>
CC: carlson@sibyte.com, linux-mips@oss.sgi.com
Subject: Re: Multiple processor support?
References: <NEBBLJGMNKKEEMNLHGAIKELLCAAA.mdharm@momenco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Unfortunately the RM7000 does not have hardware cache coherency
support.

Joe George

Matthew Dharm wrote:

> Well, I'd like to know about both, frankly.  Tho I'm more interested
> in whichever is designed to run on RM7000 series processors.
> 
> Matt
> 
> --
> Matthew D. Dharm                            Senior Software Designer
> Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
> (760) 431-8663 X-115                        Carlsbad, CA 92008-7310
> Momentum Works For You                      www.momenco.com
> 
> 
>> -----Original Message-----
>> From: Justin Carlson [mailto:carlson@sibyte.com]
>> Sent: Friday, March 23, 2001 2:58 PM
>> To: Matthew Dharm
>> Cc: linux-mips@oss.sgi.com
>> Subject: Re: Multiple processor support?
>> 
>> 
>> On Fri, 23 Mar 2001, you wrote:
>> 
>>> Does the MIPS port of linux support multiple-processor
>> 
>> architectures?
>> 
>> MIPS or MIPS64?
>> 
>> -Justin
>> 
>> 
