Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 May 2004 00:04:24 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:43255 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225397AbUEGXEX>;
	Sat, 8 May 2004 00:04:23 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA15331;
	Fri, 7 May 2004 16:04:19 -0700
Message-ID: <409C15F1.5080702@mvista.com>
Date: Fri, 07 May 2004 16:04:17 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Bird <tim.bird@am.sony.com>
CC: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: MIPS status in 2.6
References: <409C0960.3080604@am.sony.com> <20040507155811.B9702@mvista.com>
In-Reply-To: <20040507155811.B9702@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:

>On Fri, May 07, 2004 at 03:10:40PM -0700, Tim Bird wrote:
>  
>
>>Anyone know what the status is of MIPS support in 2.6?
>>
>>    
>>
>
>32bit has been working pretty well, including preemption, kgdb,
>SMP, etc.  IO subsystems have not been thoroughly tested.  Board support
>varies.
>
>64bit needs some work.
>  
>
AMD Alchemy boards:
- serial driver was updated
- ethernet driver works, but seens some minor updates
- kind of a beta version of the 36bit address support was sent to Ralf
- pcmcia driver was rewritten for 2.6, but only for db1x00 right now. 
The rest of the boards need to be updated.
- usb host needs work
- pci bus seems to work (with the 36bit patch)
- sound driver needs update from OSS to ALSA
- Au1100 FB driver needs to be updated to 2.6
- Epson FB driver too (I won't work on that one)
- usb gadget support is needed

I may be forgetting something. I'm working on it part time.

Pete
