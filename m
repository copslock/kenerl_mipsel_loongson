Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Mar 2009 03:02:00 +0000 (GMT)
Received: from colo.lackof.org ([198.49.126.79]:38536 "EHLO colo.lackof.org")
	by ftp.linux-mips.org with ESMTP id S21370459AbZCXDBy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Mar 2009 03:01:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by colo.lackof.org (Postfix) with ESMTP id 0EAA1818A
	for <linux-mips@linux-mips.org>; Mon, 23 Mar 2009 21:01:47 -0600 (MDT)
Received: from colo.lackof.org ([127.0.0.1])
	by localhost (colo.lackof.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02099-04 for <linux-mips@linux-mips.org>;
	Mon, 23 Mar 2009 21:01:35 -0600 (MDT)
Received: by colo.lackof.org (Postfix, from userid 1012)
	id 80C0B8188; Mon, 23 Mar 2009 21:01:33 -0600 (MDT)
Date:	Mon, 23 Mar 2009 21:01:33 -0600
From:	dann frazier <dannf@dannf.org>
To:	linux-mips@linux-mips.org
Subject: syscall wrapper changes cause llseek failure
Message-ID: <20090324030132.GA29907@colo.lackof.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lackof.org
Return-Path: <dannf@lackof.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dannf@dannf.org
Precedence: bulk
X-list: linux-mips

hey,
 I had a report today of a possible regression caused by the syscall
wrapper changes. On a pristine 64-bit 2.6.29-rc8 kernel, llseek seems
to always return -EINVAL. This was noticed on one of the Debian
infrastructure machines where, after an upgrade, e2fsck began failing
with errors like:

  Error reading block 524290 (Invalid argument) while getting next inode
  from scan.  Ignore error<y>? 

I believe this is due to the syswrapper changes because its easy to
reproduce with Debian's 2.6.26 patched w/ the syswrapper changes, but
goes away if we back the syswrapper changes back out.

I compared strace output between a working and failing kernel:

no syscall wrappers:
_llseek(3, 2147491840, [2147491840], SEEK_SET) = 0
_llseek(3, 2147524608, [2147524608], SEEK_SET) = 0

syscall wrappers:
_llseek(3, 2147491840, 0x7fa5d7f0, SEEK_SET) = -1 EINVAL (Invalid argument)
_llseek(3, 2147491840, 0x7fa5d6d0, SEEK_SET) = -1 EINVAL (Invalid argument)

config is available here;
 http://dannf.org/mips.config

-- 
dann frazier
