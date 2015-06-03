Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 17:45:06 +0200 (CEST)
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35283 "EHLO
        mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007836AbbFCPpEPS5Gt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2015 17:45:04 +0200
Received: by qgg60 with SMTP id 60so5501179qgg.2
        for <linux-mips@linux-mips.org>; Wed, 03 Jun 2015 08:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mYH+CDRTicgKD3FuwRtzNSczzKAZThztlj1APAuf2UI=;
        b=V/NK0gz2bBSFoeegc9wc113/RfMY7ZWrDOrc/4DE2DeL3f3lJHVjsDkSuJCC9r1dGU
         VNxDOPLIIJ+kgKxn6z9fmFveHHZTnM0BHM6tX5HsxeJiRPHpuZ1eFnsm8fr+ik8f/dIk
         ci9OCzAy14r4A/Iy2KvN6wMaOkjKDRMJhuzoK841s69rSXjg55uDBo8XuS9hNEc7rr2J
         G9WH4YVWh+X33JF8TDPud/v9By4DiY4s4B0U84OXnUytSgZHDxvEuKp8ssaXA/8Z5KiR
         n5W8DRY4LYhTqcSw3B8r8TNPwVSVaimhTvRfT7dJNPBd/IcNtynAs2uOrepUTrbi9Y02
         QtJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mYH+CDRTicgKD3FuwRtzNSczzKAZThztlj1APAuf2UI=;
        b=Mb310E+sqPNStToLCjhWUqz2LTWVmgJu5AP18CQwbWhyNarRyeqf9YVCW3QyB3Bv7G
         ZEGsjRv6Hb8kWwvGIFWKxJ3iHKZoM8YHjvA7JZ8K/pRA3WegdDatIHQCp06CaCzgNKpw
         xg45K0jSzUB61KMpZv6FF82oJGlSoF2rdcS1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mYH+CDRTicgKD3FuwRtzNSczzKAZThztlj1APAuf2UI=;
        b=jh6uG9mh6BkpsWw8+Y3AC8chudhfyKWl17OPO2HjNjVdq30pklW16Orqw42sZHI6Yt
         NvdpZe6yAn+UZyJmhcHEUXz5K4OCKgNfpgoxwNgOikRVW/jhG+AKUpMMj42ZJ/sK8sya
         v2SeaOSNSMBDv3wp3XOoKSYDBoWuKIOf1HGoHlDX11UzoZbcGDYp/yv7Wy8ia3aOfgq7
         yo/iZllonNwwAF6mZSw4wLnvBkPBnfotTXGUiUT/zHCD6TiLoeDly1ohu8Pb60ZdUwi/
         nNQmOIr9LFZ585sG3MfH3O3DwPkFQWZoiwvAhZggW2nlroX1nMXnVT6aqrsd5FSD8Jk0
         +XBw==
X-Gm-Message-State: ALoCoQmUKcOyJHVVz5uVtZdTlAMvhMrTTeGOIzXi0vzOzSNyQOq9sAPNKDjxu8UkLhkkqcY1EDal
MIME-Version: 1.0
X-Received: by 10.55.41.17 with SMTP id p17mr60162824qkh.86.1433346298376;
 Wed, 03 Jun 2015 08:44:58 -0700 (PDT)
Received: by 10.140.19.17 with HTTP; Wed, 3 Jun 2015 08:44:58 -0700 (PDT)
In-Reply-To: <556E99B4.6090307@ti.com>
References: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
        <CAL1qeaE0+aMLBgk8SKgJ3fXm==M2-Z_yEPYNVZ0yxSee-p7YOw@mail.gmail.com>
        <5549083F.8080505@imgtec.com>
        <5550C06D.2010409@ti.com>
        <556E99B4.6090307@ti.com>
Date:   Wed, 3 Jun 2015 08:44:58 -0700
X-Google-Sender-Auth: OTmA451TL6nxmPr4Z7AZGwhQza4
Message-ID: <CAL1qeaFdcqUoivOkBjbGEtMovDow08_j68k+Z7mxrY==OAhAWA@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] Pistachio USB2.0 PHY
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     1428444258-25852-1-git-send-email-abrestic@chromium.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Tue, Jun 2, 2015 at 11:07 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
>
> On Monday 11 May 2015 08:15 PM, Kishon Vijay Abraham I wrote:
>>
>>
>>
>> On Tuesday 05 May 2015 11:43 PM, Ezequiel Garcia wrote:
>>>
>>> Hi Kishon,
>>>
>>>>
>>>> This series adds support for the USB2.0 PHY present on the IMG Pistachio
>>>> SoC.
>>>>
>>>> Based on mips-for-linux-next and tested on the IMG Pistachio BuB.  If
>>>> possible,
>>>> I'd like this to go through the MIPS tree with Kishon's ACK.
>>>>
>>>
>>> Tested-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>>
>>> Can we have your Ack for this series so Ralf can pick it?
>>
>>
>> sure..
>>
>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>
>
> I'm not sure if this has been merged yet. But this will cause conflicts with
> other PHY patches in Makefile and Kconfig when linus merges to his tree. I'd
> prefer the phy patches go in PHY tree itself.

It doesn't look like Ralf has picked these up, so if you want to take
them through your tree, that would be great.

Thanks,
Andrew
