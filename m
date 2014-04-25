Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 19:00:31 +0200 (CEST)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:55739 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843070AbaDYRA327OGf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 19:00:29 +0200
Received: by mail-ie0-f171.google.com with SMTP id ar20so4124452iec.30
        for <multiple recipients>; Fri, 25 Apr 2014 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=W041s+LIn+IUWgghvtpugH4QmgFIsw0suXI/npQMxBU=;
        b=Qirn7k62SqLAog0jHcIT5xujKwn8WBLDNnNQBSFIYEbdFX/EFiMXrSNNep0ihnrtSJ
         oRgpO7RFYc4e1kTsT4MvodSY4X9XFoiqkSToAYeAVl/m24tYUlD5uKhMNWqRzikLUSYy
         +U2gDSoOZOhf1+ja6c6R5eIanjjb/0qFAChLK/PDO7iTNy+U8JIMfhBG/12zQpjQ1rkm
         EMg9f7WJxsgSEq2UV2JiV6kqmz9n8ldYZnjjPYqlFwrWrMGiuA6/RyKHlMfYd3IRQptk
         blzQGtzJHwskL0qjrgWipaVbIcLoXzAmQfZBGB/nir5g8YQjnzflV/wl/PkRIwu06bAh
         PxJw==
X-Received: by 10.50.45.102 with SMTP id l6mr6430074igm.16.1398445223120;
        Fri, 25 Apr 2014 10:00:23 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id z4sm9970252igl.13.2014.04.25.10.00.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 10:00:22 -0700 (PDT)
Message-ID: <535A94A5.1040200@gmail.com>
Date:   Fri, 25 Apr 2014 10:00:21 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 11/21] MIPS: KVM: Rewrite count/compare timer emulation
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com> <1398439204-26171-12-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1398439204-26171-12-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

[...]
> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
> index f56bb699506e..57c1085fd6ab 100644
> --- a/arch/mips/include/asm/kvm_host.h
> +++ b/arch/mips/include/asm/kvm_host.h
> @@ -404,8 +404,15 @@ struct kvm_vcpu_arch {
>
>   	u32 io_gpr;		/* GPR used as IO source/target */
>
> -	/* Used to calibrate the virutal count register for the guest */
> -	int32_t host_cp0_count;
> +	struct hrtimer comparecount_timer;
> +	/* Count bias from the raw time */
> +	uint32_t count_bias;
> +	/* Frequency of timer in Hz */
> +	uint32_t count_hz;

We are currently running with timer frequencies of over 2GHz, so the 
width of this variable is close to the limit.

Your follow-on patch exports this to user-space as part of the KVM ABI.

I would suggest, at least for the user-space ABI, to make this a 64-bit 
wide value.


> +	/* Dynamic nanosecond bias (multiple of count_period) to avoid overflow */
> +	s64 count_dyn_bias;
> +	/* Period of timer tick in ns */
> +	u64 count_period;
>
>   	/* Bitmask of exceptions that are pending */
[...]
