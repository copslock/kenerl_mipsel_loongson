Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 06:19:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63824 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008588AbcAVFT44qfUz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 06:19:56 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id D85ECB470DFFF;
        Fri, 22 Jan 2016 05:19:49 +0000 (GMT)
Received: from [10.100.200.15] (10.100.200.15) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Fri, 22 Jan 2016
 05:19:50 +0000
Date:   Fri, 22 Jan 2016 05:20:17 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Aurelien Jarno <aurelien@aurel32.net>, <linux-mips@linux-mips.org>
Subject: [PATCH 0/7] MIPS: math-emu: Branch delay slot emulation fixes
Message-ID: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.15]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51291
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

 This small patch series addresses the following issues with branch delay 
slot emulation in our floating-point emulator:

- NOP emulation sometimes causes SIGILL (Aurelien's bug),

- microMIPS emulation always goes astray,

- microMIPS emulation of ADDIUPC always returns the wrong result.

Also included are a bunch of code clean-ups and comment fixes.  See 
individual patch descriptions for further details.

 I attempted to move clean-ups to the end, so that they do not interfere 
with backporting, except with 2/7 which, if reordered, would require 3/7 
to become ill-formatted.  I hope this is OK.  Changes 5-7/7 do not require 
backporting.

 This series has been validated with a MIPS M5150 processor.

  Maciej
