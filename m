Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2005 22:47:51 +0000 (GMT)
Received: from spinics.net ([IPv6:::ffff:66.254.95.226]:64224 "EHLO
	spinics.net") by linux-mips.org with ESMTP id <S8225313AbVCPWrg>;
	Wed, 16 Mar 2005 22:47:36 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by spinics.net (8.12.8/8.12.8) with ESMTP id j2GMlXRF017149
	for <linux-mips@linux-mips.org>; Wed, 16 Mar 2005 14:47:33 -0800
Received: (from ellis@localhost)
	by localhost.localdomain (8.12.8/8.12.8/Submit) id j2GMlXPh017146
	for linux-mips@linux-mips.org; Wed, 16 Mar 2005 14:47:33 -0800
From:	ellis@spinics.net
Message-Id: <200503162247.j2GMlXPh017146@localhost.localdomain>
Subject: Little Endian
To:	linux-mips@linux-mips.org
Date:	Wed, 16 Mar 2005 14:47:33 -0800 (PST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <ellis@spinics.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ellis@spinics.net
Precedence: bulk
X-list: linux-mips

I'm just starting to look at a porting project. The board I'll
be using is little endian and the CVS version of the kernel
source doesn't have anything but big endian in the config
menu. Does little endian work at all and if so, how do I 
select it?

--
http://www.spinics.net/linux/
