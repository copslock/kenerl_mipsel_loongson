Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 16:13:43 +0100 (BST)
Received: from mail.oricom.de ([IPv6:::ffff:62.116.167.108]:33453 "EHLO
	oricom4.internetx.de") by linux-mips.org with ESMTP
	id <S8225426AbTJVPNL>; Wed, 22 Oct 2003 16:13:11 +0100
Received: from mycable.de (pD958CF2F.dip.t-dialin.net [217.88.207.47])
	(authenticated bits=0)
	by oricom4.internetx.de (8.12.8/8.12.8) with ESMTP id h9MFDH6Z031113
	for <linux-mips@linux-mips.org>; Wed, 22 Oct 2003 17:13:24 +0200
Message-ID: <3F969E7A.30600@mycable.de>
Date: Wed, 22 Oct 2003 17:12:58 +0200
From: Joerg Ritter <jr@mycable.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-DE; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: root login
References: <Pine.GSO.4.44.0310220952170.15096-100000@ares.mmc.atmel.com> <3F969106.5000807@mycable.de>
In-Reply-To: <3F969106.5000807@mycable.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jr@mycable.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jr@mycable.de
Precedence: bulk
X-list: linux-mips

You have probably enabled secure tty.
Please check /etc/securetty and add /dev/ttys0 or /dev/tts/0 (for devfs).

/Joerg

Tiemo Krueger - mycable GmbH schrieb:
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
>> I apologize for the many recent questions but I have another trivia
>> question for all of you. :-)
>> I have installed the RH7.3 miniport to a harddrive connected to a MIPS
>> Malta board. The kernel the comes with the port (2.4.18) works fine. I
>> then took the cvs code (2.4.22) for mips and built it for malta. The 
>> first
>> few builds worked ok (which means I could logon as root). Then I changed
>> something in the build process so that now the kernels which I build 
>> won't
>> allow me to logon as root. I've changed /etc/passwd to eliminate the root
>> pw. Does anyone know how a kernel can affect the login like this?
>> Thanks,
>>
>> David Kesselring
>> Atmel MMC
>> dkesselr@mmc.atmel.com
>> 919-462-6587
>>
>>
>>
>>  
>>
> 
> 
