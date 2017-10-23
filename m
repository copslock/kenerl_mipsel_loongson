Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2017 09:56:28 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.150.246]:52823 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990494AbdJWH4UYd6A5 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Oct 2017 09:56:20 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 23 Oct 2017 07:55:21 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Mon, 23 Oct 2017 00:54:31 -0700
From:   Miodrag Dinic <Miodrag.Dinic@mips.com>
To:     David Daney <ddaney@caviumnetworks.com>,
        Maciej Rozycki <Maciej.Rozycki@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Dragan Cecavac <Dragan.Cecavac@mips.com>,
        Aleksandar Markovic <Aleksandar.Markovic@mips.com>,
        Douglas Leung <Douglas.Leung@mips.com>,
        "Goran Ferenc" <Goran.Ferenc@mips.com>,
        James Hogan <James.Hogan@mips.com>,
        "James Hogan" <jhogan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <Paul.Burton@mips.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: [PATCH] MIPS: kernel: proc: Remove spurious white space in
 cpuinfo
Thread-Topic: [PATCH] MIPS: kernel: proc: Remove spurious white space in
 cpuinfo
Thread-Index: AQHTSa6AKc81zDqezU6JLxwEPQbWYqLtq1+AgAA0zoCAAzCuiA==
Date:   Mon, 23 Oct 2017 07:54:30 +0000
Message-ID: <48924BBB91ABDE4D9335632A6B179DD6A711BA@MIPSMAIL01.mipstec.com>
References: <1508509203-30661-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <alpine.DEB.2.00.1710202129250.3886@tp.orcam.me.uk>,<601ab9f9-5092-7e44-acf1-ba5a9f0c1962@caviumnetworks.com>
In-Reply-To: <601ab9f9-5092-7e44-acf1-ba5a9f0c1962@caviumnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1508745321-298555-4756-314565-1
X-BESS-VER: 2017.12-r1710102214
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186217
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Miodrag.Dinic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Miodrag.Dinic@mips.com
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

Hi,

the issue was found on Android using VTS, where its cpuinfo parser stumbled upon an extra space while trying to extract information about FPU.
By comparing with ARM and Intel it seemed that only MIPS had this quirk in the cpuinfo format, so we submitted this change to make it conform
to the format used by other architectures.  

However I agree that this is pretty sensitive code to userspace and it is better to leave it as is.
@Macijej, David, thank you for pointing out the risks and explanation of the origin of this extra space in the cpuinfo format.

Please ignore this change.

Kind regards,
Miodrag
________________________________________
From: David Daney [ddaney@caviumnetworks.com]
Sent: Saturday, October 21, 2017 1:56 AM
To: Maciej Rozycki; Aleksandar Markovic
Cc: linux-mips@linux-mips.org; Dragan Cecavac; Aleksandar Markovic; Douglas Leung; Goran Ferenc; James Hogan; James Hogan; linux-kernel@vger.kernel.org; Maciej W. Rozycki; Miodrag Dinic; Paul Burton; Paul Burton; Petar Jovanovic; Raghu Gandham; Ralf Baechle
Subject: Re: [PATCH] MIPS: kernel: proc: Remove spurious white space in cpuinfo

On 10/20/2017 01:47 PM, Maciej W. Rozycki wrote:
> On Fri, 20 Oct 2017, Aleksandar Markovic wrote:
>
>> Remove unnecessary space from FPU info segment of /proc/cpuinfo.
>
>   NAK.  As I recall back in Nov 2001 I placed the extra space there to
> visually separate the CPU part from the FPU part, e.g.:
>
> cpu model             : R3000A V3.0  FPU V4.0
> cpu model             : SiByte SB1 V0.2  FPU V0.2
>
> etc.  And the motivation behind it still stands.  Please remember that
> /proc/cpuinfo is there for live humans to parse and grouping all these
> pieces together would make it harder.  Which means your change adds no
> value I'm afraid.

I think it is even riskier than that.  This is part of the
kernel-userspace ABI, many programs parse this file, any gratuitous
changes risk breaking something.

I don't really have an opinion about the various *printf functions being
used, but think the resultant change in what is visible to userspace
should not be done.

>
>   NB regrettably back in those days much of the patch traffic happened off
> any mailing list, however I have quickly tracked down my archival copy of
> the original submission of the change introducing this piece of code and
> I'll be happy to share it with anyone upon request.
>
>    Maciej
>
