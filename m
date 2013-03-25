Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Mar 2013 08:16:47 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:3371 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834971Ab3CYHQongFMp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Mar 2013 08:16:44 +0100
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 25 Mar 2013 00:13:44 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 25 Mar 2013 00:16:30 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 25 Mar 2013 00:16:30 -0700
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 9850B392C9; Mon, 25
 Mar 2013 00:16:25 -0700 (PDT)
Date:   Mon, 25 Mar 2013 12:48:29 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/9] MIPS: Netlogic: Remove unused EIMR/EIRR
 functions
Message-ID: <20130325071828.GA11783@jayachandranc.netlogicmicro.com>
References: <cover.1364062916.git.jchandra@broadcom.com>
 <9e189bdc53ac2650d22d18f037df89dd2e412be9.1364062916.git.jchandra@broadcom.com>
 <514E038D.50108@cogentembedded.com>
MIME-Version: 1.0
In-Reply-To: <514E038D.50108@cogentembedded.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7D5126A22U83715117-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 35973
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

On Sat, Mar 23, 2013 at 10:33:33PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 03/23/2013 09:27 PM, Jayachandran C wrote:
> 
> >Remove the definitions of {read,write}_c0_{eirr,eimr}. These functions
> >are now unused after the PIC and IRQ code has been updated to use
> >optimized EIMR/EIRR functions which work on both 32-bit and 64-bit.
> >
> >Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> >---
> >  arch/mips/include/asm/netlogic/mips-extns.h |    7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> >diff --git a/arch/mips/include/asm/netlogic/mips-extns.h b/arch/mips/include/asm/netlogic/mips-extns.h
> >index 69d18a0..f299d31 100644
> >--- a/arch/mips/include/asm/netlogic/mips-extns.h
> >+++ b/arch/mips/include/asm/netlogic/mips-extns.h
> [...]
> >@@ -140,7 +136,6 @@ static inline uint64_t read_c0_eirr_and_eimr(void)
> >  		".set	pop"
> >  		: "=r" (val));
> >  #endif
> >-
> 
>    Unrelated whitespace change.
> 
> >  	return val;
> >  }

While updating that function, I had removed an empty line which was not
really needed. Not sure if it is worth adding a line in commit message for
that.

JC.
