Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2006 13:42:34 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:46340 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133437AbWAVNmO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Jan 2006 13:42:14 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 5CA8D64D3D; Sun, 22 Jan 2006 13:46:18 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 13A758545; Sun, 22 Jan 2006 13:45:53 +0000 (GMT)
Date:	Sun, 22 Jan 2006 13:45:53 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc:	linux-mips@linux-mips.org
Subject: DECstation fails to compile with iomap patch applied
Message-ID: <20060122134553.GA27266@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

DECstation fails to compile when your iomap patch is applied.  (FWIW,
DECstations don't have PCI at all, only TurboCHANNEL).

  CC      arch/mips/lib/iomap.o
arch/mips/lib/iomap.c: In function ‘pci_iomap’:
arch/mips/lib/iomap.c:66: error: ‘_CACHE_CACHABLE_COW’ undeclared (first use in this function)
arch/mips/lib/iomap.c:66: error: (Each undeclared identifier is reported only once
arch/mips/lib/iomap.c:66: error: for each function it appears in.)
make[1]: *** [arch/mips/lib/iomap.o] Error 1

-- 
Martin Michlmayr
http://www.cyrius.com/
