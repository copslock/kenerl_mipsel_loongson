Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 14:37:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1203 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993921AbdEWMgz06cjF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2017 14:36:55 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 38FAE40624DDB;
        Tue, 23 May 2017 13:36:44 +0100 (IST)
Received: from [10.20.78.51] (10.20.78.51) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 23 May 2017
 13:36:46 +0100
Date:   Tue, 23 May 2017 13:36:09 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 0/4] MIPS16e2 ASE support
Message-ID: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.51]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Ralf,

 This patch series adds MIPS16e2 ASE support as per the architecture 
specification[1].  Included there's feature identification, reporting and 
necessary instruction emulation.  These patches have been checked with 
interAptiv MR2 hardware to verify that new MIPS16e2 functions operate 
correctly and with 74Kf hardware to verify that no regression has been 
casued with original MIPS16e support.  See individual descriptions for the 
details of each change made.

 Please queue for the next rc cycle.

References:

[1] "MIPS32 Architecture for Programmers: MIPS16e2 Application-Specific
    Extension Technical Reference Manual", Imagination Technologies
    Ltd., Document Number: MD01172, Revision 01.00, April 26, 2016

  Maciej
