Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2010 23:45:28 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8974 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491113Ab0JYVpZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Oct 2010 23:45:25 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cc5fa970000>; Mon, 25 Oct 2010 14:45:59 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 25 Oct 2010 14:45:49 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 25 Oct 2010 14:45:49 -0700
Message-ID: <4CC5FA72.6080005@caviumnetworks.com>
Date:   Mon, 25 Oct 2010 14:45:22 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Camm Maguire <camm@maguirefamily.org>
CC:     debian-mips@lists.debian.org,
        Frederick Isaac <freddyisaac@gmail.com>, gcl-devel@gnu.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: gdb for mips64
References: <E1OwbkA-0006gv-Bi@localhost.m.enhanced.com>        <4C93993E.7030008@caviumnetworks.com>   <8762y49k1k.fsf@maguirefamily.org>      <4C93D86D.5090201@caviumnetworks.com>   <87fwx4dwu5.fsf@maguirefamily.org>      <4C97D9A1.7050102@caviumnetworks.com>   <87lj6te9t1.fsf@maguirefamily.org>      <4C9A8BC9.1020605@caviumnetworks.com>   <4C9A9699.6080908@caviumnetworks.com>   <87pqvbs7oa.fsf@maguirefamily.org>      <4CB88D2C.8020900@caviumnetworks.com>   <87r5fksxby.fsf_-_@maguirefamily.org>   <4CBF1B1E.6050804@caviumnetworks.com>   <8762wwlfen.fsf@maguirefamily.org>      <4CC06826.2070508@caviumnetworks.com>   <4CC0787C.2040902@caviumnetworks.com> <878w1m3qmn.fsf_-_@maguirefamily.org>
In-Reply-To: <878w1m3qmn.fsf_-_@maguirefamily.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Oct 2010 21:45:49.0101 (UTC) FILETIME=[FCD1CDD0:01CB748D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/25/2010 02:32 PM, Camm Maguire wrote:
> Greetings!  Can gdb be made to work on mips64?
>

You have to have a 64-bit toolchain.

Then something like this (untested):

CC='mips64-linux-gnu -mabi=64' configure --host=mips64-linux 
--target=mips64-linux.

I don't think a 32-bit gdb can debug 64-bit processes :-(.

David Daney


> (gdb) r
> Starting program: /home/camm/gcl-2.6.8pre/unixport/saved_pre_gcl
> /home/wingsun/develop/build/gdb/gdb-6.8/gdb/mips-tdep.c:603: internal-error: bad register size
> A problem internal to GDB has been detected,
> further debugging may prove unreliable.
>
> Take care,
