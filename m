Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Aug 2011 04:11:31 +0200 (CEST)
Received: from imr3.ericy.com ([198.24.6.13]:55428 "EHLO imr3.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490955Ab1HTCL0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 20 Aug 2011 04:11:26 +0200
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
        by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id p7K2BJth017864
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 21:11:19 -0500
Received: from [IPv6:::1] (147.117.20.214) by smtps-am.internal.ericsson.com
 (147.117.20.32) with Microsoft SMTP Server (TLS) id 8.3.137.0; Fri, 19 Aug
 2011 22:11:18 -0400
Message-ID: <4E4F17C5.9010305@ericsson.com>
Date:   Fri, 19 Aug 2011 19:11:17 -0700
From:   Jason Kwon <jason.kwon@ericsson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
MIME-Version: 1.0
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Octeon build broken on 3.1.0-rc2 (linux-next)
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason.kwon@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14870

I pulled a tree today from linux-next.git, and found that the 
octeon-mips build is broken; it fails to build 
arch/mips/cavium-octeon/flash_setup.c due to this patch:

http://patchwork.ozlabs.org/patch/101616/

The function parse_mtd_partitions() isn't exported from 
<linux/mtd/partition.h> any longer.  Is this a known issue?

Thanks,

Jason
