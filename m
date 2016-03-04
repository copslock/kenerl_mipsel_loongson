Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2016 02:41:43 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54698 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007714AbcCDBllgLaqU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2016 02:41:41 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 53625F9179715;
        Fri,  4 Mar 2016 01:41:35 +0000 (GMT)
Received: from [10.100.200.141] (10.100.200.141) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Fri, 4 Mar 2016
 01:41:35 +0000
Date:   Fri, 4 Mar 2016 01:41:32 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Pedro Alves <palves@redhat.com>,
        Luis Machado <lgustavo@codesourcery.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] SIGFPE/SIGTRAP sending updates
Message-ID: <alpine.DEB.2.00.1603031303500.9427@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.141]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52440
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

 This was meant to be a single SIGTRAP ABI correction patch for debugger 
support, but in the course of implementation I discovered information 
leaks in signal passing from trap handlers, affecting code to be written, 
so these are fixed first in this patch pair.

  Maciej
