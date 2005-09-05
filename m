Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Sep 2005 09:54:00 +0100 (BST)
Received: from post-23.mail.nl.demon.net ([IPv6:::ffff:194.159.73.193]:47331
	"EHLO post-23.mail.nl.demon.net") by linux-mips.org with ESMTP
	id <S8224976AbVIEIxm>; Mon, 5 Sep 2005 09:53:42 +0100
Received: from dare-holding.demon.nl ([212.238.232.25]:57035 helo=mouse.matrix.dare.nl)
	by post-23.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1ECCq2-000CmJ-Ic
	for linux-mips@linux-mips.org; Mon, 05 Sep 2005 09:00:26 +0000
Received: from localhost (localhost [127.0.0.1])
	by mouse.matrix.dare.nl (Postfix) with ESMTP id C6A95E6311
	for <linux-mips@linux-mips.org>; Mon,  5 Sep 2005 11:00:38 +0200 (CEST)
Received: from mouse.matrix.dare.nl ([127.0.0.1])
	by localhost (mouse [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18457-04 for <linux-mips@linux-mips.org>;
	Mon, 5 Sep 2005 11:00:38 +0200 (CEST)
Received: from [192.168.10.120] (id6220_10.matrix.dare.nl [192.168.10.120])
	by mouse.matrix.dare.nl (Postfix) with ESMTP id ECC22E6305
	for <linux-mips@linux-mips.org>; Mon,  5 Sep 2005 11:00:37 +0200 (CEST)
Message-ID: <431C0891.1070908@dare.nl>
Date:	Mon, 05 Sep 2005 10:57:53 +0200
From:	Robert Bon <robo@dare.nl>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Howto Boot from Flash with the Alchemy AU1100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: at dare.nl
Return-Path: <robo@dare.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robo@dare.nl
Precedence: bulk
X-list: linux-mips

Hello,

We are running linux kernel 2.6.12 on a AMD-Alchemy DB1100 evaluation 
board, with processor AU1100.

De kernel file is a Srecord which is programmed (with the bootloader 
YAMON load command) in to RAM, starting at address 0x80100000.
We want to store in the onboard flash.

How can we do this?

Thanks Robert.
