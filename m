Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2006 17:49:33 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:44425 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133742AbWCFRtM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Mar 2006 17:49:12 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k26HvWGq018660;
	Mon, 6 Mar 2006 17:57:32 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k26HvWR2018659;
	Mon, 6 Mar 2006 17:57:32 GMT
Date:	Mon, 6 Mar 2006 17:57:32 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-cvs@linux-mips.org, linux-cvs-patches@linux-mips.org,
	linux-mips@linux-mips.org
Subject: CVS commit notification list and the git conversion
Message-ID: <20060306175732.GA18027@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

As you may have noticed, the good old linux-cvs and linux-cvs-patches
mailing lists haven't received any postings since I converted the MIPS
kernel repository to git.  I now have the necessary bits and pieces in
places to resume the same kind of notifications with git.  I'm therefore
going to rename the two lists to linux-git rsp. linux-git-patches and will
have the notification catch up on postings that were not sent out due
since the conversion.

If you were subscribed to linux-cvs or linux-cvs-patches you will be
subscribed to the new list; there is nothing you will have to do.

As candy for procmail users the list has headers that looks like:
X-Git-Branch: master, X-Git-Branch: linux-2.4 etc. which can be used to
sort email.

As an implmentation choice I decieded to aggregate all commits merge from
kernel.org into a single mail rather than a large number of individual
mails, so it's going to be easier to follow what's really going on on
linux-mips.org.  In case you care about all the details of the changesets
from kernel.org as well I suggest you subscribe via majordomo to either
git-commits-head@vger.kernel.org to follow 2.6 development or
git-commits-24@vger.kernel.org for the 2.4 development.

  Ralf
