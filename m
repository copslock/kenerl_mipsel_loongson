Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 19:54:24 +0100 (CET)
Received: from mail-wm0-f49.google.com ([74.125.82.49]:32967 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007545AbbLCSyXAidYf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 19:54:23 +0100
Received: by wmec201 with SMTP id c201so41594891wme.0
        for <linux-mips@linux-mips.org>; Thu, 03 Dec 2015 10:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=albanarts-com.20150623.gappssmtp.com; s=20150623;
        h=in-reply-to:references:mime-version:content-transfer-encoding
         :content-type:subject:from:date:to:message-id;
        bh=xc56LC4LH+ZsYvDyCMrg316eiJTn65aBenwX6dEEpU8=;
        b=v3Tsjjc/4s8wb6H9xPVVze62OEMGhAUAt7ReX4wVg97H9QDsSTrzrzBkk4ohyj+MBX
         88fFLVFpui7NW2ZlEMATG2JOeDU9AI0EM3GKwkjj98fahBsbYqs79iPnnew3UyjC01Q2
         /gcatRR7/NQEPab94qAj6olhPjWbRkh8QXi/kXkj1lt0Zws92E89nKRAaXj9pr5HZzGG
         i8SnPNy9Us51J4f1MVueh6HHzgJb+VVH5N1an4ibaM/jtVBsDggHpBaie22Wx6iTfA1b
         0nWBe+e2hd4FmA/NPaGuo60m2DVOraDtAFO8bQ7mgH8L75ei+EICV5Q97wIke6krGmCe
         n4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to
         :message-id;
        bh=xc56LC4LH+ZsYvDyCMrg316eiJTn65aBenwX6dEEpU8=;
        b=HNsch91pR/X8hNydjy7J8tVN4vpNukbrheJ/jnWxYj2agjfFIA9GF8V1jiTUyfgUKQ
         Cz4RBsGp8j8C6DrT7Emu4oGpSMwMgFt3H2Vl3yPwMPjGDed8smoAT2QtZun4yJD49Q7A
         syqja6k259jWsYnXuT/R2YbDzXPUVEbnRcipOMwnRTODSpLBZAR6f+wEVXpBmpba6ALK
         hHBO1yVVulGYmlKtCJyIeXuZVW8nnUC3UwMH6cLOMLTiYznmFH0gWpfJK0RjAlZtfbfS
         43haO/PHJDDQ0Wgqr1X+Rd6br2P8CCc6IC7L3tLfMepYYrqQSk+Znk1/QLlpfH3mlbo9
         apYg==
X-Gm-Message-State: ALoCoQkkn2lx9kBn2wa1PDfvu53gMemHpHcXGGn3IV2D6ibUMwvLoOQYKkg2+bjPyckh/21EeJPeVSoLHtgAF6Z7GQ0UDrwslw==
X-Received: by 10.28.101.195 with SMTP id z186mr273455wmb.52.1449168857613;
        Thu, 03 Dec 2015 10:54:17 -0800 (PST)
Received: from gollum (jahogan.plus.com. [212.159.75.221])
        by smtp.gmail.com with ESMTPSA id cw3sm8766472wjb.26.2015.12.03.10.54.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Dec 2015 10:54:16 -0800 (PST)
In-Reply-To: <56607FE6.7040001@cogentembedded.com>
References: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com> <1449137297-30464-7-git-send-email-matt.redfearn@imgtec.com> <56605081.5050307@cogentembedded.com> <5660577F.2020401@imgtec.com> <56607FE6.7040001@cogentembedded.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 6/9] MIPS: Call relocate_kernel if CONFIG_RELOCATABLE=y
From:   James Hogan <james@albanarts.com>
Date:   Thu, 03 Dec 2015 18:54:07 +0000
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org
Message-ID: <BA73413A-D335-4692-85A4-9330D7ACAC03@albanarts.com>
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james@albanarts.com
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

On 3 December 2015 17:46:14 GMT+00:00, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:
>On 12/03/2015 05:53 PM, Matt Redfearn wrote:
>
>>>> If CONFIG_RELOCATABLE is enabled, jump to relocate_kernel.
>>>>
>>>> This function will return the entry point of the relocated kernel
>if
>>>> copy/relocate is sucessful or the original entry point if not. The
>stack
>>>> pointer must then be pointed into the new image.
>>>>
>>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>>> ---
>>>>   arch/mips/kernel/head.S | 20 ++++++++++++++++++++
>>>>   1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
>>>> index 4e4cc5b9a771..7dc043349d66 100644
>>>> --- a/arch/mips/kernel/head.S
>>>> +++ b/arch/mips/kernel/head.S
>>>> @@ -132,7 +132,27 @@ not_found:
>>>>       set_saved_sp    sp, t0, t1
>>>>       PTR_SUBU    sp, 4 * SZREG        # init stack pointer
>>>>
>>>> +#ifdef CONFIG_RELOCATABLE
>>>> +    /* Copy kernel and apply the relocations */
>>>> +    jal        relocate_kernel
>>>> +
>>>> +    /* Repoint the sp into the new kernel image */
>>>> +    PTR_LI        sp, _THREAD_SIZE - 32 - PT_SIZE
>>>> +    PTR_ADDU    sp, $28
>>>
>>>    Can't you account for it in the previous PTR_LI?
>
>> During relocate_kernel, $28, pointer to the current thread,
>
>Ah, it's a register! I thought it was an immediate. Nevermind then. :-)

Although, it could still be reduced:
PTR_ADDU sp, gp, _THREAD_SIZE - 32 - PT_SIZE

Assuming the immediate is in range of signed 16bit.

Cheers
James

>
>[...]
>
>MBR, Sergei


-- 
James Hogan
