Received:  by oss.sgi.com id <S553926AbRAKHa6>;
	Wed, 10 Jan 2001 23:30:58 -0800
Received: from [194.90.113.98] ([194.90.113.98]:516 "EHLO yes.home.krftech.com")
	by oss.sgi.com with ESMTP id <S553915AbRAKHaj>;
	Wed, 10 Jan 2001 23:30:39 -0800
Received: from jungo.com (kobie.home.krftech.com [199.204.71.69])
	by yes.home.krftech.com (8.8.7/8.8.7) with ESMTP id KAA00736;
	Thu, 11 Jan 2001 10:34:17 +0200
Message-ID: <3A5D609C.2080201@jungo.com>
Date:   Thu, 11 Jan 2001 09:28:28 +0200
From:   Michael Shmulevich <michaels@jungo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
CC:     busybox@opensource.lineo.com,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: [BusyBox] 0.48 - Can't mount /proc
References: <3A5CAC53.60700@jungo.com> <20010110122159.A24714@lineo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Erik,

No, doesn't help.

bash# mount proc /proc -t proc                                          
       
mount: Mounting proc on /proc failed: Unknown error 716878944           
       

Maybe people in mips-linux know something about this?


Erik Andersen wrote:

> On Wed Jan 10, 2001 at 08:39:15PM +0200, Michael Shmulevich wrote:
> 
>> Hello,
>> 
>> This is my first mail to this list, but I have already seen similar 
>> question being unanswered.
>> I am developing an embedded system based on MIPS board. I am 
>> cross-compiling the BusyBox 0.48 on x86 with gcc 2.90.29 (egcs 1.0.3a).
>> 
>> While trying to mount /proc either atomatically in script or by hand, 
>> the command fails with following message:
>> 
>> bash# mount /proc -t proc
>> mount: Mounting none on /proc failed: Unknown error 716878944
> 
> 
> mount proc /proc -t proc
> 
>  -Erik
> 
> --
> Erik B. Andersen   email:  andersen@lineo.com
> --This message was written using 73% post-consumer electrons--
