Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2004 19:42:51 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:13566 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8224952AbUKVTmq>; Mon, 22 Nov 2004 19:42:46 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id B3904186A7; Mon, 22 Nov 2004 11:42:44 -0800 (PST)
Message-ID: <41A24134.8050004@mvista.com>
Date: Mon, 22 Nov 2004 11:42:44 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Thomas Koeller <thomas.koeller@baslerweb.com>,
	linux-mips@linux-mips.org
Subject: Re: titan code question
References: <200411191623.14760.thomas.koeller@baslerweb.com> <41A2234C.8090809@mvista.com> <Pine.LNX.4.58L.0411221936220.31113@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0411221936220.31113@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Mon, 22 Nov 2004, Manish Lachwani wrote:
> 
> 
>>Hence, they used this register. I am not sure if this is even 
>>documented. However, this code has been written based on the feedback 
>>from the chip designers. If you dont use this code, the MAC subsystem of 
>>titan will stop aligning IP headers and you will need to implement the 
>>code in the driver to do the aligning.
> 
> 
>  That means you should use macros for registers and their contents,
> preferably with some nearby documentation in the form of comments to
> clarify less obvious bits.  Otherwise you end up with an unmaintainable
> mess, especially once other sources of information drain out.
> 
>   Maciej

I agree that we need to provide documentation :)

Thanks
Manish Lachwani
