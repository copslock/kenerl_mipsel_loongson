Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2006 07:36:25 +0100 (BST)
Received: from mail.domino-uk.com ([193.131.116.193]:2833 "EHLO
	vMimePS1.domino-printing.com") by ftp.linux-mips.org with ESMTP
	id S8133396AbWF0GgP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jun 2006 07:36:15 +0100
Received: from emea-exchange3.emea.dps.local (EMEA-EXCHANGE3) by 
    vMimePS1.domino-printing.com (Clearswift SMTPRS 5.2.3) with ESMTP id 
    <T79209b75e0c18374c12698@vMimePS1.domino-printing.com> for 
    <linux-mips@linux-mips.org>; Tue, 27 Jun 2006 06:35:01 +0100
Received: from tuxator2.emea.dps.local ([192.168.55.75]) by 
    emea-exchange3.emea.dps.local with Microsoft SMTPSVC(6.0.3790.1830); 
    Tue, 27 Jun 2006 08:36:09 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: au1000_lowlevel_probe on au1000_eth.c
Date:	Tue, 27 Jun 2006 08:36:08 +0200
User-Agent: KMail/1.9.1
References: <20060626221441.GA10595@enneenne.com>
In-Reply-To: <20060626221441.GA10595@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606270836.09057.eckhardt@satorlaser.com>
X-OriginalArrivalTime: 27 Jun 2006 06:36:09.0466 (UTC) 
    FILETIME=[F9BBADA0:01C699B3]
Return-Path: <Eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Tuesday 27 June 2006 00:14, Rodolfo Giometti wrote:
> I notice that during sleep/wakeup au1000_lowlevel_probe() tries to
> access to variables arcs_cmdline,prom_envp & Co.. This sometime does
> an oops.
>
> What I like to understand is if I simply have to skip accessing to
> these variables during wake up or I have to save them during system
> boot or what...?

What is the _right_ thing is difficult to answer, but the reasons for the oops 
are simple (at least they were on the platform I used): you have more than 
one device connected to the same system bus. In my case, it was the boot-PROM 
and (I think) the PCMCIA memory. So, in practice one could only access one of 
the two and you had to toggle between them. I'm not sure it is worth the 
hassle of toggling (and doing so in an orderly fashion!), I'd rather parse 
the PROM once and then store the results in RAM.

HTH

Uli

****************************************************
Visit our website at <http://www.domino-printing.com/>
****************************************************
This Email and any files transmitted with it are intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any reading, redistribution, disclosure or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient please contact the sender immediately and delete the material from your computer.

E-mail may be susceptible to data corruption, interception, viruses and unauthorised amendment and Domino UK Limited does not accept liability for any such corruption, interception, viruses or amendment or their consequences.
****************************************************
