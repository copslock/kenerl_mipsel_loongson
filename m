Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 17:37:21 +0100 (CET)
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41485 "EHLO
        mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008516AbbCKQhRtgfOt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 17:37:17 +0100
Received: by wiwl15 with SMTP id l15so13359178wiw.0;
        Wed, 11 Mar 2015 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:openpgp:content-type
         :content-transfer-encoding;
        bh=zWitclcKokLZbEezxVJRO99CIONVZhwaRoOPCSQwAEE=;
        b=si++ncEfcoSJkW4fMbqqUVtOZxjSgzhw9qk4UibjzB20bE7Rfa1cO8M5GoMi3fuHsW
         WWIT54WrhzG+fbV1GnzCxhY6G1XaXLamocrgtZZLkma1EqDpFoFdaxFXO4VpS/ZjYDCS
         L76Iqm3e+NhFP0OmzynxqnIHTACUAaAG5tRLGWBBNNJDVFL+CE3vWKBTofmw4pUJSF1x
         ZRayka+NmfvZjyqzGPWkI74QT08LN6puv2W0c1PFiB+d0Iq5CKaSm2Ih8HykEWOm5dg7
         0PuOW+SSp3DXmK0q9SmaeuC3VTzPiH/KF17+mrsnru3cmrUTK4afMTTDz8KOJKfBCLld
         tV3w==
X-Received: by 10.180.184.136 with SMTP id eu8mr68753166wic.45.1426091833204;
        Wed, 11 Mar 2015 09:37:13 -0700 (PDT)
Received: from [192.168.10.30] (p579C4408.dip0.t-ipconnect.de. [87.156.68.8])
        by mx.google.com with ESMTPSA id hl15sm18486952wib.3.2015.03.11.09.37.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2015 09:37:12 -0700 (PDT)
Message-ID: <55006F36.2040505@gmail.com>
Date:   Wed, 11 Mar 2015 17:37:10 +0100
From:   Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Jonas Gorski <jogo@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [U-Boot] MIPS UHI spec
References: <6D39441BF12EF246A7ABCE6654B0235320FDC2AC@LEMAIL01.le.imgtec.org>   <20150226101739.GY17695@NP-P-BURTON>    <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com> <CAL1qeaFPQvaS6OaaSdcQc-yGevwnH6OXSUK4b0QSoW2iAAForg@mail.gmail.com>
In-Reply-To: <CAL1qeaFPQvaS6OaaSdcQc-yGevwnH6OXSUK4b0QSoW2iAAForg@mail.gmail.com>
OpenPGP: id=DD0EEB33
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.schwierzeck@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.schwierzeck@gmail.com
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



Am 09.03.2015 um 18:04 schrieb Andrew Bresticker:
> Hi Daniel,
> 
> On Thu, Feb 26, 2015 at 4:37 AM, Daniel Schwierzeck
> <daniel.schwierzeck@gmail.com> wrote:
>> 2015-02-26 11:17 GMT+01:00 Paul Burton <paul.burton@imgtec.com>:
>>> On Thu, Feb 19, 2015 at 01:50:23PM +0000, Matthew Fortune wrote:
>>>> Hi Daniel,
>>>>
>>>> The spec for MIPS Unified Hosting Interface is available here:
>>>>
>>>> http://prplfoundation.org/wiki/MIPS_documentation
>>>>
>>>> As we have previously discussed, this is an ideal place to
>>>> define the handover of device tree data from bootloader to
>>>> kernel. Using a0 == -2 and defining which register(s) you
>>>> need for the actual data will fit nicely. I'll happily
>>>> include whatever is decided into the next version of the spec.
>>
>> this originates from an off-list discussion some months ago started by
>> John Crispin.
>>
>> (CC +John, Ralf, Jonas, linux-mips)
>>
>>>
>>> (CC +Andrew, Ezequiel, James, James)
>>>
>>> On the talk of DT handover, this recent patchset adding support for a
>>> system doing so to Linux is relevant:
>>>
>>>     http://www.linux-mips.org/archives/linux-mips/2015-02/msg00312.html
>>>
>>> I'm also working on a system for which I'll need to implement DT
>>> handover very soon. It would be very nice if we could agree on some
>>> standard way of doing so (and eventually if the code on the Linux side
>>> can be generic enough to allow a multiplatform kernel).
>>>
>>
>> to be conformant with UHI I propose $a0 == -2 and $a1 == address of DT
>> blob. It is a simple extension and should not interfere with the
>> various legacy boot interfaces.
> 
> Just to be clear, is $a1 expected to be the physical or virtual
> (KSEG0) address of the DTB?
> 

U-Boot currently uses KSEG0 addresses for kernel entry and initramfs.
Therefore the DTB address would be also KSEG0. But I'm not sure if it is
correct for MIPS64. Shouldn't the kernel sanitize the DTB address anyway
like it's done with initramfs? Maybe Matthew or others could comment.

-- 
- Daniel
