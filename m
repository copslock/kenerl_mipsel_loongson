Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2007 17:21:52 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:59149 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20024726AbXHXQVo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Aug 2007 17:21:44 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 9B150D8D3; Fri, 24 Aug 2007 16:21:07 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 1A2B55437A; Fri, 24 Aug 2007 18:20:45 +0200 (CEST)
Date:	Fri, 24 Aug 2007 18:20:44 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: kobject_add failed for vcs1 with -EEXIST
Message-ID: <20070824162044.GB7029@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I just booted a current git kernel on a Fulong mini-PC and saw the
following in dmesg:

VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 128k freed
kobject_add failed for vcs1 with -EEXIST, don't try to register things with the
same name in the same directory.
Call Trace:
[<80108470>] dump_stack+0x8/0x34
[<80233f10>] kobject_shadow_add+0x190/0x1e0
[<80298c70>] device_add+0xdc/0x6fc
[<80299908>] device_create+0x94/0x11c
[<8027fea4>] vcs_make_sysfs+0x44/0x84
[<80288a14>] con_open+0xa4/0xc4
[<80277658>] tty_open+0x17c/0x350
[<80187478>] chrdev_open+0xb4/0x214
[<8018163c>] __dentry_open+0xec/0x31c
[<8018194c>] nameidata_to_filp+0x4c/0x64
[<801819c4>] do_filp_open+0x60/0x7c
[<80181a4c>] do_sys_open+0x6c/0x120
[<8010af04>] stack_done+0x20/0x3c

and the same for vcsa1.

Any idea what this means?
-- 
Martin Michlmayr
http://www.cyrius.com/
