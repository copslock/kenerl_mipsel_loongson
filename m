Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2009 09:09:35 +0000 (GMT)
Received: from smtp.movial.fi ([62.236.91.34]:21975 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S21103096AbZALJJd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2009 09:09:33 +0000
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 2EC2FC80D7
	for <linux-mips@linux-mips.org>; Mon, 12 Jan 2009 11:09:25 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id BBF07XYUIt5s for <linux-mips@linux-mips.org>;
	Mon, 12 Jan 2009 11:09:25 +0200 (EET)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id F3420C8012
	for <linux-mips@linux-mips.org>; Mon, 12 Jan 2009 11:09:24 +0200 (EET)
Message-ID: <496B08C4.7000300@movial.fi>
Date:	Mon, 12 Jan 2009 11:09:24 +0200
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20090105)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: malta_defconfig build busted again
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

$ make ARCH=mips CROSS_COMPILE=mips-unknown-linux-gnu- mrproper

[skipped]

$ make ARCH=mips CROSS_COMPILE=mips-unknown-linux-gnu- malta_defconfig

[skipped]

#
# configuration written to .config
#
$ make ARCH=mips CROSS_COMPILE=mips-unknown-linux-gnu-

[skipped]

  CC      arch/mips/kernel/mips-mt-fpaff.o
arch/mips/kernel/mips-mt-fpaff.c: In function `mipsmt_sys_sched_setaffinity':
arch/mips/kernel/mips-mt-fpaff.c:82: error: structure has no member named `euid'arch/mips/kernel/mips-mt-fpaff.c:82: error: structure has no member named `uid'
make[1]: *** [arch/mips/kernel/mips-mt-fpaff.o] Error 1
make: *** [arch/mips/kernel] Error 2
