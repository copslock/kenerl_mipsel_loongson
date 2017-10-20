Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 22:49:15 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.150.246]:40457 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992181AbdJTUtFup5ML (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Oct 2017 22:49:05 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 20 Oct 2017 20:48:09 +0000
Received: from [10.20.78.35] (10.20.78.35) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Fri, 20 Oct 2017 13:47:29 -0700
Date:   Fri, 20 Oct 2017 21:47:51 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     <linux-mips@linux-mips.org>,
        Dragan Cecavac <dragan.cecavac@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        James Hogan <jhogan@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: kernel: proc: Remove spurious white space in
 cpuinfo
In-Reply-To: <1508509203-30661-1-git-send-email-aleksandar.markovic@rt-rk.com>
Message-ID: <alpine.DEB.2.00.1710202129250.3886@tp.orcam.me.uk>
References: <1508509203-30661-1-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1508532486-298555-4759-168240-15
X-BESS-VER: 2017.12-r1710102214
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186156
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
X-archive-position: 60512
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

On Fri, 20 Oct 2017, Aleksandar Markovic wrote:

> Remove unnecessary space from FPU info segment of /proc/cpuinfo.

 NAK.  As I recall back in Nov 2001 I placed the extra space there to 
visually separate the CPU part from the FPU part, e.g.:

cpu model		: R3000A V3.0  FPU V4.0
cpu model		: SiByte SB1 V0.2  FPU V0.2

etc.  And the motivation behind it still stands.  Please remember that 
/proc/cpuinfo is there for live humans to parse and grouping all these 
pieces together would make it harder.  Which means your change adds no 
value I'm afraid.

 NB regrettably back in those days much of the patch traffic happened off 
any mailing list, however I have quickly tracked down my archival copy of 
the original submission of the change introducing this piece of code and
I'll be happy to share it with anyone upon request.

  Maciej
