Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 10:25:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52443 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012150AbbELIZzan0WR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 10:25:55 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id ECB6629011969;
        Tue, 12 May 2015 09:25:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 12 May 2015 09:23:49 +0100
Received: from [192.168.154.77] (192.168.154.77) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 12 May
 2015 09:23:48 +0100
Message-ID: <5551B894.9000204@imgtec.com>
Date:   Tue, 12 May 2015 09:23:48 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: Re: IP28: "Inconsistent ISA" messages during kernel build
References: <55516EF3.7010706@gentoo.org>
In-Reply-To: <55516EF3.7010706@gentoo.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.77]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47337
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

On 05/12/2015 04:09 AM, Joshua Kinard wrote:
> 
> Has anyone tried to build an IP28 kernel lately?  I've been getting quite a few
> warnings out of the linker regarding e_flags and the new .MIPS.abiflags stuff.
>  Not seen it on the other SGI platforms, so I am assuming this has something to
> do with what flags are passed to the compiler/linker.
> 
> mips64-unknown-linux-gnu-ld: fs/ext4/symlink.o: warning: Inconsistent ISA
> between e_flags and .MIPS.abiflags
> mips64-unknown-linux-gnu-ld: fs/ext4/symlink.o: warning: Inconsistent ISA
> extensions between e_flags and .MIPS.abiflags
> 
> Seeing this on a build of 4.0.2 based off of a 20150418 checkout from git.
> 
> --J
> 
Hi,

I presume you are using binutils >= 2.25? I have seen this problem in my
local build tests as well and I discussed this with Matthew (now on CC).
It seems it's an 'innocent' warning added to binutils 2.25 but I am not
sure if this is now fixed or not. Matthew might be able to provide more
information.

-- 
markos
