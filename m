Received:  by oss.sgi.com id <S42314AbQFNK61>;
	Wed, 14 Jun 2000 03:58:27 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:6254 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42289AbQFNK6G>;
	Wed, 14 Jun 2000 03:58:06 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA16220
	for <linux-mips@oss.sgi.com>; Wed, 14 Jun 2000 03:53:09 -0700 (PDT)
	mail_from (guido.guenther@gmx.net)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id DAA10368 for <linux-mips@oss.sgi.com>; Wed, 14 Jun 2000 03:56:19 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA44830
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 14 Jun 2000 03:54:37 -0700 (PDT)
	mail_from (guido.guenther@gmx.net)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA07234
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jun 2000 03:54:27 -0700 (PDT)
	mail_from (guido.guenther@gmx.net)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 132Aoc-0002cj-00; Wed, 14 Jun 2000 12:54:34 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Wed, 14 Jun 2000 12:53:52 +0200
Date:   Wed, 14 Jun 2000 12:53:52 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     linux@cthulhu.engr.sgi.com
Subject: newport: glyph cursor and cmap
Message-ID: <20000614125351.A24432@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@gmx.net>,
	linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I'm currently trying to add a hw-cursor to the xserver. As far as I
understand the xmap9 docs the cursor has its own colormap on the cmap
chip sperate from the "normal" colormap. Can someone provide a small
codepiece or docs on how two manipulate this part of the cmap chip(via the
dcb)?  (i didn't find anything about the cmap chips on oss.sgi.com).
Regards,
 -- Guido

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
