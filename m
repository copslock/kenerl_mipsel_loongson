Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 05:39:08 +0200 (CEST)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:35410
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991808AbeHUDjBWX8ep (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 05:39:01 +0200
Received: by mail-pg1-x543.google.com with SMTP id z4-v6so2802746pgv.2;
        Mon, 20 Aug 2018 20:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4eDeCuaoR2lSRG13UqHTblSOwrIFDyHOJQxVV9sNDA=;
        b=OHnpzTxIU1RFPdVe/CMr93FhuW1/Gr2WM6FNZ0sk0JfGZhyCyGTHkUKBTtQzAvURSp
         7lrdQ+nIpkuBDutB5w/A1qj3wDwM7IOzJw+Y/frc38CkTf71DaxqzHuTdYm8fO1SKr4d
         Jvzi4ADtLBPrPXtrdUwhrhmiOizB+7jngwZVO2mQHAaNKR0fusH/O0gB/WhluyLPfgXn
         jnQS2o1I9RRobyGVOEBIrkh+GicE4GTYSRJn+bKVXLB6n56XDMgt4FyAYdDW723qgt/P
         micg5FnyC0WynLMo+CHQpc20HK/C34k50Za4aBBH/suSR8V/qMS6TVl6dvCK+fQSG1TR
         fwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4eDeCuaoR2lSRG13UqHTblSOwrIFDyHOJQxVV9sNDA=;
        b=C/bPMMRBxhxU5uv5d/dGda8dhMqu6WbCjk4Cjjw4icXUz5qpjIsIGnLcFcPaApJ0DS
         hY2lj0euZJ8fnU6oZ83xHOTd68bLf/BdnAk0KQ7qyVWLzi3E/Gho7xmw5MmodsuQnsmK
         bcwO9xCGG+gxe+HzcrRTlNX0cLnoxASlEq/zW4uo32zUCyrlD3fd4rUT2IpUZ6/FBwKp
         sJ0WCGib9TTI2SWCnCY489Jx9wZVq5kPGzTZ84VYo+ZOHeOM0E4Qnkg3ryFaWd4y66xi
         KNj/GqAD5AaMAigFxNNqsnnGuY9zRGFwd+msWueiP5wy0a5wfqqkyY829Yr5ds/DdT8a
         lBBw==
X-Gm-Message-State: AOUpUlFAtLndgpE/Z8FlE1bKslBXqZt/bwE7JCJqLve+HfXv3DvZol4S
        NChtptsrqaowIkhfFMs2EBY=
X-Google-Smtp-Source: AA+uWPxl8NONXRWGN2usS2i/V1I8YIJ5RHoEwC62vW8GSdRyz/BlME7vnIAZl7YenOHxVZgyWMyAEg==
X-Received: by 2002:a62:954:: with SMTP id e81-v6mr51176719pfd.231.1534822734906;
        Mon, 20 Aug 2018 20:38:54 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id z19-v6sm16765357pgi.33.2018.08.20.20.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 20:38:53 -0700 (PDT)
Date:   Tue, 21 Aug 2018 13:38:42 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Stewart Smith <stewart@linux.ibm.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [Skiboot] [PATCH] opal/hmi: Wakeup the cpu before reading
 core_fir
Message-ID: <20180821133842.1b13e972@roar.ozlabs.ibm.com>
In-Reply-To: <20180820140605.11846-1-vaibhav@linux.ibm.com>
References: <20180820183417.dejfsluih7elbclu@pburton-laptop>
        <20180820223618.22319-1-paul.burton@mips.com>
        <20180820223618.22319-2-paul.burton@mips.com>
        <20180820140605.11846-1-vaibhav@linux.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <npiggin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: npiggin@gmail.com
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

On Mon, 20 Aug 2018 19:36:05 +0530
Vaibhav Jain <vaibhav@linux.ibm.com> wrote:

> When stop state 5 is enabled, reading the core_fir during an HMI can
> result in a xscom read error with xscom_read() returning the
> OPAL_XSCOM_PARTIAL_GOOD error code and core_fir value of all FFs. At
> present this return error code is not handled in decode_core_fir()
> hence the invalid core_fir value is sent to the kernel where it
> interprets it as a FATAL hmi causing a system check-stop.
> 
> This can be prevented by forcing the core to wake-up using before
> reading the core_fir. Hence this patch wraps the call to
> read_core_fir() within calls to dctl_set_special_wakeup() and
> dctl_clear_special_wakeup().

Would it be feasible to enumerate the ranges of scoms that require
special wakeup and check for those in xscom_read/write, and warn if
spwkup was not set?

Thanks,
Nick

> 
> Suggested-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Signed-off-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  core/hmi.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/core/hmi.c b/core/hmi.c
> index 1f665a2f..67c520a0 100644
> --- a/core/hmi.c
> +++ b/core/hmi.c
> @@ -379,7 +379,7 @@ static bool decode_core_fir(struct cpu_thread *cpu,
>  {
>  	uint64_t core_fir;
>  	uint32_t core_id;
> -	int i;
> +	int i, swkup_rc = OPAL_UNSUPPORTED;
>  	bool found = false;
>  	int64_t ret;
>  	const char *loc;
> @@ -390,14 +390,15 @@ static bool decode_core_fir(struct cpu_thread *cpu,
>  
>  	core_id = pir_to_core_id(cpu->pir);
>  
> +	/* Force the core to wakeup, otherwise reading core_fir is unrealiable
> +	 * if stop-state 5 is enabled.
> +	 */
> +	swkup_rc = dctl_set_special_wakeup(cpu);
> +
>  	/* Get CORE FIR register value. */
>  	ret = read_core_fir(cpu->chip_id, core_id, &core_fir);
>  
> -	if (ret == OPAL_HARDWARE) {
> -		prerror("XSCOM error reading CORE FIR\n");
> -		/* If the FIR can't be read, we should checkstop. */
> -		return true;
> -	} else if (ret == OPAL_WRONG_STATE) {
> +	if (ret == OPAL_WRONG_STATE) {
>  		/*
>  		 * CPU is asleep, so it probably didn't cause the checkstop.
>  		 * If no other HMI cause is found a "catchall" checkstop
> @@ -407,11 +408,16 @@ static bool decode_core_fir(struct cpu_thread *cpu,
>  		prlog(PR_DEBUG,
>  		      "FIR read failed, chip %d core %d asleep\n",
>  		      cpu->chip_id, core_id);
> -		return false;
> +		goto out;
> +	} else if (ret != OPAL_SUCCESS) {
> +		prerror("XSCOM error reading CORE FIR\n");
> +		/* If the FIR can't be read, we should checkstop. */
> +		found = true;
> +		goto out;
>  	}
>  
>  	if (!core_fir)
> -		return false;
> +		goto out;
>  
>  	loc = chip_loc_code(cpu->chip_id);
>  	prlog(PR_INFO, "[Loc: %s]: CHIP ID: %x, CORE ID: %x, FIR: %016llx\n",
> @@ -426,6 +432,9 @@ static bool decode_core_fir(struct cpu_thread *cpu,
>  						|= xstop_bits[i].reason;
>  		}
>  	}
> +out:
> +	if (!swkup_rc)
> +		dctl_clear_special_wakeup(cpu);
>  	return found;
>  }
>  
