Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Dec 2012 10:02:51 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:3569 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823072Ab2LSJCqzd5C8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Dec 2012 10:02:46 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 19 Dec 2012 00:59:37 -0800
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 19 Dec 2012 01:01:41 -0800
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 2C48340FE6; Wed, 19
 Dec 2012 01:01:56 -0800 (PST)
Date:   Wed, 19 Dec 2012 14:32:29 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "Hill, Steven" <sjhill@mips.com>
cc:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Revert
 "MIPS: Optimise TLB handlers for MIPS32/64 R2 cores."
Message-ID: <20121219090228.GC3423@jayachandranc.netlogicmicro.com>
References: <1355824203-18912-1-git-send-email-jchandra@broadcom.com>
 <31E06A9FC96CEC488B43B19E2957C1B801146AB865@exchdb03.mips.com>
MIME-Version: 1.0
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B801146AB865@exchdb03.mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7CCF5E7D3R023714115-11-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 35311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Dec 19, 2012 at 05:18:35AM +0000, Hill, Steven wrote:
> JC,
> 
> Can you try to apply this patch on top of the "MIPS: Optimise TLB handlers for MIPS32/64 R2 cores." patch and let me know of the results. Thanks.

This changes does not fix the issue.  The patch did not apply cleanly since
it had micro-mips changes that is not in the linux-mips tree, so I had to
do some of the changes manually.

I'll send you a dump of the old and new TLB handlers so that you can debug
this further.

JC.
