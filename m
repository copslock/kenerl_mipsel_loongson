Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2016 20:49:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57326 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993076AbcF3StI2ihKC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2016 20:49:08 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4903D423B06AF;
        Thu, 30 Jun 2016 19:48:58 +0100 (IST)
Received: from [10.20.78.11] (10.20.78.11) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Thu, 30 Jun 2016
 19:49:01 +0100
Date:   Thu, 30 Jun 2016 19:48:47 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Faraz Shahbazker <faraz.shahbazker@imgtec.com>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>
Subject: Re: [RFC PATCH v3 2/2] MIPS: non-exec stack & heap when non-exec
 PT_GNU_STACK is present
In-Reply-To: <57755990.8010807@imgtec.com>
Message-ID: <alpine.DEB.2.00.1606301853530.4103@tp.orcam.me.uk>
References: <20160629143830.526-1-paul.burton@imgtec.com> <20160629143830.526-3-paul.burton@imgtec.com> <6D39441BF12EF246A7ABCE6654B023537E465A74@HHMAIL01.hh.imgtec.org> <fb77e2f2-801d-8dd5-6121-73909ebbd227@imgtec.com> <6D39441BF12EF246A7ABCE6654B023537E465F8E@HHMAIL01.hh.imgtec.org>
 <96de1cb3-7bb7-769d-e032-5bd10a3d1633@imgtec.com> <57755990.8010807@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.11]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54193
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

On Thu, 30 Jun 2016, Faraz Shahbazker wrote:

> The user-mode patch hasn't gone upstream either, so it is open to 
> modification. Assuming the kernel currently has no other means of 
> publishing RIXI support, or there is no existing software relying on 
> such publication, then a RIXI bit in HWCAP seems appropriate.

 I think it depends on whether you advertise a fixed hardware feature or 
a software feature.

 For NaN interlinking it is obviously a plain software feature set on a 
program by program basis, and you can have either mode set depending on 
the kernel command line and main executable's ELF header flags, 
irrespectively of what hardware supports.  So FLAGS was the natural 
choice, barring the invention of a new vector entry, and HWCAP was out 
of question.

 With HWCAP I'd only advertise fixed features, unchanged from the 
bootstrap till the shutdown (or crash ;) ), and global to the whole 
system.

> @Matthew/@Maciej: If this is a priority, could we swap the libc-abi 
> numbers for IFUNC(4) and non-exec stack(5) to push this change through 
> before IFUNC? I think that is the only reason we've held the user-mode 
> patches for glibc and gcc. A binutils patch with abiversion=5 was 
> committed, so it will need fixing, but its only a one-liner.

 TBH I think ABI versions need to be changed incrementally or otherwise 
we get a broken run-time environment.  E.g. if we used version 4 for 
IFUNC support now, then non-exec stack binaries marked with version 5 
would be considered as supporting IFUNC, while in fact they may not, 
depending on what binutils version they have been built with.  So now we 
need to use 6 for IFUNC anyway as people may have distributed binaries 
with version 5 recorded already, which obviously do not support IFUNC 
as it hasn't been upstreamed yet.

 I'd rather we didn't have this hole, but we can't change history and I 
just hope we won't go out of range with `e_ident[EI_ABIVERSION]', which 
is a byte only, anytime soon.

 NB from the ELF specification it looks to me like this field has been 
selected for recording ELF binary features in error, where `e_version' 
should have.  This is because the former specifies the ELF *header* 
version (i.e. changes to the `ElfXX_Ehdr' structure itself, presumably 
except from `e_ident' itself or at least its first 7 bytes) while it's 
`e_version' that was meant for the version of the ELF object file (i.e. 
everything beyond the header).  They just both happened to be set to 
EV_CURRENT or 1 in the original SVR4 ELF gABI, which may have confused 
someone.  To say nothing of `e_version' being 32-bit, providing much 
more room for manoeuvre.  But again, we can't change history and undo 
the bad choice.

  Maciej
