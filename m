Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2004 19:13:04 +0100 (BST)
Received: from [IPv6:::ffff:66.151.148.199] ([IPv6:::ffff:66.151.148.199]:39686
	"EHLO eagle.qarbon.com") by linux-mips.org with ESMTP
	id <S8225478AbUEQSNE>; Mon, 17 May 2004 19:13:04 +0100
Received: (qmail 24278 invoked from network); 17 May 2004 11:12:55 -0700
Received: from unknown (HELO theilya.com) (ilya@192.168.2.42)
  by 192.168.2.15 with AES256-SHA encrypted SMTP; 17 May 2004 11:12:55 -0700
Message-ID: <40A900A1.2070603@theilya.com>
Date: Mon, 17 May 2004 11:12:49 -0700
From: "Ilya A. Volynets-Evenbakh" <ilya@theilya.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: SGI O2 MIPS R5000 bootp problems
References: <40A8E08B.7070203@cyberMalex.com> <20040517161515.GA5706@umax645sx> <20040517163639.GA32507@linux-mips.org> <20040517180848.GA1551@excalibur.cologne.de>
In-Reply-To: <20040517180848.GA1551@excalibur.cologne.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@theilya.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theilya.com
Precedence: bulk
X-list: linux-mips

And that is why you should use Gentoo!

Karsten Merker wrote:

>On Mon, May 17, 2004 at 06:36:39PM +0200, Ralf Baechle wrote:
>  
>
>>On Mon, May 17, 2004 at 06:15:16PM +0200, Ladislav Michl wrote:
>>
>>    
>>
>>>>7536
>>>>Cannot load bootp():r5000_boot.img.
>>>>Range check failure: text start 0x88802000, size 0x1d70.
>>>>        
>>>>
>>>                                  ^^^^^^^^^^
>>>What kernel version are you running? This bug was fixed quite long ago.
>>>I'd recommend using recent cvs and patch by Ilya
>>>http://www.total-knowledge.com/progs/mips/patches
>>>      
>>>
>>Looks like an attempt to load an IP22 kernel into an IP32.
>>    
>>
>
>Definitely - Debian does not yet provide IP32 images, only IP22.
>
>Regards,
>Karsten
>  
>
