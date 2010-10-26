Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Oct 2010 16:47:26 +0200 (CEST)
Received: from tvwna-ip-c-172.princeton.org ([66.180.187.89]:47449 "EHLO
        localhost.m.enhanced.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491055Ab0JZOrX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Oct 2010 16:47:23 +0200
Received: from camm by localhost.m.enhanced.com with local (Exim 4.69)
        (envelope-from <camm@maguirefamily.org>)
        id 1PAkns-0000vC-PO; Tue, 26 Oct 2010 10:47:08 -0400
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     debian-mips@lists.debian.org,
        Frederick Isaac <freddyisaac@gmail.com>, gcl-devel@gnu.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: gdb for mips64
References: <E1OwbkA-0006gv-Bi@localhost.m.enhanced.com>
        <4C93993E.7030008@caviumnetworks.com>
        <8762y49k1k.fsf@maguirefamily.org>
        <4C93D86D.5090201@caviumnetworks.com>
        <87fwx4dwu5.fsf@maguirefamily.org>
        <4C97D9A1.7050102@caviumnetworks.com>
        <87lj6te9t1.fsf@maguirefamily.org>
        <4C9A8BC9.1020605@caviumnetworks.com>
        <4C9A9699.6080908@caviumnetworks.com>
        <87pqvbs7oa.fsf@maguirefamily.org>
        <4CB88D2C.8020900@caviumnetworks.com>
        <87r5fksxby.fsf_-_@maguirefamily.org>
        <4CBF1B1E.6050804@caviumnetworks.com>
        <8762wwlfen.fsf@maguirefamily.org>
        <4CC06826.2070508@caviumnetworks.com>
        <4CC0787C.2040902@caviumnetworks.com>
        <878w1m3qmn.fsf_-_@maguirefamily.org>
        <4CC5FA72.6080005@caviumnetworks.com>
From:   Camm Maguire <camm@maguirefamily.org>
Date:   Tue, 26 Oct 2010 10:47:08 -0400
In-Reply-To: <4CC5FA72.6080005@caviumnetworks.com> (David Daney's message of "Mon\, 25 Oct 2010 14\:45\:22 -0700")
Message-ID: <87k4l52eqb.fsf@maguirefamily.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <camm@maguirefamily.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: camm@maguirefamily.org
Precedence: bulk
X-list: linux-mips

Greetings!

David Daney <ddaney@caviumnetworks.com> writes:

> On 10/25/2010 02:32 PM, Camm Maguire wrote:
>> Greetings!  Can gdb be made to work on mips64?
>>
>
> You have to have a 64-bit toolchain.
>
> Then something like this (untested):
>
> CC='mips64-linux-gnu -mabi=64' configure --host=mips64-linux
> --target=mips64-linux.
>
> I don't think a 32-bit gdb can debug 64-bit processes :-(.
>

Thanks.

Why doesn't _IO_getc get a stub on mips64, like say _setjmp?

readelf -a saved_ansi_gcl |grep  IO_getc
  2812: 0000000000000000   472 FUNC    GLOBAL DEFAULT  UND _IO_getc@GLIBC_2.0 (2)
 15315: 0000000000000000   472 FUNC    GLOBAL DEFAULT  UND _IO_getc@@GLIBC_2.0
readelf -a saved_ansi_gcl |grep  setjmp
  2159: 00000001204b9b40    32 FUNC    GLOBAL DEFAULT  UND _setjmp@GLIBC_2.0 (2)
 15978: 00000001204b9b40    32 FUNC    GLOBAL DEFAULT  UND _setjmp@@GLIBC_2.0
 
Is there anything I can do about this?

Take care,

> David Daney
>
>
>> (gdb) r
>> Starting program: /home/camm/gcl-2.6.8pre/unixport/saved_pre_gcl
>> /home/wingsun/develop/build/gdb/gdb-6.8/gdb/mips-tdep.c:603: internal-error: bad register size
>> A problem internal to GDB has been detected,
>> further debugging may prove unreliable.
>>
>> Take care,
>
>
>
>
>

-- 
Camm Maguire			     		    camm@maguirefamily.org
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
