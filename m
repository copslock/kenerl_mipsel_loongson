Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2015 10:04:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36603 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008613AbbJUIETbRYhn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2015 10:04:19 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 64A9C48FFE90E
        for <linux-mips@linux-mips.org>; Wed, 21 Oct 2015 09:04:12 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 21 Oct 2015 09:04:13 +0100
Received: from [192.168.154.37] (192.168.154.37) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 21 Oct
 2015 09:04:13 +0100
Subject: Re: Mips build errors in next-20151020
To:     <linux-mips@linux-mips.org>
References: <56268C80.5020903@roeck-us.net>
From:   Markos Chandras <Markos.Chandras@imgtec.com>
Message-ID: <562746FD.9030204@imgtec.com>
Date:   Wed, 21 Oct 2015 09:04:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <56268C80.5020903@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.37]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 10/20/2015 07:48 PM, Guenter Roeck wrote:
> Hi all,
> 
> all mips images fail to build for me in next-20151020 as follows.
> 
> Building mips:defconfig ... failed
> --------------
> Error log:
> /tmp/cc9iCAqK.s: Assembler messages:
> /tmp/cc9iCAqK.s:50: Error: can't resolve `_start' {*UND* section} -
> `L0' {.text section}
> /tmp/cc9iCAqK.s:374: Error: can't resolve `_start' {*UND* section} -
> `L0' {.text section}
> make[2]: *** [arch/mips/vdso/gettimeofday.o] Error 1
> make[1]: *** [arch/mips/vdso] Error 2
> 
> Toolchain is "mips-poky-linux-gcc (GCC) 4.7.2".
> 
> Do I need a new toolchain ?
> 
> Thanks,
> Guenter
> 
I am working on that with Ralf. seems like we are going to need
binutils-2.25 for the VDSO code and disable it for older versions. I
will post new patches today.

-- 
markos
