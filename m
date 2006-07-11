Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2006 09:14:39 +0100 (BST)
Received: from mail.domino-uk.com ([193.131.116.193]:35847 "EHLO
	vMimePS1.domino-printing.com") by ftp.linux-mips.org with ESMTP
	id S8133396AbWGKIO3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Jul 2006 09:14:29 +0100
Received: from emea-exchange3.emea.dps.local (EMEA-EXCHANGE3) by 
    vMimePS1.domino-printing.com (Clearswift SMTPRS 5.2.3) with ESMTP id 
    <T79690e3921c18374c12698@vMimePS1.domino-printing.com> for 
    <linux-mips@linux-mips.org>; Tue, 11 Jul 2006 08:13:02 +0100
Received: from tuxator2.emea.dps.local ([192.168.55.75]) by 
    emea-exchange3.emea.dps.local with Microsoft SMTPSVC(6.0.3790.1830); 
    Tue, 11 Jul 2006 10:14:22 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: PCMCIA Help - AU1000 Alchemy Dev Board
Date:	Tue, 11 Jul 2006 10:14:21 +0200
User-Agent: KMail/1.9.1
References: <4E35E8AD-C3ED-47AE-A738-97B7F08D946C@willmert.com>
In-Reply-To: <4E35E8AD-C3ED-47AE-A738-97B7F08D946C@willmert.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607111014.21617.eckhardt@satorlaser.com>
X-OriginalArrivalTime: 11 Jul 2006 08:14:22.0163 (UTC) 
    FILETIME=[03D66230:01C6A4C2]
Return-Path: <Eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Monday 10 July 2006 19:45, craigslist wrote:
> I'm working on a project with linux 2.6.10 on the AMD au1000 alchemy
> board. 

I think there are two boards, called Db1000 and Pb1000. It is the processor 
that is called Au1000. You first need to make sure which one you have.

> I'm attempting to get the pcmcia socket working with a 
> wireless network card using the madwifi drivers. I have the 2.6.10
> kernel built for the au1000 dev board and the filesystem, etc.
> However, I'm having difficulties getting the PCMCIA socket to work
> correctly.
>
> At this point, i'm just working with the au1x00_ss module trying to
> get it to recognize a card insert into socket 0 of the au1000 dev
> board. Through debugging, I've noticed that the board_status register
> at 0XAE000004, bit 4, is not changing whether a card is inserted or
> not. It's my understanding that the first step to getting this
> working is detecting the presence of a card, however, I am apparently
> missing some detail as that register value never changes.
>
> Does anyone have experience with this? Has anyone gotten the pcmcia
> sockets working on the au1000 in 2.6?

I haven't worked with the Au1000 but the Au1100 on a custom board, and from 
there I have the following steps in mind:

1. The system-busses are used for multiple purposes, so the first thing to do 
is to configure the right bus for PCMCIA access (processor-specific).
2. You need to switch on power to the PCMCIA slot. There is no standard way to 
do that, as it depends on the board. On my board I had to read the layout to 
find the transistors used to switch the voltage, it was via some GPIO pins. 
These then also have to be properly configured (use a voltmeter to check 
power is present). Also mind that these are sometimes low-active or inverted 
along the lines - this caused confusion for me quite some times.
You should then also be able to detect that the card is present and such 
things. I don't remember, but I think some of those did not go through GPIO 
so these should have fixed connections valid for all boards.
3. You need to map the PCMCIA memory ranges into virtual memory. This is again 
only processor-specific, see the documentation.

Note that only the processor-specific part should be done by the au1x00_ss 
driver, though I wouldn't be surprised to find some board-specific parts 
there, too. It's not always easy to cleanly separate things.

Good luck!

Uli


****************************************************
Visit our website at <http://www.domino-printing.com/>
****************************************************
This Email and any files transmitted with it are intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any reading, redistribution, disclosure or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient please contact the sender immediately and delete the material from your computer.

E-mail may be susceptible to data corruption, interception, viruses and unauthorised amendment and Domino UK Limited does not accept liability for any such corruption, interception, viruses or amendment or their consequences.
****************************************************
