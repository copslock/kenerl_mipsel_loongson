Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 00:29:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24976 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010880AbaJIW3FYse22 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 00:29:05 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B750E20280A53;
        Thu,  9 Oct 2014 23:28:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Oct 2014 23:28:57 +0100
Received: from localhost (192.168.159.30) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 9 Oct
 2014 23:28:55 +0100
Date:   Thu, 9 Oct 2014 23:28:54 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <Zubair.Kakakhel@imgtec.com>, <geert+renesas@glider.be>,
        <david.daney@cavium.com>, <peterz@infradead.org>,
        <paul.gortmaker@windriver.com>, <davidlohr@hp.com>,
        <macro@linux-mips.org>, <chenhc@lemote.com>, <richard@nod.at>,
        <zajec5@gmail.com>, <james.hogan@imgtec.com>,
        <keescook@chromium.org>, <alex@alex-smith.me.uk>,
        <tglx@linutronix.de>, <blogic@openwrt.org>,
        <jchandra@broadcom.com>, <qais.yousef@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <markos.chandras@imgtec.com>, <dengcheng.zhu@imgtec.com>,
        <manuel.lauss@gmail.com>, <akpm@linux-foundation.org>,
        <lars.persson@axis.com>
Subject: Re: [PATCH v2 0/3] MIPS executable stack protection
Message-ID: <20141009222854.GX4704@pburton-laptop>
References: <20141009195030.31230.58695.stgit@linux-yegoshin>
 <5437015B.3010205@gmail.com>
 <543709D0.6000501@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <543709D0.6000501@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.30]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Thu, Oct 09, 2014 at 03:18:56PM -0700, Leonid Yegoshin wrote:
> >The recent discussions on this subject, including many comments from
> >Imgtec e-mail addresses, brought to light the need to use an instruction
> >set emulator for newer MIPSr6 ISA processors.
> 
> In Imgtec I am only one who works on MIPS R6 SW and FPU branch emulation and
> I say you - it is not needed, this solution is enough.

On R6, yes, for some time now but you still have not submitted that code
for review. Your having worked on something does not automatically make
it correct.

On the FP branch delays, clearly not given that I submitted a similar
patch almost a year ago...

Paul
