Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2004 09:22:57 +0000 (GMT)
Received: from web.123-box.de ([IPv6:::ffff:193.254.185.98]:34724 "HELO
	web.123-box.de") by linux-mips.org with SMTP id <S8225472AbUCSJW4> convert rfc822-to-8bit;
	Fri, 19 Mar 2004 09:22:56 +0000
Received: (qmail 19195 invoked by uid 110); 19 Mar 2004 09:25:44 -0000
Received: from unknown (HELO server10.dallmeier.de) (217.235.80.90)
  by web.123-box.de with SMTP; 19 Mar 2004 09:25:44 -0000
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: AW: PMON documentation
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Fri, 19 Mar 2004 10:22:51 +0100
Message-ID: <765921A8173EC145948ACBAA0480F67E2A1D24@server10.dallmeier.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PMON documentation
thread-index: AcQNK6cq86QuLI9hQYe/WA/jxdYB6QAZ6w3g
From: "erras stefan" <stefan.erras@dallmeier-electronic.com>
To: "Pete Popov" <ppopov@mvista.com>
Cc: "Linux MIPS mailing list" <linux-mips@linux-mips.org>
Return-Path: <stefan.erras@dallmeier-electronic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefan.erras@dallmeier-electronic.com
Precedence: bulk
X-list: linux-mips

I'm using PMON version 0.0291 (This says the boot sequence via serial port)
I have to do modifications in the section for the RTC. Where can I find the code for this modifications.
We have problems with our RTC because it does not work very well with the actual initialization.
I'm searching for a good manual for the used assembler in PMON. Can anybody help me?

Stefan


-----Ursprüngliche Nachricht-----
Von: Pete Popov [mailto:ppopov@mvista.com] 
Gesendet: Donnerstag, 18. März 2004 21:57
An: erras stefan
Cc: Linux MIPS mailing list
Betreff: Re: PMON documentation


On Thu, 2004-03-18 at 05:09, erras stefan wrote:
> Hello,
> I'm working on a development project with a RM5231 MIPS processor. I 
> have to modify some things in the PMON bootloader source-code. Can 
> anybody give me an advice where I can find PMON source code 
> documentation or a detailed explanation how PMON works. Which files do 
> I have to look into, when I would like to modify the bootloader.
> Maybe I can use another bootloader. Which alternatives do I have. I do
> not need the debug functionality of PMON. Maybe there is an easier to
> understand and modify bootloader.
> 
> Thank you all in advance for your help!

I think there were too many versions of "PMON" floating out there. I'm not sure which one you have.

If you are starting from scratch, take a look at uboot. I think that would be a much better alternative.

Pete
