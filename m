Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2004 17:53:34 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:49143 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224950AbUGUQxa>;
	Wed, 21 Jul 2004 17:53:30 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA15712;
	Wed, 21 Jul 2004 09:53:25 -0700
Message-ID: <40FE9F7F.6040101@mvista.com>
Date: Wed, 21 Jul 2004 09:53:19 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Srinivas JT." <srinivasjt@esntechnologies.co.in>
CC: linux-mips@linux-mips.org
Subject: Re: Error :Nomatch found in TLB ?????
References: <4EE0CBA31942E547B99B3D4BFAB34811067510@mail.esn.co.in>
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811067510@mail.esn.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Srinivas JT. wrote:

>Dear All,
>I am very new to this group.
>I tried to load my .serc file into my Db1500 SDB. The steps that I followed are,
>
>1) I wrote a filein C(Linux).
>2) I generated an object file using gcc.
>3) By using objcopy I converted my obj file into srec file.
>4) Then I tried to download my srec file into Db1500 SDB in Yamon using tftp.
>
>then I got error as,
>
>Error: No match in TLB for mapped address  : Address = 0x00000000
>
>Why I am getting this error ?. Is any error there in my procedure..?
>  
>

Link your image to kseg0, not a virtual addresses like 0. The kernel, 
for example, is linked at kseg0 so the srec addresses are at 0x80100000. 
Since not tlbs are required for kseg0, yamon does not have problems 
loading into that region.

Pete
