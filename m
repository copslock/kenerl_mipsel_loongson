Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2010 19:17:38 +0100 (CET)
Received: from apfelkorn.psychaos.be ([195.144.77.38]:57108 "EHLO
        apfelkorn.psychaos.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491065Ab0CRSRf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Mar 2010 19:17:35 +0100
Received: from p2 by apfelkorn.psychaos.be with local (Exim 4.69)
        (envelope-from <p2@psychaos.be>)
        id 1NsKHm-0005xm-6R; Thu, 18 Mar 2010 20:17:34 +0200
Date:   Thu, 18 Mar 2010 20:17:34 +0200
From:   Peter 'p2' De Schrijver <p2@debian.org>
To:     Jan Rovins <janr@adax.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: linux 2.6.33 on movidis x16
Message-ID: <20100318181734.GG2437@apfelkorn>
References: <20100305141113.GD2437@apfelkorn> <4B9EB45D.8050106@adax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B9EB45D.8050106@adax.com>
X-Unexpected-Header: The spanish inquisition !
X-mate: Mate, mann gewohnt sich an alles
X-Paddo: Munch, Munch
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <p2@psychaos.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@debian.org
Precedence: bulk
X-list: linux-mips

On 2010-03-15 18:27:41 (-0400), Jan Rovins <janr@adax.com> wrote:
> Peter 'p2' De Schrijver wrote:
>> Hi,
>>
>> We are trying to get linux 2.6.33 to work on the movidis x16 board. Main thing
>> missing is the addresses of the PHYs. Does anyone know those ?
>> Unfortunately I don't have physical access to the board so I can't just look
>> for the PHY components being used.
>>
>> Thanks,
>>
>> Peter.
>>
>>   
> Do you mean the Movidis x19 ?

Maybe. AFAIK ours is called x16, and uses a cavium octeon CN3860 chip.

> We have 2 of these in our lab. They are running the old 2.6.21.7  from  
> the CnUsers 1.8.1  tool chain.
> They are currently being used by other developers for some application  
> testing, but I can grab the serial console boot-up messages and send  
> them to you, if the PHY info is in there.

That would be helpful. Otherwise you could also try running ethtool on all the
interfaces. That should give you the PHY address as well.

Thanks !

Peter.
