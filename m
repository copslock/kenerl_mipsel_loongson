Received:  by oss.sgi.com id <S553764AbRAURO5>;
	Sun, 21 Jan 2001 09:14:57 -0800
Received: from [194.73.73.138] ([194.73.73.138]:61636 "EHLO ruthenium")
	by oss.sgi.com with ESMTP id <S553681AbRAUROk>;
	Sun, 21 Jan 2001 09:14:40 -0800
Received: from [62.7.73.167] (helo=tardis)
	by ruthenium with esmtp (Exim 3.03 #83)
	id 14KO4X-0005MT-00
	for linux-mips@oss.sgi.com; Sun, 21 Jan 2001 17:14:34 +0000
Date:   Sun, 21 Jan 2001 17:10:57 +0000 (GMT)
From:   Dave Gilbert <gilbertd@treblig.org>
X-Sender: gilbertd@tardis.home.dave
To:     linux-mips@oss.sgi.com
Subject: My Indy boots!
Message-ID: <Pine.LNX.4.10.10101211707370.964-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
  With thanks to the guys on the #mipslinux IRC channel my Indy (dino) is
booting.

Points:

1) I needed to put an sa=hostip in the bootp to point to my server.
2) The 2.4.x kernels will not boot from Sash on my machine - they are OK
via bootp/tftp.
3) The ncurses in the base off
/ftp.uni-mainz.de/pub/Linux/debian-local/mips/ is duff; but there is a
slightly newer ncurses in there which springs it into life.

(My green gun is going now - but my red is off - time to hack the little
lead for the 13w3).

Dave

-- 
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert      | Running GNU/Linux on Alpha, | Happy  \ 
\   gro.gilbert @ treblig.org | 68K,MIPS,x86,ARM and SPARC  | In Hex /
 \ ___________________________|___ http://www.treblig.org   |_______/
