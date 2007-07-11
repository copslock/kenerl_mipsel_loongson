Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 10:25:21 +0100 (BST)
Received: from mail.blastwave.org ([147.87.98.10]:42154 "EHLO
	mail.blastwave.org") by ftp.linux-mips.org with ESMTP
	id S20022925AbXGKJZT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 10:25:19 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.blastwave.org (Postfix) with ESMTP id C13DDFA32
	for <linux-mips@linux-mips.org>; Wed, 11 Jul 2007 11:25:15 +0200 (MEST)
X-Virus-Scanned: amavisd-new at blastwave.org
Received: from mail.blastwave.org ([127.0.0.1])
	by localhost (enterprise.blastwave.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vQRo6iTJPth8 for <linux-mips@linux-mips.org>;
	Wed, 11 Jul 2007 11:25:12 +0200 (MEST)
Received: from aki.intern.liechtiag.ch (66-132.63-81.stat.fixnetdata.ch [81.63.132.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.blastwave.org (Postfix) with ESMTP id 8DE9FFA05
	for <linux-mips@linux-mips.org>; Wed, 11 Jul 2007 11:25:12 +0200 (MEST)
Date:	Wed, 11 Jul 2007 11:25:11 +0200
From:	Attila Kinali <attila@kinali.ch>
To:	linux-mips@linux-mips.org
Subject: mtdram with huge sizes
Message-Id: <20070711112511.41a633b6.attila@kinali.ch>
Organization: SEELE
X-Mailer: Sylpheed 2.4.0rc (GTK+ 2.10.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <attila@kinali.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: attila@kinali.ch
Precedence: bulk
X-list: linux-mips

Hi,

I'm currently trying to test our system that should go soonish
into the first life test, thus i wanted to test all jffs2 images
we have on my host machine. Unfortunately, the vmalloc range on
x86 seems to be too small to support 16MB images.

Before i start poking around in mtdram.c and replacing vmalloc
by get_free_page() calls i wanted to ask whether anyone has done
something similar already or has a better idea what to do.

Thanks in advance

			Attila Kinali

-- 
Praised are the Fountains of Shelieth, the silver harp of the waters,
But blest in my name forever this stream that stanched my thirst!
                         -- Deed of Morred
