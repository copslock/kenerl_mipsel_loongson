Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 19:59:19 +0000 (GMT)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:48584 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225413AbUA1T7R>;
	Wed, 28 Jan 2004 19:59:17 +0000
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 28 Jan 2004 11:59:12 -0800
Message-ID: <4018143B.9060902@avtrex.com>
Date: Wed, 28 Jan 2004 11:57:47 -0800
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: Daniel Jacobowitz <dan@debian.org>,
	Rajesh Palani <rpalani2@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: SoftFloat implementation for MIPS in GCC
References: <20040128192636.32578.qmail@web21603.mail.yahoo.com> <20040128193355.GA14318@nevyn.them.org> <20040128115312.B6210@mvista.com>
In-Reply-To: <20040128115312.B6210@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jan 2004 19:59:12.0992 (UTC) FILETIME=[336C8600:01C3E5D9]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:

>On Wed, Jan 28, 2004 at 02:33:55PM -0500, Daniel Jacobowitz wrote:
>  
>
>>On Wed, Jan 28, 2004 at 11:26:36AM -0800, Rajesh Palani wrote:
>>    
>>
>>>Hi,
>>> 
>>>   We are using a gcc 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1) GCC cross-compiler with -msoftfloat to use software floating point routines.
>>> 
>>>   When we profied an application using the Linux Trace Toolkit, we observed that  there were a lot of CpU (Co-processor unusable) exceptions.  Some of the floating point routines ( eg. __floatdidf) expect values to be passed in floating point registers and take FP exceptions even though the application has been built with -msoftfloat.  Is this a general MIPS/GCC issue?  What is the status of softfloat  for MIPS in GCC?
>>>      
>>>
>>Try a more recent compiler, that one is ancient.  If you configure
>>correctly, you should get no references to the floating point registers
>>at all.
>>
>>    
>>
>
>If glibc is not compiled with -msoftfloat, I think you will get a few
>FPU exceptions from glibc no matter how apps are compiled.  
>
>Actually, will it be a problem if glibc and apps are compiled differently
>(such as in longjump, sig handling area)?
>  
>
I have found that some versions of glibc (2.2.5 for example) have hard 
coded floating point code (in longjump handling IIRC) so no matter what 
you do you get the exceptions.

David Daney.
