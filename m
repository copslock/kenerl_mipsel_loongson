Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Feb 2009 20:07:05 +0000 (GMT)
Received: from ix.technologeek.org ([213.41.253.186]:15591 "EHLO
	sonic.technologeek.org") by ftp.linux-mips.org with ESMTP
	id S20807911AbZBVUHC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Feb 2009 20:07:02 +0000
Received: by sonic.technologeek.org (Postfix, from userid 1000)
	id 6D79F185592E; Sun, 22 Feb 2009 21:07:02 +0100 (CET)
From:	Julien BLACHE <jb@jblache.org>
To:	linux-mips@linux-mips.org
Subject: (Newport) console problems on IP22
Date:	Sun, 22 Feb 2009 21:07:02 +0100
Message-ID: <873ae6ck2h.fsf@sonic.technologeek.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.21 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jb@jblache.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jb@jblache.org
Precedence: bulk
X-list: linux-mips

Hi,

Martin Michlmayr offered a build of 2.6.29-rc5 for test to
debian-mips, and that kernel is showing console-related issues on my
IP22.

I'm not sure what's going, so here are my observations:
 - the Newport console is not detected anymore
 - getty process stuck

 root      1226 98.7  0.0      0     0 tty1     Rs+  19:48   9:22 [getty]

gettys on tty[2-6] might also be stuck somewhere. Can't strace the
getty on tty1 (operation not permitted) and strace on tty[2-6]
attaches to the process but doesn't print anything and is stuck from
here on. Cannot detach or anything. Processes are of course
unkillable.

 - dmesg fills up with 

 tty_release_dev: tty1: read/write wait queue active!


No keyboard/screen attached, serial console only.

Does that ring any bell wrt recent tty changes? Any idea?

JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org>                                  GPG KeyID 0xF5D65169
