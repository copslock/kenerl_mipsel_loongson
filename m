Received:  by oss.sgi.com id <S42210AbQFWQYj>;
	Fri, 23 Jun 2000 09:24:39 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:44388 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42182AbQFWQYS>; Fri, 23 Jun 2000 09:24:18 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA00650
	for <linux-mips@oss.sgi.com>; Fri, 23 Jun 2000 09:29:29 -0700 (PDT)
	mail_from (guido.guenther@gmx.net)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA19837
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 23 Jun 2000 09:23:45 -0700 (PDT)
	mail_from (guido.guenther@gmx.net)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA02278
	for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jun 2000 09:23:44 -0700 (PDT)
	mail_from (guido.guenther@gmx.net)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 135WFD-0004bU-00; Fri, 23 Jun 2000 18:23:51 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Fri, 23 Jun 2000 18:17:38 +0200
Date:   Fri, 23 Jun 2000 18:17:37 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: XFree 4.0.1 on mips, mipsel
Message-ID: <20000623181736.A13410@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@gmx.net>,
	linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I've submitted several patches to the XFree-Project to include at least
basic support for mips/mipsel architecture. These are based on previous
work done by Ralf Baechle, Ulf Carlson, Gleb O. Reiko & Nina A.
Podolskaya. I hope I didn't break anything.
The patches are known to work on the Indy but are AFAIK untested on other 
mips machines and appear in the alpha version of xfree which can be checked 
out of the repository at sourceforge, see: http://www.xfree86.org/cvs/
Regards,
 -- Guido

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
