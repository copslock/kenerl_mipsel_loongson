Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 00:04:27 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:52610 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994807AbeAaXERJ0xfC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Feb 2018 00:04:17 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx30.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 31 Jan 2018 23:04:09 +0000
Received: from [10.20.78.134] (10.20.78.134) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Wed, 31 Jan 2018
 15:01:34 -0800
Date:   Wed, 31 Jan 2018 23:01:25 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
In-Reply-To: <20180129202715.GA4817@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk> <20170920145440.GB9255@localhost.localdomain> <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk> <20170927172107.GB2631@localhost.localdomain> <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain> <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk> <20171029172016.GA2600@localhost.localdomain> <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk> <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1517439846-637140-31742-152989-9
X-BESS-VER: 2018.1-r1801290438
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189563
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
X-archive-position: 62387
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

Hi Fredrik,

> I have updated the PS2 patchset to v4.15 now. For the initial submission,
> I'm hoping to include device drivers for USB and serial support. The first
> 20 or so patches are ready for review, with 5-10 additional patches needing
> clean-ups.

 Thank you for the status update.  Let me know if I could be of help 
anyhow.

  Maciej
