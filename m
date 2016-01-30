Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 10:08:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17654 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008725AbcA3JIIOf8XN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 10:08:08 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 3BFCD9310279C;
        Sat, 30 Jan 2016 09:08:00 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Sat, 30 Jan 2016
 09:08:01 +0000
Date:   Sat, 30 Jan 2016 09:08:01 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 0/3] A bunch of RDHWR emulation bug fixes
Message-ID: <alpine.DEB.2.00.1601300356250.5958@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51544
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

 As I investigated legacy SYNC support I came across a number of issues 
with RDHWR emulation, located nearby.  This mini patch set addresses these 
problems, please apply.  As these are bug fixes I think there is no need 
to wait for the next rc1 stage.

  Maciej
