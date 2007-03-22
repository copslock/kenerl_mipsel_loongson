Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2007 22:30:04 +0000 (GMT)
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:42427 "EHLO
	mail-gw1.sa.eol.hu") by ftp.linux-mips.org with ESMTP
	id S20022088AbXCVWaC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Mar 2007 22:30:02 +0000
Received: from dorka.pomaz.szeredi.hu (245-248.dyn-fa.pool.ew.hu [193.226.245.248])
	by mail-gw1.sa.eol.hu (mu) with ESMTP id l2MMSrvW011397;
	Thu, 22 Mar 2007 23:28:55 +0100
Received: from miko by dorka.pomaz.szeredi.hu with local (Exim 3.36 #1 (Debian))
	id 1HUVlw-00034H-00; Thu, 22 Mar 2007 23:28:40 +0100
To:	linux-mips@linux-mips.org
CC:	Ravi.Pratap@hillcrestlabs.com
Subject: flush_anon_page for MIPS
Message-Id: <E1HUVlw-00034H-00@dorka.pomaz.szeredi.hu>
From:	Miklos Szeredi <miklos@szeredi.hu>
Date:	Thu, 22 Mar 2007 23:28:40 +0100
Return-Path: <miklos@szeredi.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miklos@szeredi.hu
Precedence: bulk
X-list: linux-mips

It seems that MIPS needs to implement flush_anon_page() for correct
operation of get_user_pages() on anonymous pages.

This function is already implemented in PARISC and ARM.  Also see
Documentation/cachetlb.txt.

Thanks,
Miklos
