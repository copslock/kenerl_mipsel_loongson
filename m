Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2011 17:37:38 +0100 (CET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:60157 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903633Ab1KOQhb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Nov 2011 17:37:31 +0100
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
        by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 9AED08C6B9;
        Tue, 15 Nov 2011 18:37:30 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
        by vs3-10.mail.saunalahti.fi ([62.142.5.94])
        with SMTP (gateway) id A07BDE9688B; Tue, 15 Nov 2011 18:37:30 +0200
Received: from [192.168.1.153] (a88-115-188-95.elisa-laajakaista.fi [88.115.188.95])
        by emh05.mail.saunalahti.fi (Postfix) with ESMTP id A09D427D87;
        Tue, 15 Nov 2011 18:37:12 +0200 (EET)
Message-ID: <4EC29534.7010502@adurom.com>
Date:   Tue, 15 Nov 2011 18:37:08 +0200
From:   Kalle Valo <kvalo@adurom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110922 Thunderbird/3.1.15
MIME-Version: 1.0
To:     Sangwook Lee <sangwook.lee@linaro.org>
CC:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, ath9k-devel@lists.ath9k.org,
        ralf@linux-mips.org, juhosg@openwrt.org, rodrigue@qca.qualcomm.com,
        linville@tuxdriver.com, rmanohar@qca.qualcomm.com,
        patches@linaro.org
Subject: Re: [PATCH] ath9k: rename ath9k_platform.h to ath_platform.h
References: <1321356224-5053-1-git-send-email-sangwook.lee@linaro.org>
In-Reply-To: <1321356224-5053-1-git-send-email-sangwook.lee@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Antivirus: VAMS
X-archive-position: 31609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kvalo@adurom.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12592

Hi Sangwook,

On 11/15/2011 01:23 PM, Sangwook Lee wrote:
> The patch series proposes to rename ath9k_platform.h to "ath_platform.h
> This header file handles platform data used only for ath9k,
> but it can used by ath6k as well. We can take "wl12xx.h" as
> as a example. Please let us change this file name so that
> other Atheors WLANs use this file for their own platform data

ath9k and ath6kl are very different devices, I'm not sure if sharing a
platfrom struct between the two is really a good idea. Most likely there
is very little the two drivers can share. What are your plans here?

I myself was thinking that we would have include/linux/ath6kl.h
dedicated just for ath6kl. That would makes things simpler.

Kalle
