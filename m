Received:  by oss.sgi.com id <S42440AbQIFUWI>;
	Wed, 6 Sep 2000 13:22:08 -0700
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.30]:26388 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S42336AbQIFUVn>; Wed, 6 Sep 2000 13:21:43 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.31] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 2.05 #1 (Debian))
	id 13WlhN-0008D5-00; Wed, 6 Sep 2000 22:21:33 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 13WlhN-0000HB-00; Wed, 06 Sep 2000 22:21:33 +0200
Date:   Wed, 6 Sep 2000 22:21:33 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     linux-mips@oss.sgi.com
Subject: latest glibc from cvs fails to build
Message-ID: <20000906222133.A1052@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
when cross-building glibc from today's cvs with gcc 2.96 (20000828) I get
the following error:
dl-reloc.c:104:50: warning: pasting would not give a valid
preprocessing token
dl-reloc.c:112:50: warning: pasting would not give a valid
preprocessing token
In file included from dynamic-link.h:21,
                 from dl-reloc.c:92:
../sysdeps/mips/dl-machine.h:542: too few arguments to function
`_dl_lookup_versioned_symbol'
../sysdeps/mips/dl-machine.h:542: too few arguments to function
`_dl_lookup_symbol'

Does this look familiar to anyone? Otherwise I'll take a look at it
later this week.
Regards,
 -- Guido

-- 
GPG-Public Key: finger agx@debian.org
