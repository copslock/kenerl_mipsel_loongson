Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2010 19:26:45 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9101 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492193Ab0CRS0m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Mar 2010 19:26:42 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ba270680000>; Thu, 18 Mar 2010 11:26:48 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Mar 2010 11:26:17 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Mar 2010 11:26:17 -0700
Message-ID: <4BA27048.2010707@caviumnetworks.com>
Date:   Thu, 18 Mar 2010 11:26:16 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Thunderbird/3.0.3
MIME-Version: 1.0
To:     Peter 'p2' De Schrijver <p2@debian.org>
CC:     Jan Rovins <janr@adax.com>, linux-mips@linux-mips.org
Subject: Re: linux 2.6.33 on movidis x16
References: <20100305141113.GD2437@apfelkorn> <4B9EB45D.8050106@adax.com> <20100318181734.GG2437@apfelkorn>
In-Reply-To: <20100318181734.GG2437@apfelkorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Mar 2010 18:26:17.0338 (UTC) FILETIME=[7FCCFDA0:01CAC6C8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/18/2010 11:17 AM, Peter 'p2' De Schrijver wrote:
> On 2010-03-15 18:27:41 (-0400), Jan Rovins<janr@adax.com>  wrote:
>> Peter 'p2' De Schrijver wrote:
>>> Hi,
>>>
>>> We are trying to get linux 2.6.33 to work on the movidis x16 board. Main thing
>>> missing is the addresses of the PHYs. Does anyone know those ?
>>> Unfortunately I don't have physical access to the board so I can't just look
>>> for the PHY components being used.
>>>
>>> Thanks,
>>>
>>> Peter.
>>>
>>>
>> Do you mean the Movidis x19 ?
>
> Maybe. AFAIK ours is called x16, and uses a cavium octeon CN3860 chip.
>
>> We have 2 of these in our lab. They are running the old 2.6.21.7  from
>> the CnUsers 1.8.1  tool chain.
>> They are currently being used by other developers for some application
>> testing, but I can grab the serial console boot-up messages and send
>> them to you, if the PHY info is in there.
>
> That would be helpful. Otherwise you could also try running ethtool on all the
> interfaces. That should give you the PHY address as well.
>

I just found one of these.  Current theory is that the PHY addresses are 0-7

I don't think the PHY numbers are printed anywhere.

David Daney
