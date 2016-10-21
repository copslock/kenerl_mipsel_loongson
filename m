Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2016 21:25:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12542 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992544AbcJUTZCOaxdt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2016 21:25:02 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9C3E622F29DC8;
        Fri, 21 Oct 2016 20:24:49 +0100 (IST)
Received: from [10.20.78.168] (10.20.78.168) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 21 Oct 2016
 20:24:53 +0100
Date:   Fri, 21 Oct 2016 20:24:44 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
CC:     James Hogan <James.Hogan@imgtec.com>,
        Bhushan Attarde <Bhushan.Attarde@imgtec.com>,
        "gdb-patches@sourceware.org" <gdb-patches@sourceware.org>,
        Andrew Bennett <Andrew.Bennett@imgtec.com>,
        Jaydeep Patil <Jaydeep.Patil@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH 02/24]     Add MIPS32 FPU64 GDB target descriptions
In-Reply-To: <alpine.DEB.2.00.1610131614180.31859@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1610212020340.31859@tp.orcam.me.uk>
References: <1467038991-6600-1-git-send-email-bhushan.attarde@imgtec.com> <1467038991-6600-2-git-send-email-bhushan.attarde@imgtec.com> <alpine.DEB.2.00.1607221827040.4076@tp.orcam.me.uk> <20161012135803.GT19354@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1610121701180.31859@tp.orcam.me.uk> <20161012180531.GV19354@jhogan-linux.le.imgtec.org> <alpine.DEB.2.00.1610122217350.31859@tp.orcam.me.uk> <6D39441BF12EF246A7ABCE6654B0235380A70681@HHMAIL01.hh.imgtec.org>
 <alpine.DEB.2.00.1610131614180.31859@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.168]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55547
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

On Fri, 21 Oct 2016, Maciej W. Rozycki wrote:

>  If we had such a dedicated virtual $fre, and we decided sometime to let 
> the user actually write to it and switch the mode process-wide, then we 
> could simply invoke the right prctl(2) call in response to the user's 
> ptrace(2) request.

 Or we could call it $fp_mode and map it directly to prctl(PR_GET_FP_MODE) 
and prctl(PR_SET_FP_MODE, ...).

  Maciej
