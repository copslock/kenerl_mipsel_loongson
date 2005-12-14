Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2005 21:56:25 +0000 (GMT)
Received: from mail.ttnet.net.tr ([212.175.13.129]:20016 "EHLO
	fep01.ttnet.net.tr") by ftp.linux-mips.org with ESMTP
	id S8133706AbVLNV4I (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Dec 2005 21:56:08 +0000
Received: from boras ([85.102.128.41]) by fep01.ttnet.net.tr with ESMTP
          id <20051214215233.GDML17443.fep01.ttnet.net.tr@boras>
          for <linux-mips@linux-mips.org>; Wed, 14 Dec 2005 23:52:33 +0200
From:	bora.sahin@ttnet.net.tr
To:	linux-mips@linux-mips.org
Subject: Au1200 & IDE
Date:	Wed, 14 Dec 2005 23:56:14 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512142356.14417.bora.sahin@ttnet.net.tr>
X-NAI-Spam-Rules: 1 Rules triggered
	BAYES_00=-2.5
Return-Path: <bora.sahin@ttnet.net.tr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bora.sahin@ttnet.net.tr
Precedence: bulk
X-list: linux-mips

Hi,

drivers/ide/mips/au1xxx-ide.c includes ide-timing.h:

...
#include "ide-timing.h"
...

But that directory doesnt contain "ide-timing.h" so compiler complains from 
it. ide-timing.h is in ide folder. I did a grep and saw that some other 
dirs under ide also includes that file in the same manner as in mips but 
doesnt contain it in its own folder. After I did a sym link, compile was 
successfull. What's the concept behind this? Can we move it to 
include/linux?

--
Bora SAHIN
