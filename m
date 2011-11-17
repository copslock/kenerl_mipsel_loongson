Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 23:32:05 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53326 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904068Ab1KQWcB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Nov 2011 23:32:01 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAHMW0dn006373;
        Thu, 17 Nov 2011 22:32:00 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAHMW039006371;
        Thu, 17 Nov 2011 22:32:00 GMT
Date:   Thu, 17 Nov 2011 22:32:00 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Imre Kaloz <kaloz@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/6] MIPS: ath79: remove 'ar913x' from common variable
 and function names
Message-ID: <20111117223200.GB2758@linux-mips.org>
References: <1321568027-32066-1-git-send-email-juhosg@openwrt.org>
 <1321568027-32066-3-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1321568027-32066-3-git-send-email-juhosg@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14900

On Thu, Nov 17, 2011 at 11:13:43PM +0100, Gabor Juhos wrote:

> diff --git a/arch/mips/ath79/dev-ar913x-wmac.h b/arch/mips/ath79/dev-ar913x-wmac.h
> index 579d562..de1d784 100644
> --- a/arch/mips/ath79/dev-ar913x-wmac.h
> +++ b/arch/mips/ath79/dev-ar913x-wmac.h
> @@ -9,9 +9,9 @@
>   *  by the Free Software Foundation.
>   */
>  
> -#ifndef _ATH79_DEV_AR913X_WMAC_H
> -#define _ATH79_DEV_AR913X_WMAC_H
> +#ifndef _ATH79_DEV_WMAC_H
> +#define _ATH79_DEV_WMAC_H

In this case, don't you want to rename this header file as well?

  Ralf
