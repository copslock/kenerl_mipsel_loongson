Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2012 13:46:35 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4613 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823021Ab2LQMqaYmi0t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Dec 2012 13:46:30 +0100
Received: from [10.9.200.133] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 17 Dec 2012 04:41:24 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 17 Dec 2012 04:45:32 -0800
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 283F940FE4; Mon, 17
 Dec 2012 04:45:47 -0800 (PST)
Date:   Mon, 17 Dec 2012 18:16:11 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "Manuel Lauss" <manuel.lauss@gmail.com>
cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "John Crispin" <blogic@openwrt.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Zi Shen Lim" <zlim@netlogicmicro.com>
Subject: Re: [PATCH v2] MIPS: perf: fix build failure in XLP perf
 support.
Message-ID: <20121217124610.GA30888@jayachandranc.netlogicmicro.com>
References: <1355729179-5442-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1355729179-5442-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7CD1CD7E39W12673483-15-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 35303
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

On Mon, Dec 17, 2012 at 08:26:19AM +0100, Manuel Lauss wrote:
> Commit 4be3d2f3966b9f010bb997dcab25e7af489a841e ("MIPS: perf: Add
> XLP support for hardware perf.") added UNSUPPORTED_PERF_EVENT_ID
> which was removed a while back.
> 
> Cc: Zi Shen Lim <zlim@netlogicmicro.com>
> Cc: Jayachandran C <jchandra@broadcom.com>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> v2: one escaped me and I left the array in a bad state. Now fixed and compile tested!
> 
> Against Linus' latest -git.  That's also where the commit-id is from.
> 
>  arch/mips/kernel/perf_event_mipsxx.c | 38 ------------------------------------
>  1 file changed, 38 deletions(-)
> 

Acked-by: Jayachandran C <jchandra@broadcom.com>

Thanks for fixing this up, I did not notice the perf change [c5600b] which went
into 3.7 when submitting the patch. Sorry for the breakage.

JC.
