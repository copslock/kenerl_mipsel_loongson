Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6AHvLN00376
	for linux-mips-outgoing; Tue, 10 Jul 2001 10:57:21 -0700
Received: from snfc21.pbi.net (mta5.snfc21.pbi.net [206.13.28.241])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6AHvKV00373
	for <linux-mips@oss.sgi.com>; Tue, 10 Jul 2001 10:57:20 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta5.snfc21.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GG900ICMR7JN1@mta5.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Tue, 10 Jul 2001 10:57:19 -0700 (PDT)
Date: Tue, 10 Jul 2001 10:55:53 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: Re: MIPS Cross Compiler Tools
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Reply-to: ppopov@pacbell.net
Message-id: <3B4B41A9.3010304@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
References: <25369470B6F0D41194820002B328BDD27D22@ATLOPS>
 <3B4B2FA6.4080508@pacbell.net> <994784982.9191.1.camel@localhost.localdomain>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Marc Karasek wrote:

> Will these be in the form of rpms or tgz files??  


rpm

In the case of rpm do
> you know if they would be package similar to the ones on oss.sgi.com?


I'm not sure how the oss.sgi.com tools are packaged. The MontaVista 
release gets installed in /opt/hardhat/<....>. The 
/opt/hardhat/devkit/mips/fp<le|be>/target is the root fs that gets 
mounted over nfs. The target root fs has all the userland apps and 
native tools. The /opt/hardhat/devkit/mips/fp_<le|be>/bin has the cross 
tools.


> ie Setup for a crossdev enviroment.  I just really need the cross tools
> as the dev is on an embedded system, with no harddrive.  


That's what we work with mostly as well.

> The userland
> stuff is pretty worthless to me.  I will be using busybox, tinylogin,
> etc. for the standard bin utilities.  


OK, but we have all of those packaged in rpm as well, and it's very easy 
to rebuild the rpms from the source rpms, if you need to rebuild them.

Pete

> Having a few megabytes to store
> everything in makes you very sensitive to size.... :-)
> 
> Thanks for the quick response...    
> 
> On 10 Jul 2001 09:39:02 -0700, Pete Popov wrote:
> 
>>Marc Karasek wrote:
>>
>>
>>>I had a question about the cross compiler tools for MIPS, specifically
>>>glibc.  I d/l the rpms from oss.sgi.com,  but they are only binutils, and
>>>the compiler (C, C++).  
>>>
>>>Are most people building glibc against these or are you building the tools
>>>completely from scratch?  As glibc is needed to compile anything else other
>>>than the kernel. 
>>>
>>Friday or Monday MontaVista should have the HHL2.0 Journeyman mips 
>>release on the ftp site which will include the userland apps, cross AND 
>>native tools, etc.  The tools and glibc are very up to date. I would 
>>suggest checking Monday for the release and using that instead of 
>>building your own.
>>
>>Pete
>>
> --
> /*************************
> Marc Karasek
> Sr. Firmware Engineer
> iVivity Inc.
> marc_karasek@ivivity.com
> (770) 986-8925
> (770) 986-8926 Fax
> *************************/
> 
> 
