Received:  by oss.sgi.com id <S42346AbQHXHc3>;
	Thu, 24 Aug 2000 00:32:29 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:55305 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42285AbQHXHcG>; Thu, 24 Aug 2000 00:32:06 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id AAA00029
	for <linux-mips@oss.sgi.com>; Thu, 24 Aug 2000 00:37:53 -0700 (PDT)
	mail_from (agx@gandalf.physik.uni-konstanz.de)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA93347
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 24 Aug 2000 00:31:19 -0700 (PDT)
	mail_from (agx@gandalf.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA04923
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Aug 2000 00:31:16 -0700 (PDT)
	mail_from (agx@gandalf.physik.uni-konstanz.de)
Received: from bilbo.physik.uni-konstanz.de [134.34.144.31] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 2.05 #1 (Debian))
	id 13RrTT-00048W-00; Thu, 24 Aug 2000 09:30:55 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 2.05 #1 (Debian))
	id 13RrTT-0007p6-00; Thu, 24 Aug 2000 09:30:55 +0200
Date:   Thu, 24 Aug 2000 09:30:55 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Gabriel Nava Vazquez <gnava@sirio.tecmor.mx>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: XFree86 in Indy
Message-ID: <20000824093055.B30018@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: Gabriel Nava Vazquez <gnava@sirio.tecmor.mx>,
	linux@cthulhu.engr.sgi.com
References: <Pine.LNX.4.21.0008231031450.16640-200000@sirio.tecmor.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0i
In-Reply-To: <Pine.LNX.4.21.0008231031450.16640-200000@sirio.tecmor.mx>; from gnava@sirio.tecmor.mx on Wed, Aug 23, 2000 at 10:33:48AM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Try adding:
Option     "shadowfb" "yes"
to the device section of your XF86Config file.
 -- Guido

On Wed, Aug 23, 2000 at 10:33:48AM -0500, Gabriel Nava Vazquez wrote:
> 
> Hello
> 
> I have linux installed in an Indy and i installed XFree86 following
> all the instructions.
> 
> When i execute xinit or startx, everything seems to be ok, the display
> jumps to tty7 but there is not image.  If i check the terminal from i
> executed x11, there is no messages about errors, and if y do a ps x, 
> there are all the process alive (x, xterm, etc).
> 
> Can you help me? Do you have any experience with the xserver?
> 
> Thanks
> 
> Ing. Gabriel Nava
> Instituto Tecnologico de Morelia, 
> Mexico

-- 
GPG-Public Key: finger agx@debian.org
