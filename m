Received:  by oss.sgi.com id <S42339AbQHYUUI>;
	Fri, 25 Aug 2000 13:20:08 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:41740 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42310AbQHYUTf>;
	Fri, 25 Aug 2000 13:19:35 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 0E30A80E; Fri, 25 Aug 2000 22:22:35 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 23BBF8FF5; Fri, 25 Aug 2000 22:16:20 +0200 (CEST)
Date:   Fri, 25 Aug 2000 22:16:20 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: no controlling tty on mipsel
Message-ID: <20000825221620.A1280@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
with the declinux root and the glibc 2.0.6-5lm (Current rpm)
i get the following error on BOTH decstations i have up and
running (Both R4000)

[flo@reconfig most]$ scp *.deb *.changes root@repeat.rfc822.org:/ftp.rfc822.org/packages
You have no controlling tty.  Cannot read passphrase.

lost connection

[flo@reconfig most]$ tty
/dev/ttyp0

Hmmm ... 

Ideas ?

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
