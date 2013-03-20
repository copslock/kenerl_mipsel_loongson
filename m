Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Mar 2013 18:59:37 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:2022 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834901Ab3CTR7fz15U6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Mar 2013 18:59:35 +0100
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 20 Mar 2013 10:52:32 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 20 Mar 2013 10:59:24 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 20 Mar 2013 10:59:24 -0700
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 68FAA40FE3; Wed, 20
 Mar 2013 10:59:23 -0700 (PDT)
Date:   Wed, 20 Mar 2013 23:31:04 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "David Daney" <ddaney.cavm@gmail.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: mm: Use scratch for PGD when
 !CONFIG_MIPS_PGD_C0_CONTEXT
Message-ID: <20130320180104.GA8100@jayachandranc.netlogicmicro.com>
References: <cover.1363772750.git.jchandra@broadcom.com>
 <0b28a7e2191bcaab55ecb362042f8c46da186b7c.1363772750.git.jchandra@broadcom.com>
 <5149E7A4.3040906@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5149E7A4.3040906@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7D5728EA3YC6394654-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 35921
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

On Wed, Mar 20, 2013 at 09:45:24AM -0700, David Daney wrote:
> On 03/20/2013 09:27 AM, Jayachandran C wrote:
> >Allow usage of scratch register for current pgd even when
> >MIPS_PGD_C0_CONTEXT is not configured.  MIPS_PGD_C0_CONTEXT is set
> >for 64r2 platforms to indicate availability of Xcontext for saving
> >cpuid, thus freeing Context which was used for cpuid to be used for
> >saving PGD. This option was also tied to using a scratch register for
> >storing PGD.
> >
> >This commit will allow usage of scratch register to store the current
> >pgd if one can be allocated for the platform, even when
> >MIPS_PGD_C0_CONTEXT is not set. The cpu id will be kept in the CP0
> >Context register in this case.
> 
> 
> The point of MIPS_PGD_C0_CONTEXT is really to indicate that the PGD
> pointer is stored in a register (or portion thereof) and that
> setting the PGD is done by calling into uasm generated code.
> 
> Perhaps we should rename this Kconfig vairable so that its name
> indicates its function, or remove it altogether if possible, and
> machine generate the setting of the PGD pointer even when it is
> stored in the array in memory.

Removing the MIPS_PGD_C0_CONTEXT Kconfig variable does not look feasible.
The processor id is used by get_saved_sp macro and it needs to know at
compile time whether the processor id is in Context or Xcontext. We could
call it something like MIPS_PROCESSOR_ID_IN_XCONTEXT (if it would not
affect too many config files).

The second part (generating code for setting PGD pointer in pgd_current) is
already in the patch. This generated code also saves PGD to the scratch
register if one was allocated.

JC.
