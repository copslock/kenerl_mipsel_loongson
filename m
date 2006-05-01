Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 May 2006 21:08:38 +0100 (BST)
Received: from firewall.dcbnet.com ([12.96.67.19]:28084 "EHLO
	firewall.dcbnet.com") by ftp.linux-mips.org with ESMTP
	id S8133558AbWEAUI3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 May 2006 21:08:29 +0100
Received: from mschank.dcbnet.com (mschank.dcbnet.com [205.166.54.128])
	by firewall.dcbnet.com (8.12.10/8.12.10) with ESMTP id k41K8Ii7016340;
	Mon, 1 May 2006 15:08:20 -0500
Message-Id: <5.1.0.14.2.20060501144633.025e4e20@205.166.54.3>
X-Sender: mschank@205.166.54.3
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date:	Mon, 01 May 2006 15:09:15 -0500
To:	ppopov@embeddedalley.com, Herbert Valerio Riedel <hvr@gnu.org>
From:	Mark Schank <mschank@dcbnet.com>
Subject: Re: RFC: au1000_etc.c phylib rewrite
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org,
	jgarzik@pobox.com
In-Reply-To: <1146510945.21947.44.camel@localhost.localdomain>
References: <1146510542.16643.10.camel@localhost.localdomain>
 <1146510542.16643.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-Path: <mschank@dcbnet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mschank@dcbnet.com
Precedence: bulk
X-list: linux-mips

The Cogent CSB655 used the Broadcom Dual Phy.  They eventually redesigned 
the board and switched to two single Broadcom phys, but they continued to 
control both phys through MAC0, which is the actual purpose of the dual-phy 
hack.  I am a user of the CSB655, so I sort of care.

Will the new PHY framework allow a second PHY for a second MAC (MAC1) be 
controlled from the first MAC's (MAC0) mdio interface?

Yes, I acknowledge this was a bad design, but its what I am stuck with.

-Mark

At 12:15 PM 5/1/06 -0700, Pete Popov wrote:
>On Mon, 2006-05-01 at 21:09 +0200, Herbert Valerio Riedel wrote:
> > hello *,
> >
> > I've started to rewrite the au1000_eth.c driver to make use of the new
> > PHY framework in 2.6.x; see the attached patch for the current work in
> > progress state;
> >
> > I'm a bit unsure what to do about those workarounds/hacks that are in
> > the original au1000_eth.c driver (e.g. for the broadcom dual PHY);
>
>Maybe you should dump that bcm dual phy support. I can't remember what
>board it was on and whether that board is even supported still.
>
> > any comments/ideas? shall I continue work on this au1xxx-eth
> > phylib-rewrite, or is it of no use?
>
>Seems like a good idea to me.
>
>Pete
