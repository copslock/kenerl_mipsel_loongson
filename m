Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2018 23:55:10 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:40238 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992479AbeCSWy7F7VwL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2018 23:54:59 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 19 Mar 2018 22:54:42 +0000
Received: from [10.20.78.81] (10.20.78.81) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Mon, 19 Mar 2018 15:52:44 -0700
Date:   Mon, 19 Mar 2018 22:52:24 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Ben Hutchings <ben@decadent.org.uk>
CC:     Alexandre Oliva <lxoliva@fsfla.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: 3.16.55-stable breaks yeeloong
In-Reply-To: <alpine.DEB.2.00.1803190706520.2163@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1803192231480.2163@tp.orcam.me.uk>
References: <ortvtd4gxf.fsf@lxoliva.fsfla.org> <1521416975.2495.186.camel@decadent.org.uk> <alpine.DEB.2.00.1803190706520.2163@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1521500080-298553-6812-4188-7
X-BESS-VER: 2018.3-r1803192001
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191215
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

On Mon, 19 Mar 2018, Maciej W. Rozycki wrote:

> > > Commit 304acb717e5b67cf56f05bc5b21123758e1f7ea0 AKA
> > > https://patchwork.linux-mips.org/patch/9705/ was backported to 3.16.55
> > > stable as 8605aa2fea28c0485aeb60c114a9d52df1455915 and I'm afraid it
> > > causes yeeloongs to fail to boot up.  3.16.54 was fine; bisection took
> > > me to this patch.
[...]
> > Guenter Roeck reported the same problem on QEMU Malta emulation.
> > I haven't yet ivnestigated why this causes breakage.  I will aim to fix
> > this in the next update (will be 3.16.57 now), if necessary by
> > reverting that and whatever depends on it.
> 
>  I'll see if I can trigger it with my development setup and investigate.

 OK, I have been able to reproduce the crash and I can see what is going 
on here: the backport didn't take into account a change from `break' to 
`goto out' required for code in `do_cpu' in that old version and 
consequently `force_sig(SIGILL, current)' is reached whenever the first 
FPU instruction is executed on hard-float hardware, with obvious 
consequences.

 Rather than messing with commit 304acb717e5b ("MIPS: Set `si_code' for 
SIGFPE signals sent from emulation too") though, I suggest cherry-picking 
commit 27e28e8ec47a ("MIPS: Normalise code flow in the CpU exception 
handler"), which was in the original series and which I have verified to 
remove the crash.  I believe it is obvious enough to be considered safe to 
backport.

 Please let me know if you need anything else from me.

  Maciej
