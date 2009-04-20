Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2009 08:37:50 +0100 (BST)
Received: from mail.sysgo.com ([62.8.134.5]:56518 "EHLO mail.sysgo.com")
	by ftp.linux-mips.org with ESMTP id S20031368AbZDTHhn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Apr 2009 08:37:43 +0100
Received: by mail.sysgo.com (Postfix, from userid 1001)
	id 1F00F6001D; Mon, 20 Apr 2009 09:37:35 +0200 (CEST)
Received: from mail.sysgo.com (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 015C96001F
	for <linux-mips@linux-mips.org>; Mon, 20 Apr 2009 09:37:26 +0200 (CEST)
Received: from www.sysgo.com (www.sysgo.com [62.8.134.6])
	by mail.sysgo.com (Postfix) with ESMTP id E91F16001D
	for <linux-mips@linux-mips.org>; Mon, 20 Apr 2009 09:37:25 +0200 (CEST)
Received: by www.sysgo.com (Postfix, from userid 33)
	id 2DC2813430D; Mon, 20 Apr 2009 09:37:25 +0200 (CEST)
Received: from 192.100.130.228 ([192.100.130.228]) 
	by www.sysgo.com (IMP) with HTTP 
	for <cam@172.20.1.30>; Mon, 20 Apr 2009 09:37:25 +0200
Message-ID: <1240213045.49ec26350fa49@www.sysgo.com>
Date:	Mon, 20 Apr 2009 09:37:25 +0200
From:	Carlos Mitidieri <cam@sysgo.com>
To:	linux-mips@linux-mips.org
Subject: Boot program interface
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 192.100.130.228
X-AV-Checked: ClamAV using ClamSMTP
Return-Path: <cam@sysgo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cam@sysgo.com
Precedence: bulk
X-list: linux-mips

Hello,

I am working on a project that requires an extensive boot program interface.

It turns out that the device tree used on PPC architecture meets the
requirements.

I have been looking, and I could not find any similar concept implemented for
MIPS.

So, I am now considering to port the OFDT library into the MIPS arch.

What do you think about this? Is there anyone working on a similar project?

Best regards,

-- 
Carlos Mitidieri
Project Engineer
