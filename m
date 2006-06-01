Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2006 22:46:53 +0200 (CEST)
Received: from mail01.hansenet.de ([213.191.73.61]:34715 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S8133759AbWFAUqq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Jun 2006 22:46:46 +0200
Received: from [213.39.208.223] (213.39.208.223) by webmail.hansenet.de (7.2.059) (authenticated as mbx20228207@koeller-hh.org)
        id 447D3FB200064FAD for linux-mips@linux-mips.org; Thu, 1 Jun 2006 22:46:40 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by sarkovy.koeller.dyndns.org (Postfix) with ESMTP id 8F12A10AA09
	for <linux-mips@linux-mips.org>; Thu,  1 Jun 2006 22:46:39 +0200 (CEST)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
To:	linux-mips@linux-mips.org
Subject: Location of PCI setup code
Date:	Thu, 1 Jun 2006 22:46:17 +0200
User-Agent: KMail/1.9.1
Organization: Basler AG
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200606012246.17864.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Hi,

the PCI setup code for a platform is conventionally located in arch/mips/pci. 
I fail to see the benefits of separating this particular part of a platform's 
setup from the rest. The PCI setup code will in general contain references to 
platform-specific information, such as the overall address space layout, of 
which the PCI memory and I/O pages are a part. If the PCI setup code were in 
the platform subdirectory, sharing this information by means of a 
platform-local header file would be easy. But with the PCI code in 
arch/mips/pci, this becomes more difficult. The platform header could be 
located somewhere outside the platform's directory, maybe under 
'include' (where?), or referenced via an ugly relative path like 
'../../vendor/platform/platform.h'. All this seems rather clumsy to me. No 
other part of a platform's initialization is separated from the rest in a 
similar way, so what is so special about PCI setup that it cannot be in the 
platform directory, thereby avoiding all these annoyances? 

tk

-- 
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com
