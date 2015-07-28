Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jul 2015 10:39:07 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33719 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008738AbbG1IjGDX9jP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Jul 2015 10:39:06 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6S8d50e022538;
        Tue, 28 Jul 2015 10:39:05 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6S8d5xA022537;
        Tue, 28 Jul 2015 10:39:05 +0200
Date:   Tue, 28 Jul 2015 10:39:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Guenter Roeck <linux@roeck-us.net>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/16] MIPS: remove outdated comments in sigcontext.h
Message-ID: <20150728083905.GE30938@linux-mips.org>
References: <1438027107-24420-1-git-send-email-paul.burton@imgtec.com>
 <1438027107-24420-2-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438027107-24420-2-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Jul 27, 2015 at 12:58:12PM -0700, Paul Burton wrote:

> The offsets to various fields within struct sigcontext are declared
> using asm-offsets.c these days, so drop the outdated comment that talks
> about keeping in sync with a no longer present file.

The file was renamed not removed and the comment still applies.  I've
recently fixed the comment so this patch again is against would reject
aside of being wrong so I'm dropping it.

> diff --git a/arch/mips/include/uapi/asm/sigcontext.h b/arch/mips/include/uapi/asm/sigcontext.h
> index 6c9906f..ae78902 100644
> --- a/arch/mips/include/uapi/asm/sigcontext.h
> +++ b/arch/mips/include/uapi/asm/sigcontext.h
> @@ -14,10 +14,6 @@
>  
>  #if _MIPS_SIM == _MIPS_SIM_ABI32
>  
> -/*
> - * Keep this struct definition in sync with the sigcontext fragment
> - * in arch/mips/tools/offset.c
> - */
>  struct sigcontext {
>  	unsigned int		sc_regmask;	/* Unused */
>  	unsigned int		sc_status;	/* Unused */
> @@ -45,9 +41,6 @@ struct sigcontext {
>  
>  #include <linux/posix_types.h>
>  /*
> - * Keep this struct definition in sync with the sigcontext fragment
> - * in arch/mips/tools/offset.c
> - *

  Ralf
