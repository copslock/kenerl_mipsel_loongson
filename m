Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2017 18:57:39 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:46664 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdLOR5b46mi9 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Dec 2017 18:57:31 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 15 Dec 2017 17:55:49 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Fri, 15 Dec 2017 09:55:02 -0800
From:   Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To:     Joe Perches <joe@perches.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <Douglas.Leung@mips.com>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        James Hogan <James.Hogan@mips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>,
        Paul Burton <Paul.Burton@mips.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [PATCH v11 0/3] MIPS: Add virtual Ranchu board as a
 generic-based board
Thread-Topic: [PATCH v11 0/3] MIPS: Add virtual Ranchu board as a
 generic-based board
Thread-Index: AQHTdcSzmHZkWEPSD0KVrWyNSeBmOKNFKlIA//+EoDw=
Date:   Fri, 15 Dec 2017 17:55:01 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEEC27835@MIPSMAIL01.mipstec.com>
References: <1513356553-7238-1-git-send-email-aleksandar.markovic@rt-rk.com>,<1513357944.4647.1.camel@perches.com>
In-Reply-To: <1513357944.4647.1.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1513360549-321459-4931-825-6
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188013
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Aleksandar.Markovic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@mips.com
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

> From: Joe Perches [joe@perches.com]
> Sent: Friday, December 15, 2017 6:12 PM
> 
> On Fri, 2017-12-15 at 17:48 +0100, Aleksandar Markovic wrote:
> > Checkpatch script outputs a small number of warnings if applied to
> > this series. We did not correct the code, since we think the code is
> > correct for those particular cases of checkpatch warnings.
>
> What are those warnings?  I don't see any.

Hi, Joe.

There is only one warning:

-------------------------------------------------------------------------
0003-MIPS-ranchu-Add-Ranchu-as-a-new-generic-based-board.patch
-------------------------------------------------------------------------
WARNING: DT compatible string "mti,ranchu" appears un-documented -- check ./Documentation/devicetree/bindings/
#236: FILE: arch/mips/generic/board-ranchu.c:85:
+		.compatible = "mti,ranchu",

total: 0 errors, 1 warnings, 0 checks, 153 lines checked

Thanks,
Aleksandar
