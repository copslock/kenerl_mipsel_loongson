Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2015 12:11:38 +0200 (CEST)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34720 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009350AbbJPKLgTvVod (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2015 12:11:36 +0200
Received: by wicgb1 with SMTP id gb1so2771114wic.1
        for <linux-mips@linux-mips.org>; Fri, 16 Oct 2015 03:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=p9oYL5o8gBT04NGcEPow4sJmI36+Jq8hIkeSNFreQLw=;
        b=NkeumnqDD55QlfIgKUBGsQX2vfPd8yO+GNRcILGKLkaS8EU/c6I1OmW3cBm6rQPq15
         ypX2x9mcXWKE27h//L6rPl1DBkS6MUVX/3WJuWqv9FzcwU20WhrpQxNX/dEaxEtbYF48
         GB8cBz5HhbkLk4bHdjjaryy9B+Mtky0PZGjepW8L21lngTy0s7wDk9J8JSkvkupokhL1
         HdA6uc2f6SZq/evusuAZMbCxI1X8ZI5AgJl1b5bHStkORZxvD4iJqV0FlEIfGWhl2p/f
         zpt7D1HQmj6sO+6E6lTlwReF8XD+r5pmaFQ1p1OH0zzlDlEUPiikSSaRsfiFb9W5UABr
         RGhg==
X-Gm-Message-State: ALoCoQmE2zvLgsGoC9r1qD5QlNl67IAZ1mnvTcKioYS+WztbhHxWOUYgvc27/KqPaD4pGOeINR6Y
MIME-Version: 1.0
X-Received: by 10.180.87.138 with SMTP id ay10mr3849569wib.12.1444990289728;
 Fri, 16 Oct 2015 03:11:29 -0700 (PDT)
Received: by 10.27.11.144 with HTTP; Fri, 16 Oct 2015 03:11:29 -0700 (PDT)
In-Reply-To: <20151015084727.GG14475@jhogan-linux.le.imgtec.org>
References: <1444148837-10770-1-git-send-email-harvey.hunt@imgtec.com>
        <1444148837-10770-4-git-send-email-harvey.hunt@imgtec.com>
        <20151015084727.GG14475@jhogan-linux.le.imgtec.org>
Date:   Fri, 16 Oct 2015 11:11:29 +0100
Message-ID: <CAOFt0_D5mO-7_cnpvm_MwvsZNv1yCFynbeA3dSw=H5hVyQbgTA@mail.gmail.com>
Subject: Re: [PATCH v7,3/3] MIPS: dts: jz4780/ci20: Add NEMC, BCH and NAND
 device tree nodes
From:   Alex Smith <alex@alex-smith.me.uk>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Harvey Hunt <harvey.hunt@imgtec.com>,
        linux-mtd@lists.infradead.org, Alex Smith <alex.smith@imgtec.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
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

Hi James,

On 15 October 2015 at 09:47, James Hogan <james.hogan@imgtec.com> wrote:
>> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
>> index 9fcb9e7..453f1d3 100644
>> --- a/arch/mips/boot/dts/ingenic/ci20.dts
>> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
>> @@ -42,3 +42,57 @@
>>  &uart4 {
>>       status = "okay";
>>  };
>> +
>> +&nemc {
>> +     status = "okay";
>> +
>> +     nand: nand@1 {
>> +             compatible = "ingenic,jz4780-nand";
>
> Isn't the NAND a micron part? This doesn't seem right. Is the device
> driver and binding already accepted upstream with that compatible
> string?

This is the compatible string for the JZ4780 NAND driver, this patch
is part of the series adding that. Detection of the NAND part is
handled by the MTD subsystem.

Thanks,
Alex
