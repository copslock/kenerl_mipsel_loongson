Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2003 10:27:48 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:20206 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225702AbTACK1r>;
	Fri, 3 Jan 2003 10:27:47 +0000
Received: from localhost (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id CAA26202
	for <linux-mips@linux-mips.org>; Fri, 3 Jan 2003 02:27:26 -0800
Subject: unaligned handler problem
From: Pete Popov <ppopov@mvista.com>
To: linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1041589762.18883.4.camel@adsl.pacbell.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 03 Jan 2003 02:29:22 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

The changes betwen rev 1.23 and 1.24 in unaligned.c, to replace
check_axs() with verify_area(), causes any unaligned access from within
a kernel module to crash. access_ok() returns -EFAULT as the
__access_mask is 0xffffffff so __access_ok evaluates to > 0.  It's too
late for me to look into it any further but perhaps the problem will be
obvious to someone else. I'm not sure what get_fs() should return in
this case (again, the access is from within a kernel module) but it
returns 0xffffffff.

Pete
