Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2007 19:32:08 +0000 (GMT)
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30414 "EHLO
	ebiederm.dsl.xmission.com") by ftp.linux-mips.org with ESMTP
	id S28578025AbXAQTcE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Jan 2007 19:32:04 +0000
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Debian-2) with ESMTP id l0HJVO7Y017089;
	Wed, 17 Jan 2007 12:31:24 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Submit) id l0HJVMOI017088;
	Wed, 17 Jan 2007 12:31:22 -0700
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
From:	ebiederm@xmission.com (Eric W. Biederman)
To:	Kirill Korotaev <dev@sw.ru>
Cc:	"<Andrew Morton" <akpm@osdl.org>, James.Bottomley@SteelEye.com,
	linux-mips@linux-mips.org, linux-parport@lists.infradead.org,
	minyard@acm.org, rtc-linux@googlegroups.com, clemens@ladisch.de,
	heiko.carstens@de.ibm.com, xfs@oss.sgi.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	openipmi-developer@lists.sourceforge.net, linux-390@vm.marist.edu,
	schwidefsky@de.ibm.com, tim@cyberelk.net,
	codalist@TELEMANN.coda.cs.cmu.edu, a.zummo@towertech.it,
	tony.luck@intel.com, vojtech@suse.cz, linux-scsi@vger.kernel.org,
	xfs-masters@oss.sgi.com, linux-ntfs-dev@lists.sourceforge.net,
	netdev@vger.kernel.org, aia21@cantab.net, aharkes@cs.cmu.edu,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	mark.fasheh@oracle.com, coda@cs.cmu.edu, lethal@linux-sh.org,
	kurt.hackel@oracle.com, containers@lists.osdl.org,
	linux390@de.ibm.com, philb@gnu.org, andrea@suse.de,
	linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de
Subject: Re: [PATCH 50/59] sysctl: Move utsname sysctls to their own file
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<11689656853154-git-send-email-ebiederm@xmission.com>
	<45AE5FDC.5050603@sw.ru>
Date:	Wed, 17 Jan 2007 12:31:22 -0700
In-Reply-To: <45AE5FDC.5050603@sw.ru> (Kirill Korotaev's message of "Wed, 17
	Jan 2007 20:41:48 +0300")
Message-ID: <m1ps9d8n79.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

Kirill Korotaev <dev@sw.ru> writes:

> Eric, though I personally don't care much:
> 1. I ask for not setting your authorship/copyright on the code which you just
> copied
>   from other places. Just doesn't look polite IMHO.

I can't claim complete ownership of the code, there was plenty of feed back
and contributions from others but the final form without a big switch
statement is mine.  I certainly can't claim the table, it has been in
that form for years.

If you notice I actually didn't say whose copyright it was :)  just
that I wrote the file.

If there are copyright claims I should include I will be happy to do that.
Mostly I was just trying to find some stupid boiler plate that would work.

> 2. I would propose to not introduce utsname_sysctl.c.
>   both files are too small and minor that I can't see much reasons splitting
> them.

The impact of moving this code out of sysctl.c is a major
simplification, to sysctl.c.  Putting them in their own file means we
can cleanly restrict the code to only be compiled CONFIG_SYSCTL is set.

It is a necessary first step to implementing a per process /proc/sys.

It reorganizes the ipc and utsname sysctl from a terribly fragile
structure to something that is robust and easy to follow.  Code
scattered all throughout sysctl.c was just a disaster.  We had
several instances of having to fix bugs with odd combinations of
CONFIG options, simply because the other spot that needed to be touched
wasn't obvious.

So from my perspective this is an extremely worthwhile change that
will make maintenance easier and is a small first step towards
some nice future functionality.

Eric
