Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2004 19:21:24 +0100 (BST)
Received: from mail.supercable.net.ve ([IPv6:::ffff:216.72.155.13]:62416 "EHLO
	supercable.net.ve") by linux-mips.org with ESMTP
	id <S8226154AbUGHSVT>; Thu, 8 Jul 2004 19:21:19 +0100
Received: from [200.85.73.10] (unverified [200.85.73.10]) 
	by supercable.net.ve (TRUE) with ESMTP id 7708807 
	for multiple; Thu, 08 Jul 2004 14:20:50 GMT -4
Message-ID: <40ED9097.6040800@kanux.com>
Date: Thu, 08 Jul 2004 14:21:11 -0400
From: Ricardo Mendoza <ricardo.mendoza@kanux.com>
Reply-To: ricardo.mendoza@kanux.com
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Volker Jahns <Volker.Jahns@thalreit.de>, linux-mips@linux-mips.org
Subject: Re: sharp mobilon hc-4100
References: <33009.194.59.120.11.1089291164.squirrel@thalreit.dyndns.org>
In-Reply-To: <33009.194.59.120.11.1089291164.squirrel@thalreit.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Server: High Performance Mail Server - http://surgemail.com
X-Authenticated-User: numen Domain supercable.net.ve
Return-Path: <ricardo.mendoza@kanux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricardo.mendoza@kanux.com
Precedence: bulk
X-list: linux-mips

Volker Jahns wrote:
> Linux on Sharp Mobilon HC-4100
> 
> I would like to have Linux boot on the Sharp HC-4100 and have tried a
> couple of suitable kernels with the following outcome:
> 
> Booting
> -------
> netbsd tx3912               - netbsd 1.5.3 , keyboard functional
> linux for philips velo      - vmlinux-2.4.0-test4-pre3 , keyboard not
> functional
> 
> 
> Booting, but framebuffer scrambled
> ----------------------------------
> linux nino                  - vmlinux-2.4.17
> linux sharp HC-4500/HC-4600 - vmlinux-2.3.21. vmlinux-2.3.47
> 
> I have tried to compile a kernel from versions - 2.4.20 and 2.4.0-test9 -
> ( sharp mobilon, philips velo, philips nino) which all boot but have the
> framebuffer device scrambled.
> 
> Which kernel version is good to start from, and where would I find its code ?
> Has somebody a working .config vor the Velo 500 available, so that I get
> the correct options to have this damn framebuffer device working?
> 
> 
> Please redirect, in case this should be the wrong place to post.

Hi, sometimes the scrambled problem happens when you are using a linked 
inside ramdisk image and it corrupts the kernel itself in some way, it 
has happened to me quite many times with the nino kernel.

It would help to check your config, I can assure you that the 2.4.17 
nino code is working, I use it myself but on the nino, it might require 
some modifications for the Mobilon.

-- 
Ricardo Mendoza Meinhardt
ricardo.mendoza@kanux.com

.knxTech
Administrador Linux
Programador/PHP

"get ready for a bit of the old Ultra Violence"
