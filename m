Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2007 18:54:00 +0000 (GMT)
Received: from mx02.hansenet.de ([213.191.73.26]:7352 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20022117AbXK1Sxw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Nov 2007 18:53:52 +0000
Received: from [213.39.153.175] (213.39.153.175) by webmail.hansenet.de (7.3.118.12) (authenticated as mbx20228207@koeller-hh.org)
        id 4746D82200B8A510 for linux-mips@linux-mips.org; Wed, 28 Nov 2007 19:50:32 +0100
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id D534C47A5F
	for <linux-mips@linux-mips.org>; Wed, 28 Nov 2007 19:50:46 +0100 (CET)
From:	Thomas Koeller <thomas@koeller.dyndns.org>
To:	linux-mips@linux-mips.org
Subject: git problem
Date:	Wed, 28 Nov 2007 19:50:46 +0100
User-Agent: KMail/1.9.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711281950.46472.thomas@koeller.dyndns.org>
Return-Path: <thomas@koeller.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@koeller.dyndns.org
Precedence: bulk
X-list: linux-mips

Hi,

on my machine I have clones of both the linux-mips and
Linus' kernel tree. I recently found that git-describe
behaves differently in those trees:

bash-3.2$ cd linux-2.6.git/
bash-3.2$ git-status
# On branch master
nothing to commit (working directory clean)
bash-3.2$ git-describe bd71c182d5a02337305fc381831c11029dd17d64
v2.6.21-2747-gbd71c18
bash-3.2$ cd ../excite.git/
bash-3.2$ git-status
# On branch master
nothing to commit (working directory clean)
bash-3.2$ git-describe bd71c182d5a02337305fc381831c11029dd17d64
fatal: cannot describe 'bd71c182d5a02337305fc381831c11029dd17d64'

The commit is of course present in both trees. AFAIK the
'cannot describe' error shows if there are no tags at all,
but this is not the case; .git/refs/tags is fully populated.
Has anybody got a clue as to what may be wrong here?
-- 
Thomas Koeller
thomas at koeller dot dyndns dot org
