Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 16:30:43 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:57338 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225285AbUDTPam>;
	Tue, 20 Apr 2004 16:30:42 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id IAA24311;
	Tue, 20 Apr 2004 08:30:23 -0700
Message-ID: <4085420D.7040403@mvista.com>
Date: Tue, 20 Apr 2004 08:30:21 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F8rg_Ulrich_Hansen?= <jh@hansen-telecom.dk>
CC: Linux-Mips <linux-mips@linux-mips.org>
Subject: Re: Framebuffer for au1100
References: <EIEHIDHKGJLNEPLOGOPOKEIACGAA.jh@hansen-telecom.dk>
In-Reply-To: <EIEHIDHKGJLNEPLOGOPOKEIACGAA.jh@hansen-telecom.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Jørg Ulrich Hansen wrote:

>Hi
>
>I was trying to make use of framebuffer for a db1100 board. It looks like
>au1100fb.c is not updated to kernel 2.6. It makes use of some structs and
>procedures in fbcon that has been removed in 2.6.
>Any ideas what is needed to get au1100fb.c to work in 2.6?
>Has someone 2.6 to work with frambuffers on au1100?
>I think that au1100fb is written for pb1100 that has an epson lcd controller
>fitted.
>Does that mean that nothing has been done for the internal lcd controller?
>  
>
No, the internal au1100 fb controller is supported in 2.4. The external 
epson controller is supported through the LCD chip select. What needs to 
be done in 2.6 is an update of the au1100fb driver to the new api. Right 
now what I'm working on part time is syncing up 2.6 with the latest 2.4 
updates and getting the basic features functioning, including the 36 bit 
address support. Then the drivers update will come one at a time. Of 
course, if someone else has time to help, patches are welcomed :)

Pete
