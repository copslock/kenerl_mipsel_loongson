Received:  by oss.sgi.com id <S553769AbRBRTAY>;
	Sun, 18 Feb 2001 11:00:24 -0800
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:56214 "EHLO
        mta6.snfc21.pbi.net") by oss.sgi.com with ESMTP id <S553788AbRBRS77>;
	Sun, 18 Feb 2001 10:59:59 -0800
Received: from pacbell.net ([63.194.214.47])
 by mta6.snfc21.pbi.net (Sun Internet Mail Server sims.3.5.2000.01.05.12.18.p9)
 with ESMTP id <0G8Y00076V6UMG@mta6.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Sun, 18 Feb 2001 10:54:30 -0800 (PST)
Date:   Sun, 18 Feb 2001 10:58:07 -0800
From:   ppopov@pacbell.net
Subject: redhat 7.0
To:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Message-id: <3A901B3F.ADADC601@pacbell.net>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: bg, en
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Has anyone tried installing 7.0 that's on oss.sgi.com?  The problem I'm
running into is that after I netboot and mount simple-0.2b as the root
fs, and install the rpm-4.0 tarball, rpm doesn't work with the
libraries, or lack of, of that root fs.  It looks like I need an fs with
a working rpm-4.0, so that I can mount my second disk somewhere and
install the 7.0 packages.  Any suggestions?

Pete
