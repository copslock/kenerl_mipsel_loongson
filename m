Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2004 18:36:09 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:2805 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225998AbUENRgI>;
	Fri, 14 May 2004 18:36:08 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA19476;
	Fri, 14 May 2004 10:35:57 -0700
Message-ID: <40A5037E.907@mvista.com>
Date: Fri, 14 May 2004 10:35:58 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Tiwari, Rakesh" <Rakesh.Tiwari@idt.com>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Adding support for new BSP
References: <73943A6B3BEAA1468EE1A4A090129F43742771@corpbridge.corp.idt.com> <20040514173237.GA23561@linux-mips.org>
In-Reply-To: <20040514173237.GA23561@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Fri, May 14, 2004 at 10:06:16AM -0700, Tiwari, Rakesh wrote:
>
>  
>
>>We plan to add our (IDT) BSP (board support package) for evaluation boards
>>based on IDT 32 bit MIPS processors to the main mips-linux 2.6.x kernel.
>>
>>Can somebody please tell me the procedure/requirements to check-in the new
>>BSP files into the main kernel tree.
>>    
>>
>
>Send me a patch; cc'ing linux-mips can't harm.  I'll either apply or
>comment the patch.
>  
>
Take a look at the CodingStyle doc in the Documentation directory first. 
That will save you and Ralf sometime.

Pete
