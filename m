Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 16:54:23 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.193]:62040 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20044821AbWHKPwi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Aug 2006 16:52:38 +0100
Received: by nz-out-0102.google.com with SMTP id i1so238203nzh
        for <linux-mips@linux-mips.org>; Fri, 11 Aug 2006 08:52:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=FqGrCEoSDFikmd6eCHEaMG6HNJtmqIIf81qcOa/0l0aHrHCZ5XvIHkblQQKYCt+TmuLdiyJf/noUfBZOJAutM4ChoTBkVE9Usfya0PSZUK2jsAh5SmMlk1JTRtV6ghJqMGqRjC8p9/nF23MQg5BVByh9TgjJ46GOb6OZuMfS8t0=
Received: by 10.65.112.3 with SMTP id p3mr4145971qbm;
        Fri, 11 Aug 2006 08:52:31 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id c5sm18182qbc.2006.08.11.08.52.29;
        Fri, 11 Aug 2006 08:52:31 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 2EB3023F76E; Fri, 11 Aug 2006 17:51:53 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp
Subject: cleanup setup.c (take #3)
Date:	Fri, 11 Aug 2006 17:51:47 +0200
Message-Id: <1155311513926-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc4
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Here's a patchset that clean up arch/mips/kernel/setup.c file.

Changes from take #2:
---------------------
- Include Atsushi Nemoto's comments.

Changes from take #1:
---------------------
- don't use "initrd=xxx@yyy" semantic anymore for passing initrd
  memory area through the command line. It sticks with the old 
  semantic for bootloader compatibilities.

		Franck

Overall diffstat:

 arch/mips/kernel/setup.c |  441 ++++++++++++++++++++--------------------------
 1 files changed, 188 insertions(+), 253 deletions(-)
