Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2016 08:19:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26510 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028461AbcEMGTgOMECL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2016 08:19:36 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 017366FCEDCD4;
        Fri, 13 May 2016 07:19:28 +0100 (IST)
Received: from [10.20.78.172] (10.20.78.172) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Fri, 13 May 2016
 07:19:29 +0100
Date:   Fri, 13 May 2016 07:19:21 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 0/3] MIPS: ELF: Header cleanups
Message-ID: <alpine.DEB.2.00.1605121036270.6794@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.172]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53423
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

Hi,

 These are the cleanups I promised as a follow up to commit f4d3d504198d 
("mips: Differentiate between 32 and 64 bit ELF header") and commit 
388e72480cf2 ("crash_dump: Add vmcore_elf32_check_arch") as they were 
discussed earlier this year.  Please apply.

  Maciej
