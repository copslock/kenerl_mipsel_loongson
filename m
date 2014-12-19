Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 09:54:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15278 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007783AbaLSIyj6BuL2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 09:54:39 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EC5573562F7A2;
        Fri, 19 Dec 2014 08:54:32 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 19 Dec 2014 08:54:34 +0000
Received: from [192.168.154.125] (192.168.154.125) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 19 Dec
 2014 08:54:32 +0000
Message-ID: <5493E7C8.4020302@imgtec.com>
Date:   Fri, 19 Dec 2014 08:54:32 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Joshua Kinard <kumba@gentoo.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC 47/67] MIPS: kernel: branch: Prevent BEQL emulation
 for MIPS R6
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-48-git-send-email-markos.chandras@imgtec.com> <54936992.2070302@gentoo.org>
In-Reply-To: <54936992.2070302@gentoo.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44830
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

On 12/18/2014 11:56 PM, Joshua Kinard wrote:
> On 12/18/2014 10:09, Markos Chandras wrote:
>> MIPS R6 removed the BEQL instruction so do not try to emulate it
>> if the R2-to-R6 emulator is not present.
> 
> How does this affect code for the old ISAs, MIPS-II to MIPS-IV?  I.e., the SGIs
> and the R10K CPUs that have to worry about the R10000_LLSC_WAR workaround and
> use branch-likely insns?
> 
> --J
> 

it does not affect them (or should not affect them). In case of *any*
non-R6 core, the NO_R6EMU macro is false, so all the conditionals here
are evaluated to false and the branch emulation will do the right thing.

-- 
markos
