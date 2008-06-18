Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2008 08:18:45 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:9654 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20025249AbYFRHRO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2008 08:17:14 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 3B48DC80DA;
	Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id lIL3Zl9fWfcF; Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 1ACF4C80D3;
	Wed, 18 Jun 2008 10:17:09 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id A0A52B404B; Wed, 18 Jun 2008 10:18:22 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0/5] [MIPS] Another round of nitpicking
Date:	Wed, 18 Jun 2008 10:18:18 +0300
Message-Id: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.5.GIT
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Following is another set of some janitorial stuff to somehow reduce
sparse noise and clean the global namespace up.

Please consider.

Thanks,
Dmitri Vorobiev
