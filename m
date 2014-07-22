Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 17:38:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52402 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6842569AbaGVOVm0zoZ8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 16:21:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B5FD9791005B1;
        Tue, 22 Jul 2014 15:21:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Jul 2014 15:21:35 +0100
Received: from [192.168.154.158] (192.168.154.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 22 Jul
 2014 15:21:34 +0100
Message-ID: <53CE736E.1060009@imgtec.com>
Date:   Tue, 22 Jul 2014 15:21:34 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Rob Kendrick <rob.kendrick@codethink.co.uk>
CC:     <linux-mips@linux-mips.org>
Subject: Re: EdgeRouter Pro supported?  Strange FP problems
References: <20140722130616.GJ30723@humdrum>
In-Reply-To: <20140722130616.GJ30723@humdrum>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.158]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41455
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

On 07/22/2014 02:06 PM, Rob Kendrick wrote:
> Hi,
> 
> I'm trying to build a kernel for an Ubiquiti EdgeRouter Pro (not a
> Lite).  I'm using the current master from linux-mti, and this produces a
> kernel that boots and has network support (but bizarrely not activity
> LEDs) and USB support, which is good.  However, what I am seeing is
> bizarre floating point behavior.
> 
> Is there a known issue with master on these Octeon2-based boards?
> Should I be pointing my finger of blame at the compiler I've built
> (using crosstool-ng) or my configuration of the kernel?
> 
> Is there a better choice of compiler and kernel to be using for these
> boards?
> 
> Thanks for any input,
> 
Hi Rob,

When you say "master from linux-mti" I presume you mean this tree:

http://git.linux-mips.org/?p=linux-mti.git;a=shortlog;h=refs/heads/master

right?

What FPU problem are you seeing exactly? Could you show us a log for the
failure? Can you post a simple test case which will allow someone to
reproduce it?

(I am also surprised you have ethernet support since the ethernet
support has not reached the mainline tree yet as far as I know
https://git.kernel.org/cgit/linux/kernel/git/gregkh/staging.git/commit/?id=ec3a2207c322e518f7f42c80e54b8ecaf8a6f03e).

-- 
markos
