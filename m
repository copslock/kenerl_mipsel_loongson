Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 15:12:33 +0100 (BST)
Received: from mail.oricom.de ([IPv6:::ffff:62.116.167.108]:8618 "EHLO
	oricom4.internetx.de") by linux-mips.org with ESMTP
	id <S8225366AbTJVOMB>; Wed, 22 Oct 2003 15:12:01 +0100
Received: from mycable.de (p5086B9E0.dip.t-dialin.net [80.134.185.224])
	(authenticated bits=0)
	by oricom4.internetx.de (8.12.8/8.12.8) with ESMTP id h9MECB6Z029032;
	Wed, 22 Oct 2003 16:12:12 +0200
Message-ID: <3F969106.5000807@mycable.de>
Date: Wed, 22 Oct 2003 16:15:34 +0200
From: Tiemo Krueger - mycable GmbH <tk@mycable.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030916
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Kesselring <dkesselr@mmc.atmel.com>
CC: linux-mips@linux-mips.org
Subject: Re: root login
References: <Pine.GSO.4.44.0310220952170.15096-100000@ares.mmc.atmel.com>
In-Reply-To: <Pine.GSO.4.44.0310220952170.15096-100000@ares.mmc.atmel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tk@mycable.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tk@mycable.de
Precedence: bulk
X-list: linux-mips

Hmm, I remember that we had once a similar problem, but I can't remember 
the reason
nor the solution. It appeared that we where not able to login as root, 
but user login was possible.
Logged in as user I was allowed to 'su' to root.
Perhaps this may be a hint, perhaps not, perhaps Bruno remembers the 
solution???

Tiemo

David Kesselring wrote:

>I apologize for the many recent questions but I have another trivia
>question for all of you. :-)
>I have installed the RH7.3 miniport to a harddrive connected to a MIPS
>Malta board. The kernel the comes with the port (2.4.18) works fine. I
>then took the cvs code (2.4.22) for mips and built it for malta. The first
>few builds worked ok (which means I could logon as root). Then I changed
>something in the build process so that now the kernels which I build won't
>allow me to logon as root. I've changed /etc/passwd to eliminate the root
>pw. Does anyone know how a kernel can affect the login like this?
>Thanks,
>
>David Kesselring
>Atmel MMC
>dkesselr@mmc.atmel.com
>919-462-6587
>
>
>
>  
>


-- 
-------------------------------------------------------
Tiemo Krueger       Tel:  +49 48 73 90 19 86
mycable GmbH        Fax: +49 48 73 90 19 76
Boeker Stieg 43
D-24613 Aukrug      eMail: tk@mycable.de

Public Kryptographic Key is available on request
-------------------------------------------------------
