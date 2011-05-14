Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 May 2011 01:06:14 +0200 (CEST)
Received: from astoria.ccjclearline.com ([64.235.106.9]:37080 "EHLO
        astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490992Ab1ENXGK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 May 2011 01:06:10 +0200
Received: from 173.221.84.2.nw.nuvox.net ([173.221.84.2] helo=crashcourse.ca)
        by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1QLNuM-0001iD-Nm
        for linux-mips@linux-mips.org; Sat, 14 May 2011 19:06:02 -0400
Date:   Sat, 14 May 2011 19:05:58 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost6.localdomain6
To:     linux-mips@linux-mips.org
Subject: reference to non-existent CONFIG_HAVE_GPIO_LIB variable?
Message-ID: <alpine.DEB.2.00.1105141904410.13343@localhost6.localdomain6>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
Precedence: bulk
X-list: linux-mips


  the current kernel source contains a Makefile reference to the above
Kconfig variable that does not appear to be defined anywhere.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
