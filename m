Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Aug 2004 23:28:43 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:54258 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225216AbUHLW2i>;
	Thu, 12 Aug 2004 23:28:38 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA07501;
	Thu, 12 Aug 2004 15:28:01 -0700
Message-ID: <411BEEF0.7060107@mvista.com>
Date: Thu, 12 Aug 2004 15:28:00 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, dev-list@meshcube.org,
	linuxconsole-dev@lists.sourceforge.net,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Q: problems with missing /dev/tty0 on X startup in MIPS system
References: <Pine.LNX.4.58.0408121954270.14123@shofar.kom.e-technik.tu-darmstadt.de> <Pine.GSO.4.58.0408122101460.18214@waterleaf.sonytel.be> <Pine.LNX.4.58.0408130009070.14554@shofar.kom.e-technik.tu-darmstadt.de>
In-Reply-To: <Pine.LNX.4.58.0408130009070.14554@shofar.kom.e-technik.tu-darmstadt.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


>Unfortunately - neither the fbdev code nor the X startup activates the 
>card.
>The X startup failed with an "unable to map the card" once and now 
>repeatedly fails with:
>  
>

I don't know which ATI Rage card you have exactly, but there is a patch 
for the RageXL (tested on a MIPS board) on 
ftp.linux-mips.org:/pub/linux/mips/people/ppopov/2.4/aty_nobiosinit.patch.

The problem is that at kernel version 2.4.24 or .25, don't remember 
which one, the aty code was restructured and the patch does not apply 
anymore.

Pete
