Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Oct 2010 14:47:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42332 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491054Ab0JZMrt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Oct 2010 14:47:49 +0200
Date:   Tue, 26 Oct 2010 13:47:48 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
cc:     Camm Maguire <camm@maguirefamily.org>,
        debian-mips@lists.debian.org,
        Frederick Isaac <freddyisaac@gmail.com>, gcl-devel@gnu.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: gdb for mips64
In-Reply-To: <4CC5FA72.6080005@caviumnetworks.com>
Message-ID: <alpine.LFD.2.00.1010261323080.15889@eddie.linux-mips.org>
References: <E1OwbkA-0006gv-Bi@localhost.m.enhanced.com>        <4C93993E.7030008@caviumnetworks.com>   <8762y49k1k.fsf@maguirefamily.org>      <4C93D86D.5090201@caviumnetworks.com>   <87fwx4dwu5.fsf@maguirefamily.org>      <4C97D9A1.7050102@caviumnetworks.com>
   <87lj6te9t1.fsf@maguirefamily.org>      <4C9A8BC9.1020605@caviumnetworks.com>   <4C9A9699.6080908@caviumnetworks.com>   <87pqvbs7oa.fsf@maguirefamily.org>      <4CB88D2C.8020900@caviumnetworks.com>   <87r5fksxby.fsf_-_@maguirefamily.org>  
 <4CBF1B1E.6050804@caviumnetworks.com>   <8762wwlfen.fsf@maguirefamily.org>      <4CC06826.2070508@caviumnetworks.com>   <4CC0787C.2040902@caviumnetworks.com> <878w1m3qmn.fsf_-_@maguirefamily.org> <4CC5FA72.6080005@caviumnetworks.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 25 Oct 2010, David Daney wrote:

> I don't think a 32-bit gdb can debug 64-bit processes :-(.

 And it should (assuming ptrace(2) gets things right) -- if what you say 
is true, then it's a bug rather than a deliberate design decision.  To add 
some irony, MIPS GDB is always 64-bit internally.

> > (gdb) r
> > Starting program: /home/camm/gcl-2.6.8pre/unixport/saved_pre_gcl
> > /home/wingsun/develop/build/gdb/gdb-6.8/gdb/mips-tdep.c:603: internal-error:
> > bad register size
> > A problem internal to GDB has been detected,
> > further debugging may prove unreliable.

 Try a newer version though -- GDB 7.2 has been out for a (short) while 
now.  You're missing 2.5 years of development.  If still unsuccessful with 
a pristine release from ftp.gnu.org, then file a bug report at 
http://sourceware.org/gdb/bugs/.

  Maciej
