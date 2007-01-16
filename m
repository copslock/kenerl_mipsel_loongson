Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 16:37:05 +0000 (GMT)
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42967 "EHLO
	ebiederm.dsl.xmission.com") by ftp.linux-mips.org with ESMTP
	id S20041430AbXAPQhB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 16:37:01 +0000
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Debian-2) with ESMTP id l0GGYSew000719;
	Tue, 16 Jan 2007 09:34:28 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Submit) id l0GGXl8M000468;
	Tue, 16 Jan 2007 09:33:47 -0700
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
From:	ebiederm@xmission.com (Eric W. Biederman)
To:	Andrew Morton <akpm@osdl.org>
Cc:	<linux-kernel@vger.kernel.org>,
	Linux Containers <containers@lists.osdl.org>,
	<netdev@vger.kernel.org>, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
	linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
	minyard@acm.org, openipmi-developer@lists.sourceforge.net,
	<tony.luck@intel.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, linux390@de.ibm.com,
	linux-390@vm.marist.edu, paulus@samba.org, linuxppc-dev@ozlabs.org,
	lethal@linux-sh.org, lethal@linux-sh.org,
	linuxsh-shmedia-dev@lists.sourceforge.net, <ak@suse.de>,
	vojtech@suse.cz, clemens@ladisch.de, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, linux-parport@lists.infradead.org,
	andrea@suse.de, tim@cyberelk.net, philb@gnu.org,
	aharkes@cs.cmu.edu, coda@cs.cmu.edu,
	codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
	linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
	kurt.hackel@oracle.com
Subject: [PATCH 0/59] Cleanup sysctl 
Date:	Tue, 16 Jan 2007 09:33:47 -0700
Message-ID: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips


There has not been much maintenance on sysctl in years, and as a result is
there is a lot to do to allow future interesting work to happen, and being
ambitious I'm trying to do it all at once :)

The patches in this series fall into several general categories.

- Removal of useless attempts to override the standard sysctls

- Registers of sysctl numbers in sysctl.h so someone else does not use
  the magic number and conflict.

- C99 conversions so it becomes possible to change the layout of 
  struct ctl_table without breaking everything.

- Removal of useless claims of module ownership, in the proc dir entries

- Removal of sys_sysctl support where people had used conflicting sysctl
  numbers. Trying to break glibc or other applications by changing the
  ABI is not cool.  9 instances of this in the kernel seems a little
  extreme.

- General enhancements when I got the junk I could see out.

Odds are I missed something, most of the cleanups are simply a result of
me working on the sysctl core and glancing at the users and going: What?

Eric
