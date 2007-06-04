Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 16:42:12 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.168]:47880 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022488AbXFDPlW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Jun 2007 16:41:22 +0100
Received: by ug-out-1314.google.com with SMTP id m3so851221ugc
        for <linux-mips@linux-mips.org>; Mon, 04 Jun 2007 08:41:19 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        b=DRUCGnWCke8lzP25Y+q99evcQ68CphuHF5Fuqxjr5WFnVZM/HdbDs5JOS1K4zCVcU06RwY+WsOvRUjycq2h68yvmXH3YlRj75f81RsCFBKg9vwALsM2TTFLnuBiVFUkSBtfh9t3Kwuuq23OKzcEYWdRtdFFt2r+5jd03kuhYskY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=qndoaH41cOur+1qjrlsLBHvYKSNy89kR5PW0M2wKCXi/znChgPJfjyBDqu6BtzjQELiwvpCdv58XmDb3nGQiH0Z7oyL1SxvZ3VkP4OY+c8YHqFf/1RQeKmnAiUlck+K8KtJuJKUGGi3m5fkwQ9ou/Fa9r8DzdNv07L0M7qgdMug=
Received: by 10.67.27.3 with SMTP id e3mr3173228ugj.1180971679118;
        Mon, 04 Jun 2007 08:41:19 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id y34sm1086780iky.2007.06.04.08.41.16;
        Mon, 04 Jun 2007 08:41:17 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id D2F5923F76E; Mon,  4 Jun 2007 17:46:35 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 0/5] PHYS_OFFSET fix and cleanup [take #2]
Date:	Mon,  4 Jun 2007 17:46:30 +0200
Message-Id: <1180971995757-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.4
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patchset is an updated version of the following one:

http://marc.info/?l=linux-mips&m=117499082903803&w=2
http://marc.info/?l=linux-mips&m=117499090603935&w=2
http://marc.info/?l=linux-mips&m=117499083003809&w=2
http://marc.info/?l=linux-mips&m=117499086003851&w=2
http://marc.info/?l=linux-mips&m=117499088403902&w=2

It builds on ip-{22,27,32} now and have more clean up for spaces.h.

Please consider,

		Franck
