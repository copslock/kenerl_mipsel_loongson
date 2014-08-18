Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2014 10:22:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17643 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822257AbaHRIWYNH2Lb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Aug 2014 10:22:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C4F57985A7337
        for <linux-mips@linux-mips.org>; Mon, 18 Aug 2014 09:22:15 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 18 Aug 2014 09:22:17 +0100
Received: from localhost (192.168.154.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 18 Aug
 2014 09:22:16 +0100
Date:   Mon, 18 Aug 2014 09:22:16 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/2] MIPS64/O32 seccomp fixes
Message-ID: <20140818082216.GA32372@mchandras-linux.le.imgtec.org>
References: <1406200202-10104-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1406200202-10104-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.158]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

On Thu, Jul 24, 2014 at 12:10:00PM +0100, Markos Chandras wrote:
> Hi,
> 
> A few seccomp fixes related to O32 processes on MIPS64 cores.
> 
> It's based on v3.16-rc6
> 
> Markos Chandras (2):
>   MIPS: syscall: Fix AUDIT value for O32 processes on MIPS64
>   MIPS: scall64-o32: Fix indirect syscall detection
> 
>  arch/mips/include/asm/syscall.h |  8 +++++---
>  arch/mips/kernel/scall64-o32.S  | 12 ++++++++----
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> -- 
> 2.0.2
> 

Hi Ralf,

ping?

-- 
markos
