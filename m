Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Mar 2010 17:00:35 +0100 (CET)
Received: from apfelkorn.psychaos.be ([195.144.77.38]:39721 "EHLO
        apfelkorn.psychaos.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492705Ab0CUQAc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Mar 2010 17:00:32 +0100
Received: from p2 by apfelkorn.psychaos.be with local (Exim 4.69)
        (envelope-from <p2@psychaos.be>)
        id 1NtNZk-0000Ab-0J; Sun, 21 Mar 2010 18:00:28 +0200
Date:   Sun, 21 Mar 2010 18:00:27 +0200
From:   Peter 'p2' De Schrijver <p2@debian.org>
To:     David Daney <david.s.daney@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Jan Rovins <janr@adax.com>, linux-mips@linux-mips.org
Subject: Re: linux 2.6.33 on movidis x16
Message-ID: <20100321160027.GJ2437@apfelkorn>
References: <20100305141113.GD2437@apfelkorn> <4B9EB45D.8050106@adax.com> <20100318181734.GG2437@apfelkorn> <4BA27048.2010707@caviumnetworks.com> <4BA4021B.4010905@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BA4021B.4010905@gmail.com>
X-Unexpected-Header: The spanish inquisition !
X-mate: Mate, mann gewohnt sich an alles
X-Paddo: Munch, Munch
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <p2@psychaos.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@debian.org
Precedence: bulk
X-list: linux-mips

>
> Can you try the attached patch?
>
>
> from the back of the box we have:
>
> ---------------------------------------
> | eth5 | eth7 |  | eth1 | eth3 |
> ---------------------------------------
> | eth4 | eth6 |  | eth0 | eth2 |
> ---------------------------------------
>
> I was able to boot 2.6.34-rc1 to a Debian root nfs mounted via eth1.
>
> I didn't verify that eth4 - eth7 worked.
>

Yes ! That seems to work. We intend to use the machine as buildd, so 1 working 
ethernet is fine :)

Thanks,

Peter.
