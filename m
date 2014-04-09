Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 21:44:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:46516 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834662AbaDITnti3s0Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Apr 2014 21:43:49 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1579D9BB43A3;
        Wed,  9 Apr 2014 20:43:39 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 9 Apr 2014 20:43:42 +0100
Received: from [192.168.150.58] (192.168.150.58) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 9 Apr
 2014 12:43:40 -0700
Message-ID: <5345A2EB.8020109@imgtec.com>
Date:   Wed, 9 Apr 2014 14:43:39 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: microMIPS: Work around an assembler bug.
References: <1396892446-23883-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1396892446-23883-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.150.58]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 04/07/2014 12:40 PM, Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@imgtec.com>
> 
> In newer toolchains, the 16-bit branch delay slot instruction
> calculation is wrong. We get a message very similar to:
> 
>    {standard input}: Assembler messages:
>    {standard input}:7035: Warning: wrong size instruction
>    in a 16-bit branch delay slot
> 
> This corner case only occurs in 'arch/mips/kernel/traps.c' and
> we add the '-fno-delayed-branch' option when compiling it.
> 
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
>
I rejected this in patchwork. Just making sure you do not use it.
