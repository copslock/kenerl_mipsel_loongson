Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jan 2003 19:44:30 +0000 (GMT)
Received: from [IPv6:::ffff:66.221.142.1] ([IPv6:::ffff:66.221.142.1]:17643
	"EHLO bisque.propagation.net") by linux-mips.org with ESMTP
	id <S8225264AbTATToT>; Mon, 20 Jan 2003 19:44:19 +0000
Received: from freehandsystems.com (adsl-64-170-127-190.dsl.snfc21.pacbell.net [64.170.127.190])
	by bisque.propagation.net (8.11.6/8.8.5) with ESMTP id h0KJiFm00985
	for <linux-mips@linux-mips.org>; Mon, 20 Jan 2003 13:44:16 -0600
Message-ID: <3E2C518B.E1596B8B@freehandsystems.com>
Date: Mon, 20 Jan 2003 11:44:11 -0800
From: Tibor Polgar <tpolgar@freehandsystems.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Is the CVS server down?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <tpolgar@freehandsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tpolgar@freehandsystems.com
Precedence: bulk
X-list: linux-mips

I'm trying to get in to suck down the 2.4.19 tree but get:

> cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs login
Logging in to :pserver:cvs@ftp.linux-mips.org:2401/home/cvs
CVS password: 
cvs [login aborted]: connect to ftp.linux-mips.org(62.254.210.162):2401
failed: Connection refused
> 

Per the website i'm using the password of "cvs" (without quotes).  Is it just
our site/firewall?

Thanks
Tibor
