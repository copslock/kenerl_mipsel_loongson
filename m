Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2012 17:37:52 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:2115 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903440Ab2IFPhO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2012 17:37:14 +0200
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Thu, 06 Sep 2012 08:35:34 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Thu, 6 Sep 2012 08:36:22 -0700
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id D11EE9F9F7; Thu, 6
 Sep 2012 08:36:58 -0700 (PDT)
From:   "Jim Quinlan" <jim2101024@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     ddaney.cavm@gmail.com, cernekee@gmail.com
Subject: [PATCH V5 0/3] Make funcs preempt safe for non-mipsr2 cpus
Date:   Thu, 6 Sep 2012 11:36:53 -0400
Message-ID: <1346945816-13984-1-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.7.6
MIME-Version: 1.0
X-WSS-ID: 7C561D4C3NK24161106-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This is the same as V4 except for a one line change in cvmx-l2c.c
in PATCH 2/3 for sucessful compilation on cavium-octeon.  Other 
configurations that were tested include: bcm47xx, bcm63xx, bigsur, 
cobalt, malta, and yosemite.
