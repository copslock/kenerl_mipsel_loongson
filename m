Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 07:59:38 +0000 (GMT)
Received: from smtp2.infineon.com ([IPv6:::ffff:194.175.117.77]:14235 "EHLO
	smtp2.infineon.com") by linux-mips.org with ESMTP
	id <S8225340AbUBEH7i>; Thu, 5 Feb 2004 07:59:38 +0000
Received: from mucse012.eu.infineon.com (mucse012.ifx-mail1.com [172.29.27.229])
	by smtp2.infineon.com (8.12.10/8.12.10) with ESMTP id i157vxx8015564;
	Thu, 5 Feb 2004 08:58:00 +0100 (MET)
Received: by mucse012.eu.infineon.com with Internet Mail Service (5.5.2653.19)
	id <1CW4K35L>; Thu, 5 Feb 2004 08:59:27 +0100
Received: from dlfw003a.dus.infineon.com ([172.29.128.3]) by mucse012.eu.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id 1CW4K35A; Thu, 5 Feb 2004 08:59:22 +0100
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <C04LGG2M>; Thu, 5 Feb 2004 08:58:44 +0100
From: Andre.Messerschmidt@infineon.com
To: vprashant@echelon.com
Cc: linux-mips@linux-mips.org
X-Mailer: Internet Mail Service (5.5.2653.19)
Message-ID: <86048F07C015D311864100902760F1DD0503F942@dlfw003a.dus.infineon.com>
Subject: RE: loading kernel via EJTAG interface
Date: Thu, 5 Feb 2004 08:58:43 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <Andre.Messerschmidt@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andre.Messerschmidt@infineon.com
Precedence: bulk
X-list: linux-mips

Hi,

>So, can't I just load the kernel image and just start executing from
>"kernel_entry"?

For testing purposes it might be feasible to hard code a command line and
environment into the kernel. I did this during test with a Lauterbach
debugger.
Of course you still have to setup SDRAM, clocks etc. before executing the
kernel.

regards
Andre
