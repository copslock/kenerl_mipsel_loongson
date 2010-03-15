Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Mar 2010 23:27:59 +0100 (CET)
Received: from mail1.adax.com ([208.201.231.104]:27382 "EHLO mail1.adax.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492085Ab0COW14 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Mar 2010 23:27:56 +0100
Received: from static-151-204-189-187.pskn.east.verizon.net (static-151-204-189-187.pskn.east.verizon.net [151.204.189.187])
        by mail1.adax.com (Postfix) with ESMTP id 42629120A09;
        Mon, 15 Mar 2010 15:27:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id 4466D400589;
        Mon, 15 Mar 2010 18:27:52 -0400 (EDT)
X-Virus-Scanned: amavisd-new at pskn.east.verizon.net
Received: from static-151-204-189-187.pskn.east.verizon.net ([127.0.0.1])
        by localhost (static-151-204-189-187.pskn.east.verizon.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4P2EqqHx9vNe; Mon, 15 Mar 2010 18:27:26 -0400 (EDT)
Received: from [192.168.1.76] (jr001327.mtl-nj.adax [192.168.1.76])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id 04B7C400588;
        Mon, 15 Mar 2010 18:27:25 -0400 (EDT)
Message-ID: <4B9EB45D.8050106@adax.com>
Date:   Mon, 15 Mar 2010 18:27:41 -0400
From:   Jan Rovins <janr@adax.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     Peter 'p2' De Schrijver <p2@debian.org>
CC:     linux-mips@linux-mips.org
Subject: Re: linux 2.6.33 on movidis x16
References: <20100305141113.GD2437@apfelkorn>
In-Reply-To: <20100305141113.GD2437@apfelkorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <janr@adax.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: janr@adax.com
Precedence: bulk
X-list: linux-mips

Peter 'p2' De Schrijver wrote:
> Hi,
>
> We are trying to get linux 2.6.33 to work on the movidis x16 board. Main thing
> missing is the addresses of the PHYs. Does anyone know those ?
> Unfortunately I don't have physical access to the board so I can't just look
> for the PHY components being used.
>
> Thanks,
>
> Peter.
>
>   
Do you mean the Movidis x19 ?
We have 2 of these in our lab. They are running the old 2.6.21.7  from 
the CnUsers 1.8.1  tool chain.
They are currently being used by other developers for some application 
testing, but I can grab the serial console boot-up messages and send 
them to you, if the PHY info is in there.

Jan
