Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Mar 2005 21:40:28 +0000 (GMT)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:44267
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8227075AbVCOVkM>;
	Tue, 15 Mar 2005 21:40:12 +0000
Received: from [172.16.0.150] (w2rz8l4s02.jg555.com [::ffff:172.16.0.150])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Tue, 15 Mar 2005 13:40:10 -0800
  id 0000C3B4.4237563A.0000258A
Message-ID: <42375617.3020002@jg555.com>
Date:	Tue, 15 Mar 2005 13:39:35 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Current Build Warning Message
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

I just tried doing a current build on a 2.6.11 systems. I get the 
following warnings.

*** Warning: "pci_iounmap" [drivers/net/tulip/tulip.ko] undefined!
*** Warning: "pci_iomap" [drivers/net/tulip/tulip.ko] undefined!

Any ideas on how to correct this?

-- 
----
Jim Gifford
maillist@jg555.com
