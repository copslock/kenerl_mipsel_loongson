Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2005 13:39:16 +0000 (GMT)
Received: from ns1.sagem.com ([62.160.59.65]:43170 "EHLO mx1.sagem.com")
	by ftp.linux-mips.org with ESMTP id S8133590AbVLBNi6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2005 13:38:58 +0000
To:	linux-mips@linux-mips.org
Subject: Re : where to set the BEV to normal of status in kernel source?
MIME-Version: 1.0
Message-ID: <OF5E474B6B.A94FD801-ONC12570CB.004B3FC5-C12570CB.004B4D6D@sagem.com>
From:	Florian DELIZY <florian.delizy@sagem.com>
Date:	Fri, 2 Dec 2005 14:42:28 +0100
Content-Type: multipart/alternative; boundary="=_alternative 004B4D69C12570CB_="
Return-Path: <florian.delizy@sagem.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.delizy@sagem.com
Precedence: bulk
X-list: linux-mips

Message en plusieurs parties au format MIME
--=_alternative 004B4D69C12570CB_=
Content-Type: text/plain; charset="us-ascii"

Subject : where to set the BEV to normal of status in kernel source?
> i don't find it in load_mmu(), who can point out for me?
> thanks!

Well, if you are speaking about the BEV flag from the Status (SR) register 
(CP0_STATUS aka $12 of the 1st coprocessor)
then it controls the interruption/exception handler place, I don't see the 
relation with mmu ... 

> is that must be set in bootloader?

OK, I see, it should be set to 0 by the boot loader so that the TLB 
exceptions (related to the MMU) goes in RAM. So 
the kernel does not change it actually and hope the boot loader did.

-- Florian Delizy






--=_alternative 004B4D69C12570CB_=
Content-Type: text/html; charset="us-ascii"


<br>
<br>
<br><font size=2 face="sans-serif">Subject : where to set the BEV to normal of status in kernel source?</font>
<br><font size=2 face="Courier New">&gt; i don't find it in load_mmu(), who can point out for me?<br>
&gt; thanks!</font>
<br>
<br><font size=2 face="Courier New">Well, if you are speaking about the BEV flag from the Status (SR) register (CP0_STATUS aka $12 of the 1st coprocessor)</font>
<br><font size=2 face="Courier New">then it controls the interruption/exception handler place, I don't see the relation with mmu ... </font>
<br><font size=2 face="Courier New"><br>
&gt; is that must be set in bootloader?<br>
<br>
OK, I see, it should be set to 0 by the boot loader so that the TLB exceptions (related to the MMU) goes in RAM. So </font>
<br><font size=2 face="Courier New">the kernel does not change it actually and hope the boot loader did.</font>
<br><font size=2 face="Courier New"><br>
-- Florian Delizy</font>
<br>
<br><font size=2 face="Courier New"><br>
</font>
<br>
<br>
<br>
--=_alternative 004B4D69C12570CB_=--
