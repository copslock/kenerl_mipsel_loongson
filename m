Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2009 16:03:20 +0000 (GMT)
Received: from gateway04.websitewelcome.com ([69.56.195.7]:32702 "HELO
	gateway04.websitewelcome.com") by ftp.linux-mips.org with SMTP
	id S28574525AbZCYQDO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Mar 2009 16:03:14 +0000
Received: (qmail 16908 invoked from network); 25 Mar 2009 16:04:00 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway04.websitewelcome.com with SMTP; 25 Mar 2009 16:04:00 -0000
Received: from [217.109.65.213] (port=2878 helo=[192.168.236.58])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1LmVZN-0000Pz-HY; Wed, 25 Mar 2009 11:03:09 -0500
Message-ID: <49CA55BD.6040704@paralogos.com>
Date:	Wed, 25 Mar 2009 11:03:09 -0500
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Alan Wu <alan.wu@mstarsemi.com>
CC:	linux-mips@linux-mips.org
Subject: Re: VPE loader support on 34K
References: <B34CE01D80AD4D309E259934BA1361AA@mstarsemi.com.tw>
In-Reply-To: <B34CE01D80AD4D309E259934BA1361AA@mstarsemi.com.tw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Alan Wu wrote:
> Hello,
>
> I'm porting 2.6.26 Linux on the platform of MIPS 34K. Currently, the uni-processor 
> kernel model(1 VPE) and SMP model (2 VPE) are up and work perfectly.
>
> Now, I need to port the AP/SP model on a normal Linux uniprocessor kernel model. 
> I'd like to load an application program (ELF ?) into kernel space where this 
> application will run on a Secondary VPE undisturbed by the Linux kernel.
>
> After I enabled the MIPS_VPE_LOADER [=y] in .config , the kernel is up without
> any error/warning message.
>
> Please help :
>
> 1. How to load the application into VPE1 from VPE0 ? (cat XYZapp >/dev/vpe1 ?)
>   
If I recall correctly, yes that's it.
> 2. Is there any sample "Hello World" application for this ? 
> 3. Any specific tool chain needed ?
>   
There was a sort of tool kit distributed by MIPS that provided examples, 
a minimal C runtime library, and tool settings for AP/SP (aka APRP).  
The binaries are ELF, but they aren't linked the way you'd link a 
userland program (they either need to be relocatable, or be linked to 
load at an appropriately high kernel segment address) and of course they 
can't use standard C libraries that do system calls, though there is the 
provision for open/close/read/write of files and devices via a Linux 
kernel server. I'm no longer working for MIPS, so I don't have my copy 
anymore, but I'd like to think that you could find a pointer to the tool 
kit and documentation somewhere on MIPS's web site.  And, as Ralf 
suggested (after I'd started typing this message, but before I got to 
the point of sending it) if you are a MIPS customer, or are a 
subcontractor to one, MIPS customer support should definitely be able to 
get you the necessary tool kit.


          Regards,

          Kevin K.
