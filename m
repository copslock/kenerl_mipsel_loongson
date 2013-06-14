Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 15:21:49 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:64473 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824793Ab3FNNVrniltS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jun 2013 15:21:47 +0200
Received: by mail-la0-f44.google.com with SMTP id er20so533907lab.17
        for <linux-mips@linux-mips.org>; Fri, 14 Jun 2013 06:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=GRr+IGJ9m/ZDRGoW7mfRd2ZCNe1142nXWSqpKwTps6Y=;
        b=h/m+Mb49v5em2xrki1unWrOCKBPCRmYKgowP6BaYLg/HQHVX78jF1G0/zgmIZU9wYT
         xDO3eC85xgTP6m4vqZOcbPIysewkzbs4ttkaWzrqiWUt1dvw49Z0ibw5Wa5zgPVSPjpX
         LVJwfgbKB9zDEmjc4U2pL9KEImxY6yCYXqPioiOfcFP4K6fTxotBFkfTwyJvWlUgjqrV
         WOmt70kzAQIVDpRkNciguAizp6+/+8eSH0SGwtKxQ25GRqG2epvmDCKsD9SUfiz7WESo
         P6b7vU1QkF9dTz6dollhSghvqPwBqesot0B1LYpmVe1Hy9Qon16WiRimJXofF1ICFgGj
         C7uA==
X-Received: by 10.112.11.194 with SMTP id s2mr1120129lbb.41.1371216101830;
        Fri, 14 Jun 2013 06:21:41 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-154-241.pppoe.mtu-net.ru. [91.76.154.241])
        by mx.google.com with ESMTPSA id uo8sm882446lbb.5.2013.06.14.06.21.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 06:21:40 -0700 (PDT)
Message-ID: <51BB18DF.1080702@cogentembedded.com>
Date:   Fri, 14 Jun 2013 17:21:35 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 03/31] mips/kvm: Fix 32-bitisms in kvm_locore.S
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com> <1370646215-6543-4-git-send-email-ddaney.cavm@gmail.com> <20130614130933.GE15775@linux-mips.org>
In-Reply-To: <20130614130933.GE15775@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkpUgGa+TDxmBChGpisYzlyW3drxKbeW+jD9eTa2Yq9uxGlDgte7aG0E88Jm2eDp9MVvLfU
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36888
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

Hello.

On 14-06-2013 17:09, Ralf Baechle wrote:

>> diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/kvm_locore.S
>> index dca2aa6..e86fa2a 100644
>> --- a/arch/mips/kvm/kvm_locore.S
>> +++ b/arch/mips/kvm/kvm_locore.S
>> @@ -310,7 +310,7 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
>>       LONG_S  t0, VCPU_R26(k1)
>>
>>       /* Get GUEST k1 and save it in VCPU */
>> -    la      t1, ~0x2ff
>> +	PTR_LI	t1, ~0x2ff
>>       mfc0    t0, CP0_EBASE
>>       and     t0, t0, t1
>>       LONG_L  t0, 0x3000(t0)
>> @@ -384,14 +384,14 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
>>       mtc0        k0, CP0_DDATA_LO
>>
>>       /* Restore RDHWR access */
>> -    la      k0, 0x2000000F
>> +	PTR_LI	k0, 0x2000000F
>>       mtc0    k0,  CP0_HWRENA
>>
>>       /* Jump to handler */
>>   FEXPORT(__kvm_mips_jump_to_handler)
>>       /* XXXKYMA: not sure if this is safe, how large is the stack?? */
>>       /* Now jump to the kvm_mips_handle_exit() to see if we can deal with this in the kernel */
>> -    la          t9,kvm_mips_handle_exit
>> +	PTR_LA	t9, kvm_mips_handle_exit
>>       jalr.hb     t9
>>       addiu       sp,sp, -CALLFRAME_SIZ           /* BD Slot */
>>
>> @@ -566,7 +566,7 @@ __kvm_mips_return_to_host:
>>       mtlo    k0
>>
>>       /* Restore RDHWR access */
>> -    la      k0, 0x2000000F
>> +	PTR_LI	k0, 0x2000000F
>>       mtc0    k0,  CP0_HWRENA

> Technically ok, there's only a formatting issue because you indent the
> changed lines with tabs while the existing file uses tab characters.

    I hope you meant the space characters? :-)

> I suggest you insert an extra cleanup patch to properly re-indent the
> entire file into the series before this one?

> So with that sorted:

> Acked-by: Ralf Baechle <ralf@linux-mips.org>

>    Ralf

WBR, Sergei
