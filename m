Received:  by oss.sgi.com id <S42285AbQE3BGH>;
	Mon, 29 May 2000 18:06:07 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:41011 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42289AbQE0Tjg>; Sat, 27 May 2000 12:39:36 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA01683; Sat, 27 May 2000 13:43:48 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id NAA55040; Sat, 27 May 2000 13:38:34 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA32014
	for linux-list;
	Sat, 27 May 2000 13:28:23 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA42349
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 27 May 2000 13:28:21 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA02699
	for <linux@cthulhu.engr.sgi.com>; Sat, 27 May 2000 13:28:16 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 12vnBz-0001Pf-00; Sat, 27 May 2000 22:28:19 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Sat, 27 May 2000 22:28:05 +0200
Date:   Sat, 27 May 2000 22:28:05 +0200
From:   Guido Guenther <agx@bert.physik.uni-konstanz.de>
To:     linux@cthulhu.engr.sgi.com
Subject: xserver
Message-ID: <20000527222805.A1623@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@uni-konstanz.de>,
	linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

With some small optimations the newports xserver seems to be a bit
smoother now. I've put source and binary at:
http://honk.physik.uni-konstanz.de/~agx/mipslinux/x/test
Maybe someone wants to run x11perf on it ;) I'll put up a new patch
agaisnt the xfree4.0 source tree after I've reworked more of the code.
 -- Guido

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
