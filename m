Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2017 18:09:55 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9152 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993934AbdAXRJsm0CTT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2017 18:09:48 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8F3723928F09F;
        Tue, 24 Jan 2017 17:09:38 +0000 (GMT)
Received: from [10.20.78.238] (10.20.78.238) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 24 Jan 2017
 17:09:41 +0000
Date:   Tue, 24 Jan 2017 17:09:32 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 1/2] MIPS: ptrace: disallow setting watchpoints in
 kernel address space
In-Reply-To: <1485163113-21780-1-git-send-email-marcin.nowakowski@imgtec.com>
Message-ID: <alpine.DEB.2.00.1701232258380.13564@tp.orcam.me.uk>
References: <1485163113-21780-1-git-send-email-marcin.nowakowski@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.238]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56476
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

On Mon, 23 Jan 2017, Marcin Nowakowski wrote:

> With certain EVA configurations it is possible for the kernel address
> space to overlap user address space, which allows the user to set
> watchpoints on kernel addresses via ptrace.
> 
> If a watchpoint is set in the watch exception handling code (after
> exception level has been cleared) then the system will hang in an
> infinite loop when hitting a watchpoint while trying to process it.
> 
> To prevent that simply disallow placing any watchpoints at addresses
> above start of kernel that overlap userspace.

 This can be severely crippling for user debugging.  Is there no better 
way?

 Can't for example the low-level exception handling entry/exit code be 
moved out of the way of the EVA overlap range and then all watchpoints 
masked for the duration of kernel mode execution?  This would be quite 
expensive, however it could only be executed if a task flag indicates 
watchpoints are being used.  Alternatively perhaps we could clobber 
CP0.EntryHi.ASID, at least temporarily; that would be cheaper.

 Overall I think this situation is asking for a watchpoint flag to be 
added to inhibit hits in the kernel mode in hardware; for completeness 
this probably actually ought to be a field to cover the kernel, supervisor 
and user modes separately -- either a plain bitmask for arbitrary control 
or an encoded value similar to CP0.Status.KSU which would indicate the 
most privileged mode to accept a watchpoint in.

 I had a recollection of such a facility already being available for JTAG 
debugging, but I can't track it down in the specification, so perhaps it 
was for another architecture and it would be completely new for ours.

  Maciej
