Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 11:18:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3275 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029239AbcELJSFN7RET (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 11:18:05 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 29F9B58034579;
        Thu, 12 May 2016 10:17:54 +0100 (IST)
Received: from [10.20.78.171] (10.20.78.171) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 12 May 2016
 10:17:55 +0100
Date:   Thu, 12 May 2016 10:17:46 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] MIPS: ptrace: Fix FCSR handling
Message-ID: <alpine.DEB.2.00.1605120014000.6794@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.171]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53396
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

 In the course of reviewing Steven's FCSR patch yesterday I came across a 
regression which I have inadvertently introduced with my FPU handling 
updates last year as well as a missed case not addressed there, both in 
ptrace(2) handling.  These issues are corrected with the two changes 
presented here.  Please apply ASAP and backport as far back as applicable, 
which is 4.0 AFAICT.

 Thank you and apologies for the mess.

  Maciej
