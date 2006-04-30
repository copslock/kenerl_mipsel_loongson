Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Apr 2006 05:02:15 +0100 (BST)
Received: from xenotime.net ([66.160.160.81]:2784 "HELO xenotime.net")
	by ftp.linux-mips.org with SMTP id S8126506AbWD3ECE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 30 Apr 2006 05:02:04 +0100
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-mips@linux-mips.org>; Sat, 29 Apr 2006 21:01:59 -0700
Date:	Sat, 29 Apr 2006 21:01:59 -0700 (PDT)
From:	"Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To:	ralf@linux-mips.org
cc:	linux-mips@linux-mips.org
Subject: SETNAME (set nodename) in syscall.c
Message-ID: <Pine.LNX.4.58.0604292059210.24032@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <rdunlap@xenotime.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdunlap@xenotime.net
Precedence: bulk
X-list: linux-mips


Hi,

In arch/mips/syscall.c::_sys_sysmips(), case SETNAME,
isn't one of the strncpy() and strlcpy() unneeded?

		down_write(&uts_sem);
		strncpy(system_utsname.nodename, nodename, len);
		nodename[__NEW_UTS_LEN] = '\0';
		strlcpy(system_utsname.nodename, nodename,
		        sizeof(system_utsname.nodename));
		up_write(&uts_sem);


-- 
~Randy
