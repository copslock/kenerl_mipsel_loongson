Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:25:36 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:33551 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8126537AbWCTEZ0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:25:26 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id CBDE064D3D; Mon, 20 Mar 2006 04:35:02 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 5E0B966ED5; Mon, 20 Mar 2006 04:34:45 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:34:45 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, akpm@osdl.org
Subject: Bring linux-mips in sync with Linus' tree
Message-ID: <20060320043445.GA20171@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

The following is a series of six patches to bring the linux-mips tree
in sync with Linus' tree.  These are changes that have to be made
on the linux-mips side.  Another series will be posted for inclusion
in -mm to bring the Linus' tree in sync with linux-mips where
necessary.

[PATCH 1/6] [CHAR] Remove obsolete IBM z50 (vr41xx) keyboard map
[PATCH 2/6] [VIDEO] Remove trailing whitespace from drivers/video/Kconfig
[PATCH 3/6] Remove bogus blank lines - sync with Linus' tree
[PATCH 4/6] [NET] Fix NET_SB1250_MAC Kconfig order to match Linus' tree
[PATCH 5/6] [MIPS] vr41xx: remove timex.h
[PATCH 6/6] [MTD] Remove typecast from drivers/mtd/maps/lasat.c

-- 
Martin Michlmayr
http://www.cyrius.com/
