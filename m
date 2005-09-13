Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2005 13:46:05 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:22047 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225223AbVIMMpu>; Tue, 13 Sep 2005 13:45:50 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8DCjid3010413
	for <linux-mips@linux-mips.org>; Tue, 13 Sep 2005 13:45:44 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8DCjiXe010412
	for linux-mips@linux-mips.org; Tue, 13 Sep 2005 13:45:44 +0100
Date:	Tue, 13 Sep 2005 13:45:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Git
Message-ID: <20050913124544.GC3224@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

As a heads up, I've started playing with GIT as the replacement of CVS.
For information on the status of that conversion please see

  http://www.linux-mips.org/wiki/Git

The converted repositories are accessible at via rsync at

  rsync://ftp.linux-mips.org/git

And there gitweb, a web frontend to replace cvsweb available at:

  http://www.linux-mips.org/wiki/git

Browse around, let me know if you find anything that doesn't work as you
want it to.

For those with write permission into CVS, for now continue using CVS
as always.  For now the conversion is still only for testing and
figuring out all the kinks.

  Ralf
