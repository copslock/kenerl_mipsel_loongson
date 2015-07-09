Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 13:09:32 +0200 (CEST)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34365 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009914AbbGILJaGCOD3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2015 13:09:30 +0200
Received: by lbnk3 with SMTP id k3so72943490lbn.1
        for <linux-mips@linux-mips.org>; Thu, 09 Jul 2015 04:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=lW8BIxsnQbUsD9Q6ZGpG8AAkB1/D3s4R+WjCDPSUxkY=;
        b=aIUJzqF8f7xlWquJUZ5fNMLuO+kkdKfblJP2NaIoVSK7mA7MYXtSQZbcqoRaETt0Wk
         mNS1nizpPNgSgV7AE3HhimeNVjaL4mlae7US1KOnEQkpvnptukdjNA+fQ32lvh/N19Z2
         G5kQzD4nHU/kWcpqz4gvoKn0CBNJUCsnQVgN4iJ3IQoTWdbNL1G2VSAZu8XOeMehi+S7
         YWb6TeFSFRNCw3c7LY/JWHJBYxzJmZc9KDCssqcknQIFl+pafiiAp5tNQskIwUg7xRSz
         CMkLGMgXe7d9kUZCfnRfJgyD2CWnLDL1U0r+3g6VRw4Dq+wkKX4pcSxOpIQQYRp/eIBs
         eQbA==
X-Gm-Message-State: ALoCoQkhgDtd2ETSnmSB6+YGI59tSOEpsqN//xJIvyeiuYZQ/ZubZ1R8BL2gWiRlRXjYjek+gxHt
X-Received: by 10.112.166.2 with SMTP id zc2mr14070219lbb.29.1436440164761;
        Thu, 09 Jul 2015 04:09:24 -0700 (PDT)
Received: from [192.168.3.154] (ppp17-200.pppoe.mtu-net.ru. [81.195.17.200])
        by smtp.gmail.com with ESMTPSA id n4sm1327636laj.44.2015.07.09.04.09.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 04:09:23 -0700 (PDT)
Subject: Re: [PATCH 05/19] MIPS: asm: mips-cm: Implement mips_cm_revision
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
References: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
 <1436434853-30001-6-git-send-email-markos.chandras@imgtec.com>
Cc:     Paul Burton <paul.burton@imgtec.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <559E5662.3010800@cogentembedded.com>
Date:   Thu, 9 Jul 2015 14:09:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
MIME-Version: 1.0
In-Reply-To: <1436434853-30001-6-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 7/9/2015 12:40 PM, Markos Chandras wrote:

> From: Paul Burton <paul.burton@imgtec.com>

> Provide a function to trivially return the version of the CM present in
> the system, or 0 if no CM is present. The mips_cm_revision() will be
> used later on to determine the CM register width, so it must not use
> the regular CM accessors to read the revision register since that will
> lead to build failures due to recursive inlines.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/include/asm/mips-cm.h | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)

> diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
> index edc7ee95269e..29ff74a629f6 100644
> --- a/arch/mips/include/asm/mips-cm.h
> +++ b/arch/mips/include/asm/mips-cm.h
> @@ -189,6 +189,13 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
>   #define CM_GCR_REV_MINOR_SHF			0
>   #define CM_GCR_REV_MINOR_MSK			(_ULCAST_(0xff) << 0)
>
> +#define CM_ENCODE_REV(major, minor) \
> +		((major << CM_GCR_REV_MAJOR_SHF) | \
> +		 ((minor) << CM_GCR_REV_MINOR_SHF))

    Enclosing 'minor' into parens and not enclosing 'major' doesn't look very 
consistent... :-)

[...]
> @@ -324,4 +331,26 @@ static inline int mips_cm_l2sync(void)
>   	return 0;
>   }
>
> +/**
> + * mips_cm_revision - return CM revision
> + *
> + * Returns the revision of the CM, from GCR_REV, or 0 if no CM is present.
> + * The return value should be checked against the CM_REV_* macros.
> + */
> +static inline int mips_cm_revision(void)
> +{
> +	static int mips_cm_revision_nr = -1;

    Won't this variable be allocated per source file (including this header)?

[...]

WBR, Sergei
