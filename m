Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 01:57:46 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:44950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012309AbcBPA5pAOGKH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Feb 2016 01:57:45 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (Postfix) with ESMTPS id 0A2E3804E7;
        Tue, 16 Feb 2016 00:57:38 +0000 (UTC)
Received: from [127.0.0.1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1G0vZ57016391;
        Mon, 15 Feb 2016 19:57:36 -0500
Message-ID: <56C273FF.7070206@redhat.com>
Date:   Tue, 16 Feb 2016 00:57:35 +0000
From:   Pedro Alves <palves@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Luis Machado <lgustavo@codesourcery.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        gdb-patches@sourceware.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Expect SI_KERNEL si_code for a MIPS software breakpoint
 trap
References: <1442592647-3051-1-git-send-email-lgustavo@codesourcery.com> <alpine.LFD.2.20.1509181729100.10647@eddie.linux-mips.org> <56B9F7E6.5010006@codesourcery.com> <alpine.DEB.2.00.1602092020150.15885@tp.orcam.me.uk> <56BB329F.3080606@codesourcery.com>
In-Reply-To: <56BB329F.3080606@codesourcery.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <palves@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palves@redhat.com
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

On 02/10/2016 12:52 PM, Luis Machado wrote:
> The problem of forcing gdbserver to recognize all traps with 
> si_code==SI_KERNEL is that even hardcoded traps will be reported back to 
> GDB as a swbreak event, which is not ideal.

That's how swbreak is defined:

 @item swbreak
 @anchor{swbreak stop reason}
 The packet indicates a memory breakpoint instruction was executed,
 irrespective of whether it was @value{GDBN} that planted the
 breakpoint or the breakpoint is hardcoded in the program.

> 
> But currently there is no easy way to tell a software breakpoint hit and 
> a hardcoded trap (and maybe even a hardware breakpoint hit?) apart.

Software breakpoint hits or hardcoded traps are handled the same.  Even if GDB
plants the breakpoint instruction itself with direct memory pokes (instead of
z0 packets), the target should report "swbreak" stops, so that gdb can do
the right thing.

GDB knows whether to discard the hit as a delayed breakpoint hit event by
checking whether the thread's PC points at an hardcoded trap.  If it does,
the event is not discarded, but instead reported to the user as a SIGTRAP.

Hardware breakpoint hits are distinguished from software breakpoint hits,
because they're reported with "hwbreak", not "swbreak":

 @item hwbreak
 The packet indicates the target stopped for a hardware breakpoint.
 The @var{r} part must be left empty.

Thanks,
Pedro Alves
