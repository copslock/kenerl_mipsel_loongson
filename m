Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2006 16:03:53 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:39172 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133791AbWCBQDo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Mar 2006 16:03:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k22GBabQ012532
	for <linux-mips@linux-mips.org>; Thu, 2 Mar 2006 16:11:36 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k22GBaeh012531
	for linux-mips@linux-mips.org; Thu, 2 Mar 2006 16:11:36 GMT
Date:	Thu, 2 Mar 2006 16:11:36 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: DDB5074 and DDB5476 eval boards
Message-ID: <20060302161136.GA12460@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Both boards don't compile anymore since include/linux/kbd_ll.h was removed
and nobody did complain making them perfect candidates for somebody who
either wants to take over maintenance or alternatively, removal of the
code.  Anybody still interested?

  Ralf
