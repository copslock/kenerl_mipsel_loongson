Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 19:58:51 +0000 (GMT)
Received: from [IPv6:::ffff:212.12.33.223] ([IPv6:::ffff:212.12.33.223]:58244
	"EHLO jusst.de") by linux-mips.org with ESMTP id <S8225205AbTBNT6v> convert rfc822-to-8bit;
	Fri, 14 Feb 2003 19:58:51 +0000
Received: from p5081eff0.dip.t-dialin.net ([80.129.239.240] helo=juli.scheel-home.de)
	by jusst.de with asmtp (Exim 4.05)
	id 18jlv6-0001DQ-00; Fri, 14 Feb 2003 20:54:48 +0100
From: Julian Scheel <jscheel@activevb.de>
To: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
Subject: Re: [patch] VR4181A and SMVR4181A
Date: Fri, 14 Feb 2003 20:59:29 +0100
User-Agent: KMail/1.5
Cc: linux-mips@linux-mips.org
References: <20030213155833.56019323.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <20030213155833.56019323.yoichi_yuasa@montavista.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302142059.29634.jscheel@activevb.de>
Return-Path: <jscheel@activevb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscheel@activevb.de
Precedence: bulk
X-list: linux-mips

Hi Yoichi,

I have a short question to your patch: What CPU do I have to select for the 
VR4181A?
MIPS32? or R41xx?

Am Donnerstag, 13. Februar 2003 07:58 schrieb Yoichi Yuasa:
> Hello Ralf,
>
> I added support of NEC VR4181A and NEC SMVR4181A board.
>
> As for VR4181A, The peripheral differs from VR4181 or VR4100 series
> greatly. If a VR4100 core is removed from VR4181, VR4181A and VR4100
> series, they are completely different chip.
>
> Therefore, the directory vr4181a was newly created below to arch/mips.
>
> This patch is based on linux_2_4 tag cvs tree on ftp.linux-mips.org
> Would you apply this patch to CVS on ftp.linux-mips.org?
>
> P.S.
> The patch for 2.5 is also created now. Please wait for a moment.
>
> Best Regards,
>
> Yoichi

-- 
Grüße,
Julian
