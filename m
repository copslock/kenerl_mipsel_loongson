Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2003 17:36:38 +0000 (GMT)
Received: from firewall.mpc-ogw.co.uk ([IPv6:::ffff:81.2.99.170]:1659 "EHLO
	burton.mpc-data.co.uk") by linux-mips.org with ESMTP
	id <S8225355AbTLORgh>; Mon, 15 Dec 2003 17:36:37 +0000
Received: from lion.mpc-data.co.uk (IDENT:root@lion.mpc-data.co.uk [192.150.92.1])
	by burton.mpc-data.co.uk (8.12.8/8.12.7) with ESMTP id hBFHaVpc029487;
	Mon, 15 Dec 2003 17:36:31 GMT
Received: from [192.150.92.72] (duvel.mpc-data.co.uk [192.150.92.72])
	by lion.mpc-data.co.uk (8.9.3/8.8.5) with ESMTP id RAA12343;
	Mon, 15 Dec 2003 17:36:37 GMT
In-Reply-To: <1071507785.25858.55.camel@zeus.mvista.com>
References: <E3E525EC-2A4C-11D8-AC44-000A959E1510@mpc-data.co.uk> <1071507785.25858.55.camel@zeus.mvista.com>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <78DDDAF5-2F25-11D8-9EC1-000A959E1510@mpc-data.co.uk>
Content-Transfer-Encoding: 7bit
Cc: linux-mips@linux-mips.org
From: James Cope <jcope@mpc-data.co.uk>
Subject: Re: PCMCIA on AMD Alchemy Au1100 boards
Date: Mon, 15 Dec 2003 17:38:19 +0000
To: Pete Popov <ppopov@mvista.com>
X-Mailer: Apple Mail (2.606)
Return-Path: <jcope@mpc-data.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jcope@mpc-data.co.uk
Precedence: bulk
X-list: linux-mips


On 15 Dec 2003, at 17:03, Pete Popov wrote:

> What version of 2.4 are you running?

2.4.23-rc3 (CVS tag linux_2_4).

> Sounds familiar, I think. Sounds like mismatch in the driver name and
> the pcmcia config file. If your driver is named ide_cs, the "devinfo"
> inside the driver is set to "ide_cs" and that string won't match an
> "ide-cs", which is probably what your pcmcia config file has... I'm
> guessing.

In the kernel source the driver is named ide-cs and in the 
pcmcia-cs-3.1.22 tree it is named ide_cs. Not only are they named 
differently, but they behave differently too. I have since `fixed' the 
problem by using ide_cs rather than ide-cs. I've not yet had a chance 
to investigate exactly what the incompatibility between the two is, so 
far I only know that one works and the other doesn't.

Thanks for your comments.

Regards,

James Cope
