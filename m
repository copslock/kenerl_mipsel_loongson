Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jan 2003 11:53:58 +0000 (GMT)
Received: from smtp02.infoave.net ([IPv6:::ffff:165.166.0.27]:53242 "EHLO
	smtp02.infoave.net") by linux-mips.org with ESMTP
	id <S8224851AbTAPLx6> convert rfc822-to-8bit; Thu, 16 Jan 2003 11:53:58 +0000
Received: from opus ([204.116.3.125])
 by SMTP00.InfoAve.Net (PMDF V6.1-1IA5 #38776)
 with ESMTP id <01KRAL3JAVZ894ROUT@SMTP00.InfoAve.Net> for
 linux-mips@linux-mips.org; Thu, 16 Jan 2003 06:53:35 -0500 (EST)
Date: Thu, 16 Jan 2003 06:55:04 -0500
From: Justin Pauley <jpauley@xwizards.com>
Subject: Re: MOPD problems
In-reply-to: <20030116094612.GJ27441@lug-owl.de>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-mips@linux-mips.org
Message-id: <1042718104.2735.113.camel@Opus>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8BIT
References: <1042674081.2735.102.camel@Opus>
 <Pine.LNX.4.44.0301160103580.10229-100000@skynet>
 <20030116094612.GJ27441@lug-owl.de>
Return-Path: <jpauley@xwizards.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jpauley@xwizards.com
Precedence: bulk
X-list: linux-mips

My firmware won't allow me to TFTP over 1 meg, mopd is my last choice.
Justin
On Thu, 2003-01-16 at 04:46, Jan-Benedict Glaw wrote:
> On Thu, 2003-01-16 01:04:58 +0000, Dave Airlie <airlied@csn.ul.ie>
> wrote in message <Pine.LNX.4.44.0301160103580.10229-100000@skynet>:
> > 
> > sometimes a long time agao.. you needed to manually add the ethernet
> > address of the decstation to the arp table on the host machine..
> > 
> > arp -s <decstation_hostname> <ethernet_address>
> 
> MOP isn't an IP based protocol so it doesn't care about IP addresses. I
> think you want to solve some problem while TFTP'ing something:-)
> 
> MfG, JBG
> 
> -- 
>    Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>    "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
>     fuer einen Freien Staat voll Freier Bürger" | im Internet!
>    Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/
