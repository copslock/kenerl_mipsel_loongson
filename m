Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Feb 2003 17:19:34 +0000 (GMT)
Received: from [IPv6:::ffff:212.12.33.223] ([IPv6:::ffff:212.12.33.223]:64388
	"EHLO jusst.de") by linux-mips.org with ESMTP id <S8224847AbTBPRTd> convert rfc822-to-8bit;
	Sun, 16 Feb 2003 17:19:33 +0000
Received: from p5081f16c.dip.t-dialin.net ([80.129.241.108] helo=juli.scheel-home.de)
	by jusst.de with asmtp (Exim 4.05)
	id 18kSO3-0001JO-00
	for linux-mips@linux-mips.org; Sun, 16 Feb 2003 18:15:31 +0100
From: Julian Scheel <jscheel@activevb.de>
Subject: Re: [patch] VR4181A and SMVR4181A
Date: Sun, 16 Feb 2003 18:20:47 +0100
User-Agent: KMail/1.5
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302161820.47585.jscheel@activevb.de>
Return-Path: <jscheel@activevb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscheel@activevb.de
Precedence: bulk
X-list: linux-mips

Hi,

Am Samstag, 15. Februar 2003 16:22 schrieb Kunihiko IMAI:
> I met this error, too.  This means that your assembler didn't
> recognize the instruction 'standby'.
>
> To escape this error, quick and dirty method, replace 'standby' with 'cop0
> 0x21'.  These means same instruction.

This don't helps for me. I get the same error, but with "cop00x21" instead of
standby.
I think it has something to do with the compiler options.
I use -mcpu=r4600 -mips2 -Wa,--trap, which is set for VR41xx CPU. But standby
seems to be a special option, not supported by r4600/mips2.
What compiler-options do you use?

--
Grüße,
Julian
