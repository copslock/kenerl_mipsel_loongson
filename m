Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2011 20:18:23 +0200 (CEST)
Received: from imr4.ericy.com ([198.24.6.8]:44626 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491089Ab1FPSSU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Jun 2011 20:18:20 +0200
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id p5GII7Sm019059;
        Thu, 16 Jun 2011 13:18:13 -0500
Received: from localhost (147.117.20.214) by eusaamw0711.eamcs.ericsson.se
 (147.117.20.179) with Microsoft SMTP Server id 8.3.137.0; Thu, 16 Jun 2011
 14:18:06 -0400
Date:   Thu, 16 Jun 2011 11:18:06 -0700
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     linux-mips@linux-mips.org
Subject: Octeon Ethernet driver
Message-ID: <20110616181806.GC19457@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 30427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13792

Hi David,

looks like we'll need to use the Octeon Ethernet driver from SDK 2.0
or later in our system, for performance reasons. We plan to use 2.6.39,
so we can not directly use the SDK driver.

Do you (or someone else) have plans to port it to the upstream kernel,
or do you know if such a port exists ?

Thanks,
Guenter 
