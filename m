Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 15:40:53 +0100 (BST)
Received: from mail.blastwave.org ([147.87.98.10]:61919 "EHLO
	mail.blastwave.org") by ftp.linux-mips.org with ESMTP
	id S20021998AbXC1Okv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 15:40:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.blastwave.org (Postfix) with ESMTP id 7B311F97B
	for <linux-mips@linux-mips.org>; Wed, 28 Mar 2007 16:40:11 +0200 (MEST)
X-Virus-Scanned: amavisd-new at blastwave.org
Received: from mail.blastwave.org ([127.0.0.1])
	by localhost (enterprise.blastwave.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id a8ueosyr1VIU for <linux-mips@linux-mips.org>;
	Wed, 28 Mar 2007 16:39:58 +0200 (MEST)
Received: from unknown (66-132.63-81.stat.fixnetdata.ch [81.63.132.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.blastwave.org (Postfix) with ESMTP id 9AF90F93D
	for <linux-mips@linux-mips.org>; Wed, 28 Mar 2007 16:39:16 +0200 (MEST)
Date:	Wed, 28 Mar 2007 16:39:14 +0200
From:	Attila Kinali <attila@kinali.ch>
To:	linux-mips@linux-mips.org
Subject: Power loss and system time when not having a battery backed RTC
Message-Id: <20070328163914.b7187fcb.attila@kinali.ch>
Organization: NERV
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.10.6; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <attila@kinali.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: attila@kinali.ch
Precedence: bulk
X-list: linux-mips

Moin,

I have a little bit more general question than usual.
I have here a system that should be deployed in Joe
Average's house as a small appliance. While it is powered
it will gather information and store them on its flash.

Now, this system does not contain a battery backed RTC
(not enough space) and thus does not know what date/time
it is after boot. At a later time the device will
be able to get a time quote from a time server using
a wireless connection. But as the wireless connection
is triggered by a user action, it can happen hours after
boot. This means that there is a quite long period whithin
which the device does not know what time it is and hence
assumes it's 1970.

My problem lies now in the back jumps that the device
makes, when unplugged and replugged. On the filesystem
there will be files from 2007, while the system still
thinks it's 1970.

How do you handle this issue with the back jumps, if you
cannot stick in a batter backed RTC?


Thanks for your help

			Attila Kinali
-- 
Praised are the Fountains of Shelieth, the silver harp of the waters,
But blest in my name forever this stream that stanched my thirst!
                         -- Deed of Morred
