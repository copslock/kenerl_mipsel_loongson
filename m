Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 17:20:18 +0100 (BST)
Received: from firewall.dcbnet.com ([12.96.67.19]:26313 "EHLO
	firewall.dcbnet.com") by ftp.linux-mips.org with ESMTP
	id S8133720AbWEBQT7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 May 2006 17:19:59 +0100
Received: from mschank.dcbnet.com (mschank.dcbnet.com [205.166.54.128])
	by firewall.dcbnet.com (8.12.10/8.12.10) with ESMTP id k42GJji7011286;
	Tue, 2 May 2006 11:19:50 -0500
Message-Id: <5.1.0.14.2.20060502095256.01fd4210@205.166.54.3>
X-Sender: mschank@205.166.54.3
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date:	Tue, 02 May 2006 11:20:43 -0500
To:	Herbert Valerio Riedel <hvr@gnu.org>
From:	Mark Schank <mschank@dcbnet.com>
Subject: Re: RFC: au1000_etc.c phylib rewrite
Cc:	ppopov@embeddedalley.com, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org, jgarzik@pobox.com
In-Reply-To: <1146551027.19659.12.camel@localhost.localdomain>
References: <5.1.0.14.2.20060501144633.025e4e20@205.166.54.3>
 <1146510542.16643.10.camel@localhost.localdomain>
 <1146510542.16643.10.camel@localhost.localdomain>
 <5.1.0.14.2.20060501144633.025e4e20@205.166.54.3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-Path: <mschank@dcbnet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mschank@dcbnet.com
Precedence: bulk
X-list: linux-mips

At 08:23 AM 5/2/06 +0200, Herbert Valerio Riedel wrote:
>On Mon, 2006-05-01 at 15:09 -0500, Mark Schank wrote:
> > The Cogent CSB655 used the Broadcom Dual Phy.  They eventually redesigned
> > the board and switched to two single Broadcom phys, but they continued to
> > control both phys through MAC0, which is the actual purpose of the 
> dual-phy
> > hack.  I am a user of the CSB655, so I sort of care.
> >
> > Will the new PHY framework allow a second PHY for a second MAC (MAC1) be
> > controlled from the first MAC's (MAC0) mdio interface?
>
>should'nt be a problem (as opposed to the bosporus case... see below)...
>I assume the phy-addresses on which the boarcom dual phy is configured
>are the same for all Cogent CSB655 boards?

Dual PHY configuration:
     MAC0 - phy addr 4
     MAC1 - phy addr 3
Single PHY configuration:
     MAC0 - phy addr 1
     MAC1 - phy addr 0

>does this need to be autodetected dynamically at runtime, or can we rely
>on a compile time Kconfig-conditional to set a static phy-addr<->eth%
>d-phy mapping for this board-specific case? Or de we really need such a
>complex mii_probe() function to detect weird scenarios? :)

The compile time Kconfig-conditional should be okay.  The driver need to 
handle the fact that the MAC1's phy is controlled by MAC0's mdio 
interface.  This means that MAC0 controller can not be disabled when the 
associated eth% device is down, otherwise you lose the ability to control 
MAC1's phy.


>using static phy addr mappings would also allow for setting
>board-specific phy-irq assignments, which would then be handled by the
>phylib facilities, instead of polling the status of phy with a timer;
>(and in case we don't have any board-specific compile time setting, we
>can still fall back to search the phy-addresses for a PHY at runtime as
>the generic case)

Will the phylib facilities handle the case where two phys share a single IRQ?


>while at it, what about that CONFIG_MIPS_BOSPORUS special case? why
>doesn't the 2nd MAC see any PHY? how is the 2nd MAC connected to the
>physical world?

I don't have first hand knowledge of this board, but I have worked with 
Kendin switches before.  They have a special port that allows direct 
connection of a MAC into the switch port without the use of a phy.  The 
MAC's MII is directly connected to the switch ports MII.  So instead of this:
         MAC <-> PHY <->PHY <-> Switch_Port
You have this:
         MAC <-> Switch_Port

So the MAC talks to the physical world via the switch.

>#ifdef CONFIG_MIPS_BOSPORUS
>         /* This is a workaround for the Micrel/Kendin 5 port switch
>            The second MAC doesn't see a PHY connected... so we need to
>            trick it into thinking we have one.
>
>            If this kernel is run on another Au1500 development board
>            the stub will be found as well as the actual PHY. However,
>            the last found PHY will be used... usually at Addr 31 (Db1500).
>         */
>
>
> > Yes, I acknowledge this was a bad design, but its what I am stuck with.
>
>:-)
>--
>Herbert Valerio Riedel <hvr@gnu.org>
