Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 07:25:40 +0100 (BST)
Received: from h081217049130.dyn.cm.kabsi.at ([81.217.49.130]:55767 "EHLO
	phobos.hvrlab.org") by ftp.linux-mips.org with ESMTP
	id S8133386AbWEBGZ1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 May 2006 07:25:27 +0100
Received: from mini.intra (dhcp-1432-30.blizz.at [213.143.126.4])
	(authenticated bits=0)
	by phobos.hvrlab.org (8.13.4/8.13.4/Debian-3sarge1) with ESMTP id k426PAFK004037
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Tue, 2 May 2006 08:25:11 +0200
Subject: Re: RFC: au1000_etc.c phylib rewrite
From:	Herbert Valerio Riedel <hvr@gnu.org>
To:	Mark Schank <mschank@dcbnet.com>
Cc:	ppopov@embeddedalley.com, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org, jgarzik@pobox.com
In-Reply-To: <5.1.0.14.2.20060501144633.025e4e20@205.166.54.3>
References: <1146510542.16643.10.camel@localhost.localdomain>
	 <1146510542.16643.10.camel@localhost.localdomain>
	 <5.1.0.14.2.20060501144633.025e4e20@205.166.54.3>
Content-Type: text/plain
Organization: Free Software Foundation
Date:	Tue, 02 May 2006 08:23:47 +0200
Message-Id: <1146551027.19659.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.88.1/1434/Mon May  1 21:51:00 2006 on phobos.hvrlab.org
X-Virus-Status:	Clean
Return-Path: <hvr@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@gnu.org
Precedence: bulk
X-list: linux-mips

On Mon, 2006-05-01 at 15:09 -0500, Mark Schank wrote:
> The Cogent CSB655 used the Broadcom Dual Phy.  They eventually redesigned 
> the board and switched to two single Broadcom phys, but they continued to 
> control both phys through MAC0, which is the actual purpose of the dual-phy 
> hack.  I am a user of the CSB655, so I sort of care.
> 
> Will the new PHY framework allow a second PHY for a second MAC (MAC1) be 
> controlled from the first MAC's (MAC0) mdio interface?

should'nt be a problem (as opposed to the bosporus case... see below)...
I assume the phy-addresses on which the boarcom dual phy is configured
are the same for all Cogent CSB655 boards?

does this need to be autodetected dynamically at runtime, or can we rely
on a compile time Kconfig-conditional to set a static phy-addr<->eth%
d-phy mapping for this board-specific case? Or de we really need such a
complex mii_probe() function to detect weird scenarios? :)

using static phy addr mappings would also allow for setting
board-specific phy-irq assignments, which would then be handled by the
phylib facilities, instead of polling the status of phy with a timer;
(and in case we don't have any board-specific compile time setting, we
can still fall back to search the phy-addresses for a PHY at runtime as
the generic case)

while at it, what about that CONFIG_MIPS_BOSPORUS special case? why
doesn't the 2nd MAC see any PHY? how is the 2nd MAC connected to the
physical world?

#ifdef CONFIG_MIPS_BOSPORUS
        /* This is a workaround for the Micrel/Kendin 5 port switch
           The second MAC doesn't see a PHY connected... so we need to
           trick it into thinking we have one.

           If this kernel is run on another Au1500 development board
           the stub will be found as well as the actual PHY. However,
           the last found PHY will be used... usually at Addr 31 (Db1500).
        */


> Yes, I acknowledge this was a bad design, but its what I am stuck with.

:-)
-- 
Herbert Valerio Riedel <hvr@gnu.org>
