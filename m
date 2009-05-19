Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 08:13:22 +0100 (BST)
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:56311 "EHLO
	QMTA06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021968AbZESHNQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2009 08:13:16 +0100
Received: from OMTA12.emeryville.ca.mail.comcast.net ([76.96.30.44])
	by QMTA06.emeryville.ca.mail.comcast.net with comcast
	id tK7l1b0040x6nqcA6KDAAM; Tue, 19 May 2009 07:13:10 +0000
Received: from [192.168.1.13] ([24.126.111.8])
	by OMTA12.emeryville.ca.mail.comcast.net with comcast
	id tKD71b00B0AvCMk8YKD97k; Tue, 19 May 2009 07:13:10 +0000
Message-ID: <4A125BD4.7050904@gentoo.org>
Date:	Tue, 19 May 2009 03:12:20 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Johannes Dickgreber <tanzy@gmx.de>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Help getting IP30/Octane fixed?
References: <4A06100F.7020105@gentoo.org> <4A0717AA.8060603@gmx.de> <4A072383.3010109@gentoo.org> <4A0F0E7B.1010602@gmx.de>
In-Reply-To: <4A0F0E7B.1010602@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Johannes Dickgreber wrote:
>
> i think i found the problem
> 
> try booting with a command line       cca=5
> 
> the system is setting _page_cachable_default with what is found in the
> processor register at booting time which is 3 ( _CACHE_CACHABLE_NONCOHERENT )
> i think this can not work on a SMP System.
> 
> with the above overriding i have a working SMP Octane system.
> 
> 	cca = 5  means _CACHE_CACHABLE_COHERENT
> 
> if time permits i send patches 

Tried this and the change to HEART_IMR on my end using a dual R10000 195MHz 
module.  It didn't boot in any of the cases.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
