Received:  by oss.sgi.com id <S305171AbQEQRLs>;
	Wed, 17 May 2000 17:11:48 +0000
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:40547 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQEQRL3>; Wed, 17 May 2000 17:11:29 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA06683; Wed, 17 May 2000 10:16:00 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA27923
	for linux-list;
	Wed, 17 May 2000 10:01:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA10979
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 May 2000 10:01:27 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA00591
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 May 2000 10:01:26 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 12s7Bc-0006jJ-00; Wed, 17 May 2000 19:00:44 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Wed, 17 May 2000 18:59:26 +0200
Date:   Wed, 17 May 2000 18:59:26 +0200
From:   Guido Guenther <agx@bert.physik.uni-konstanz.de>
To:     Gabriel Nava Vazquez <gnava@sirio.tecmor.mx>
Cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: xfree86 on an indy
Message-ID: <20000517185925.B27936@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@uni-konstanz.de>,
	Gabriel Nava Vazquez <gnava@sirio.tecmor.mx>, linux-mips@fnet.fr,
	linux@cthulhu.engr.sgi.com
References: <20000513162907.A16713@bert.physik.uni-konstanz.de> <Pine.LNX.4.10.10005171103100.14173-100000@sirio.tecmor.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <Pine.LNX.4.10.10005171103100.14173-100000@sirio.tecmor.mx>; from gnava@sirio.tecmor.mx on Wed, May 17, 2000 at 11:04:05AM -0500
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Fetch the X400src-1.tgz from any xfree86 mirror near you and apply the
latest patch found at http://honk.physik.uni-konstanz.de/~agx/mipslinux/x.
Then follow the instructions in xc/INSTALL.TXT. 
I'm using a self compiled kernel from the snapshot:
ftp://ftp.linux.sgi.com/pub/linux/mips/test/linux-2.2.13-20000211.tar.bz2
since I had little luck with later versions from cvs.
Note that the xserver is currently of little use since the mouse is not
working(SIGIO problem).
Regards,
 -- Guido

On Wed, May 17, 2000 at 11:04:05AM -0500, Gabriel Nava Vazquez wrote:
> How can i run xfree86 on my indy box?  Which version do i need, and which
> kernel?
> 
> thanks
> 
> Ing. Gabriel Nava Vazquez
> Instituto Tecnologico de Morelia
> Mexico
> 
> 

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
