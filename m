Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 09:11:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14050 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028492AbcEUHLvnhmYS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 09:11:51 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id EED87D7E5451B;
        Sat, 21 May 2016 08:11:42 +0100 (IST)
Received: from [10.20.78.16] (10.20.78.16) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Sat, 21 May 2016
 08:11:44 +0100
Date:   Sat, 21 May 2016 08:11:35 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 5/5] MIPS: Simplify DSP instruction encoding macros
In-Reply-To: <1463783321-24442-6-git-send-email-james.hogan@imgtec.com>
Message-ID: <alpine.DEB.2.00.1605210742260.6794@tp.orcam.me.uk>
References: <1463783321-24442-1-git-send-email-james.hogan@imgtec.com> <1463783321-24442-6-git-send-email-james.hogan@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.16]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53573
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

On Fri, 20 May 2016, James Hogan wrote:

> To me this makes it easier to read since it is much shorter, but it also
> ensures .insn is used, preventing objdump disassembling the microMIPS
> code as normal MIPS.

 More importantly the use of `.insn' prevents execution from going astray 
if there's a label being jumped to at the handcoded instruction.

  Maciej
