Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2008 10:45:01 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:57042 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S28574329AbYHAJk3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2008 10:40:29 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 18F03C80C8;
	Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id rTJnsSLGTIk2; Fri,  1 Aug 2008 12:40:21 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id E256DC8011;
	Fri,  1 Aug 2008 12:40:21 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id B36F210806C; Fri,  1 Aug 2008 12:40:21 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	rpjday@crashcourse.ca
Subject: [PATCH 0/7] [MIPS] Configuration namespace cleanups, dead code elimination
Date:	Fri,  1 Aug 2008 12:40:14 +0300
Message-Id: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Hi Ralf,

A small round of house cleaning once again, this time inspired
by Robert P. J. Day's reports.

Please consider.

Thanks,
Dmitri Vorobiev
