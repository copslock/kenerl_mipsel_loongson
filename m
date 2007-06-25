Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2007 14:05:44 +0100 (BST)
Received: from mail.blastwave.org ([147.87.98.10]:24247 "EHLO
	mail.blastwave.org") by ftp.linux-mips.org with ESMTP
	id S20021918AbXFYNFm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Jun 2007 14:05:42 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.blastwave.org (Postfix) with ESMTP id F075BF941
	for <linux-mips@linux-mips.org>; Mon, 25 Jun 2007 15:05:11 +0200 (MEST)
X-Virus-Scanned: amavisd-new at blastwave.org
Received: from mail.blastwave.org ([127.0.0.1])
	by localhost (enterprise.blastwave.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vk3pECSOLKmN for <linux-mips@linux-mips.org>;
	Mon, 25 Jun 2007 15:05:08 +0200 (MEST)
Received: from aki.intern.liechtiag.ch (66-132.63-81.stat.fixnetdata.ch [81.63.132.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.blastwave.org (Postfix) with ESMTP id 42CA8F940
	for <linux-mips@linux-mips.org>; Mon, 25 Jun 2007 15:05:07 +0200 (MEST)
Date:	Mon, 25 Jun 2007 15:05:06 +0200
From:	Attila Kinali <attila@kinali.ch>
To:	linux-mips@linux-mips.org
Subject: au1550 ac97 driver
Message-Id: <20070625150506.a0cd7f9b.attila@kinali.ch>
Organization: SEELE
X-Mailer: Sylpheed 2.4.0rc (GTK+ 2.10.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <attila@kinali.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: attila@kinali.ch
Precedence: bulk
X-list: linux-mips

Moin,

I'm currently trying to get the AC97 codec code for the Alchemy
Au1550 working. It looks like this code has not been touched for
ages and has been rotting for quite a while.

As i assume that i'm not the only one using this code, i'd like
to ask whether someone else got the bits and pieces of this driver
together and working. If so, what changes did you apply?

Thanks in advance

			Attila Kinali

-- 
Praised are the Fountains of Shelieth, the silver harp of the waters,
But blest in my name forever this stream that stanched my thirst!
                         -- Deed of Morred
