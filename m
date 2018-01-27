Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2018 10:18:35 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:36431 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990400AbeA0JS2ZSV55 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2018 10:18:28 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 27 Jan 2018 09:17:25 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Sat, 27 Jan
 2018 01:15:42 -0800
Date:   Sat, 27 Jan 2018 09:15:40 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
CC:     Kalle Valo <kvalo@codeaurora.org>, Michael Buesch <m@bues.ch>,
        <linux-wireless@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [for-4.15] ssb: Disable PCI host for PCI_DRIVERS_GENERIC
Message-ID: <20180127091540.GB21356@jhogan-linux.mipstec.com>
References: <20180115211714.24009-1-jhogan@kernel.org>
 <20180116191636.6B3E5605A4@smtp.codeaurora.org>
 <m2bmhfsm6v.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <m2bmhfsm6v.fsf@linux-m68k.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1517044645-452060-17918-31949-1
X-BESS-VER: 2018.1.1-r1801251958
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189415
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

On Sat, Jan 27, 2018 at 10:08:56AM +0100, Andreas Schwab wrote:
> On Jan 16 2018, Kalle Valo <kvalo@codeaurora.org> wrote:
> 
> > 58eae1416b80 ssb: Disable PCI host for PCI_DRIVERS_GENERIC
> 
> That breaks wireless on PowerMac!  There is nothing MIPS-specific about
> SSB.

Yes, really sorry about that. There is a patch here:
https://patchwork.kernel.org/patch/10185397/

Cheers
James
