Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2003 19:52:19 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:15453
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225377AbTJWSwR>; Thu, 23 Oct 2003 19:52:17 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id OAA09496;
	Thu, 23 Oct 2003 14:51:58 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id OAA16615;
	Thu, 23 Oct 2003 14:51:58 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Thu, 23 Oct 2003 14:51:58 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: Tiemo Krueger - mycable GmbH <tk@mycable.de>
cc: linux-mips@linux-mips.org
Subject: Re: root login
In-Reply-To: <3F969106.5000807@mycable.de>
Message-ID: <Pine.GSO.4.44.0310231449190.15850-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

I am able to login as a user and su to root. I still have not found the
reason for the problem. Well, for now I have something that works.
Thanks for the help.
David

On Wed, 22 Oct 2003, Tiemo Krueger - mycable GmbH wrote:

> Hmm, I remember that we had once a similar problem, but I can't remember
> the reason
> nor the solution. It appeared that we where not able to login as root,
> but user login was possible.
> Logged in as user I was allowed to 'su' to root.
> Perhaps this may be a hint, perhaps not, perhaps Bruno remembers the
> solution???
>
> Tiemo
>
> David Kesselring wrote:
>
> >I apologize for the many recent questions but I have another trivia
> >question for all of you. :-)
> >I have installed the RH7.3 miniport to a harddrive connected to a MIPS
> >Malta board. The kernel the comes with the port (2.4.18) works fine. I
> >then took the cvs code (2.4.22) for mips and built it for malta. The first
> >few builds worked ok (which means I could logon as root). Then I changed
> >something in the build process so that now the kernels which I build won't
> >allow me to logon as root. I've changed /etc/passwd to eliminate the root
> >pw. Does anyone know how a kernel can affect the login like this?
> >Thanks,
> >
> >David Kesselring
> >Atmel MMC
> >dkesselr@mmc.atmel.com
> >919-462-6587
> >
> >
> >
> >
> >
>
>
> --
> -------------------------------------------------------
> Tiemo Krueger       Tel:  +49 48 73 90 19 86
> mycable GmbH        Fax: +49 48 73 90 19 76
> Boeker Stieg 43
> D-24613 Aukrug      eMail: tk@mycable.de
>
> Public Kryptographic Key is available on request
> -------------------------------------------------------
>
>
>

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
