Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2004 02:14:35 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:3060 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225339AbUJOBO3>; Fri, 15 Oct 2004 02:14:29 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 2E381185BB; Thu, 14 Oct 2004 18:14:24 -0700 (PDT)
Message-ID: <416F246F.3060005@mvista.com>
Date: Thu, 14 Oct 2004 18:14:23 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH]PCI on SWARM
References: <416DE31E.90509@mvista.com> <20041014191754.GB30516@linux-mips.org> <Pine.LNX.4.58L.0410142305380.25607@blysk.ds.pg.gda.pl> <416EFBAB.8050600@mvista.com> <Pine.LNX.4.58L.0410142327530.25607@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0410142327530.25607@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>On Thu, 14 Oct 2004, Manish Lachwani wrote:
>
>  
>
>>Honestly, I dont have the manual to determine the port address space 
>>    
>>
>
> Well, have you considered getting one?
>
>  
>
>>bits. Hence, I set it to this value to MAX (i.e. 0xffffffff). Probably, 
>>should have mentioned that when sending the patch. Do you want me to try 
>>with this value (0x01ffffff) ?
>>    
>>
>
> Absolutely -- unfortunately I cannot test the change myself ATM.
>
>  Maciej
>  
>

Hello !

This value works well.

Thanks
Manish Lachwani
