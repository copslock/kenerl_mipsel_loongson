Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Oct 2010 19:19:50 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14293 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491127Ab0JZRTr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Oct 2010 19:19:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cc70dd30000>; Tue, 26 Oct 2010 10:20:19 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 26 Oct 2010 10:20:09 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 26 Oct 2010 10:20:09 -0700
Message-ID: <4CC70DA9.6000906@caviumnetworks.com>
Date:   Tue, 26 Oct 2010 10:19:37 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Camm Maguire <camm@maguirefamily.org>,
        debian-mips@lists.debian.org,
        Frederick Isaac <freddyisaac@gmail.com>, gcl-devel@gnu.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: gdb for mips64
References: <E1OwbkA-0006gv-Bi@localhost.m.enhanced.com>        <4C93993E.7030008@caviumnetworks.com>   <8762y49k1k.fsf@maguirefamily.org>      <4C93D86D.5090201@caviumnetworks.com>   <87fwx4dwu5.fsf@maguirefamily.org>      <4C97D9A1.7050102@caviumnetworks.com>   <87lj6te9t1.fsf@maguirefamily.org>      <4C9A8BC9.1020605@caviumnetworks.com>   <4C9A9699.6080908@caviumnetworks.com>   <87pqvbs7oa.fsf@maguirefamily.org>      <4CB88D2C.8020900@caviumnetworks.com>   <87r5fksxby.fsf_-_@maguirefamily.org>   <4CBF1B1E.6050804@caviumnetworks.com>   <8762wwlfen.fsf@maguirefamily.org>      <4CC06826.2070508@caviumnetworks.com>   <4CC0787C.2040902@caviumnetworks.com> <878w1m3qmn.fsf_-_@maguirefamily.org> <4CC5FA72.6080005@caviumnetworks.com> <alpine.LFD.2.00.1010261323080.15889@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.00.1010261323080.15889@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Oct 2010 17:20:09.0786 (UTC) FILETIME=[0AA919A0:01CB7532]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/26/2010 05:47 AM, Maciej W. Rozycki wrote:
> On Mon, 25 Oct 2010, David Daney wrote:
>
>> I don't think a 32-bit gdb can debug 64-bit processes :-(.
>
>   And it should (assuming ptrace(2) gets things right) -- if what you say
> is true, then it's a bug rather than a deliberate design decision.  To add
> some irony, MIPS GDB is always 64-bit internally.
>
>>> (gdb) r
>>> Starting program: /home/camm/gcl-2.6.8pre/unixport/saved_pre_gcl
>>> /home/wingsun/develop/build/gdb/gdb-6.8/gdb/mips-tdep.c:603: internal-error:
>>> bad register size
>>> A problem internal to GDB has been detected,
>>> further debugging may prove unreliable.
>
>   Try a newer version though -- GDB 7.2 has been out for a (short) while
> now.  You're missing 2.5 years of development.  If still unsuccessful with
> a pristine release from ftp.gnu.org, then file a bug report at
> http://sourceware.org/gdb/bugs/.
>

After more though, I think you may have to configure with 
--enable-64-bit-bfd for a 32-bit gdb to work on 64-bit processes. 
Although I have not actually tested that.  In the past, I have just 
built a native 64-bit gdb.

David Daney
