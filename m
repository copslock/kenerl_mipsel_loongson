Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2004 21:03:22 +0100 (BST)
Received: from mail.supercable.net.ve ([IPv6:::ffff:216.72.155.13]:39901 "EHLO
	supercable.net.ve") by linux-mips.org with ESMTP
	id <S8226107AbUGHUDR>; Thu, 8 Jul 2004 21:03:17 +0100
Received: from [200.85.73.10] (unverified [200.85.73.10]) 
	by supercable.net.ve (TRUE) with ESMTP id 7711177 
	for <linux-mips@linux-mips.org>; Thu, 08 Jul 2004 16:02:49 GMT -4
Message-ID: <40EDA87E.3060509@kanux.com>
Date: Thu, 08 Jul 2004 16:03:10 -0400
From: Ricardo Mendoza <ricardo.mendoza@kanux.com>
Reply-To: ricardo.mendoza@kanux.com
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [Fwd: Re: sharp mobilon hc-4100]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Server: High Performance Mail Server - http://surgemail.com
X-Authenticated-User: numen Domain supercable.net.ve
Return-Path: <ricardo.mendoza@kanux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricardo.mendoza@kanux.com
Precedence: bulk
X-list: linux-mips

Volker Jahns wrote:

> 
> Modifications are certainly a must:
> 
> e.g. 2.4.20 in drivers/video/tx3912fb.h thereis _only_  framebuffer definitions for the nino:
> <pre>
> #if defined(CONFIG_NINO_4MB) || defined(CONFIG_NINO_8MB)
> #define FB_X_RES       240 
> #define FB_Y_RES       320
> #if defined(CONFIG_FBCON_CFB4)
> #define FB_BPP         4
> </pre>
> 
> while 2.4.0-test9 carries the _good_ information for the velo 1, velo 500 and for the helio ( the code for the nino is missing here). In drivers/video/r3912fb.h ( which seems to be the historic version of tx3912fb.h, ouch what a chaos :-(
> <pre>
> #ifdef CONFIG_PHILIPS_VELO
> #       ifdef CONFIG_PHILIPS_VELO1
> #               define FB_X_RES         480
> #       elif defined(CONFIG_PHILIPS_VELO500)
> #               define FB_X_RES         640
> #       endif
> #       define  FB_Y_RES        240
> #       ifdef CONFIG_PHILIPS_VELO_4GRAY
> #               define FB_BPP   2
> #       else /* CONFIG_PHILIPS_VELO_16GRAY */
> #               define FB_BPP   4
> #       endif
> #       define FB_IS_GREY     1
> #       define FB_IS_INVERSE  0
> #       define VIDEORAM_SIZE  (FB_X_RES * FB_Y_RES * FB_BPP / 8)
> </pre>
> 
> On the other hand the mobilon needs 
> <pre>
> #               define FB_X_RES         640
> #               define FB_X_RES         240
> #               define FB_BPP           4
> </pre>
> 
> This information ( and what else which might be of interest to make the LCD working on this thing) must have get lost on the kernel's way. I really wonder where to find a more or less functional version of the kernel code to start with.
> 

The 2.4.17 tree on Steven J. Hill's website is functional, I can give it
  to you if you cant find it, just let me know.

By the way, when I refer to functional is for the TX3912 generic stuff,
one thing for sure is that you _WILL_ need to make an specific machine
directory for the mobilon, and you can use the same code for it, after
removing the non-generic tx3912 stuff and perhaps changing some stuff
that matters only to the mobilon.

You can also try hacking on the nino files as if you were using a nino.

P.D. Remove the html tags

-- 
Ricardo Mendoza Meinhardt
ricardo.mendoza@kanux.com

.knxTech
Administrador Linux
Programador/PHP

"get ready for a bit of the old Ultra Violence"
