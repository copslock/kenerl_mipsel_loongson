Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 17:34:47 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:64499 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225428AbUDTQeq>;
	Tue, 20 Apr 2004 17:34:46 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA29054;
	Tue, 20 Apr 2004 09:34:41 -0700
Message-ID: <40855117.5070100@mvista.com>
Date: Tue, 20 Apr 2004 09:34:31 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F8rg_Ulrich_Hansen?= <jh@hansen-telecom.dk>
CC: Linux-Mips <linux-mips@linux-mips.org>
Subject: Re: SV: Framebuffer for au1100
References: <004f01c426f1$7085b080$050ba8c0@ANNEMETTE>
In-Reply-To: <004f01c426f1$7085b080$050ba8c0@ANNEMETTE>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


>Hi
>
>If you can put me in the right direction I am very keen on helping.
>I have included the file in Kconfig but then it wound compile because of
>the old 2.4 files (fbcon).
>What are the tasks and are you aware of any framebuffer code that are
>already modyfired?
>  
>
The entire FB API is different. Take a look at the skeleton fb driver -- 
there are headers with each function explaining what it does. There may 
be some other documentation in the Documentation directory but I'm not 
sure. It's not as easy as updated Kconfig. But fortunately the au1100fb 
driver is a pretty simple driver so updating it shouldn't be that bad. I 
would suggest you follow the example of a 2.6 FB driver that has been 
updated to the new API.

Pete
