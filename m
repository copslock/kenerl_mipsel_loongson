Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2004 20:16:20 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.176]:47341
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225297AbUGHTQQ>; Thu, 8 Jul 2004 20:16:16 +0100
Received: from [212.227.126.208] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1BieNN-0005pd-00; Thu, 08 Jul 2004 21:16:09 +0200
Received: from [84.128.28.95] (helo=ikarus.thalreit)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1BieNN-0003la-00; Thu, 08 Jul 2004 21:16:09 +0200
Received: by ikarus.thalreit (Postfix, from userid 501)
	id E6D073368C; Thu,  8 Jul 2004 21:26:25 +0200 (CEST)
Date: Thu, 8 Jul 2004 21:26:25 +0200
From: Volker Jahns <volker@thalreit.de>
To: Ricardo Mendoza <ricardo.mendoza@kanux.com>
Cc: linux-mips@linux-mips.org
Subject: Re: sharp mobilon hc-4100
Message-ID: <20040708192625.GB9312@ikarus.thalreit>
Mail-Followup-To: Ricardo Mendoza <ricardo.mendoza@kanux.com>,
	linux-mips@linux-mips.org
References: <33009.194.59.120.11.1089291164.squirrel@thalreit.dyndns.org> <40ED9097.6040800@kanux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ED9097.6040800@kanux.com>
User-Agent: Mutt/1.4i
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5b79f71352ef1364d4beaa70fe75636d
Return-Path: <volker@thalreit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: volker@thalreit.de
Precedence: bulk
X-list: linux-mips

On Thu, Jul 08, 2004 at 02:21:11PM -0400, Ricardo Mendoza wrote:
> Volker Jahns wrote:
> >Linux on Sharp Mobilon HC-4100
> >
> >I would like to have Linux boot on the Sharp HC-4100 and have tried a
> >couple of suitable kernels with the following outcome:
> >

...


> It would help to check your config, I can assure you that the 2.4.17 
> nino code is working, I use it myself but on the nino, it might require 
> some modifications for the Mobilon.

Modifications are certainly a must:

e.g. 2.4.20 in drivers/video/tx3912fb.h thereis _only_  framebuffer definitions for the nino:
<pre>
#if defined(CONFIG_NINO_4MB) || defined(CONFIG_NINO_8MB)
#define FB_X_RES       240 
#define FB_Y_RES       320
#if defined(CONFIG_FBCON_CFB4)
#define FB_BPP         4
</pre>

while 2.4.0-test9 carries the _good_ information for the velo 1, velo 500 and for the helio ( the code for the nino is missing here). In drivers/video/r3912fb.h ( which seems to be the historic version of tx3912fb.h, ouch what a chaos :-(
<pre>
#ifdef CONFIG_PHILIPS_VELO
#       ifdef CONFIG_PHILIPS_VELO1
#               define FB_X_RES         480
#       elif defined(CONFIG_PHILIPS_VELO500)
#               define FB_X_RES         640
#       endif
#       define  FB_Y_RES        240
#       ifdef CONFIG_PHILIPS_VELO_4GRAY
#               define FB_BPP   2
#       else /* CONFIG_PHILIPS_VELO_16GRAY */
#               define FB_BPP   4
#       endif
#       define FB_IS_GREY     1
#       define FB_IS_INVERSE  0
#       define VIDEORAM_SIZE  (FB_X_RES * FB_Y_RES * FB_BPP / 8)
</pre>

On the other hand the mobilon needs 
<pre>
#               define FB_X_RES         640
#               define FB_X_RES         240
#               define FB_BPP           4
</pre>

This information ( and what else which might be of interest to make the LCD working on this thing) must have get lost on the kernel's way. I really wonder where to find a more or less functional version of the kernel code to start with.

-- 
Volker Jahns, Volker.Jahns@thalreit.de, http://thalreit.de, DG7PM
