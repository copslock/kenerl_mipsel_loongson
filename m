Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2014 21:43:37 +0200 (CEST)
Received: from mail-vc0-f182.google.com ([209.85.220.182]:55373 "EHLO
        mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009547AbaIVTnfLObj6 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Sep 2014 21:43:35 +0200
Received: by mail-vc0-f182.google.com with SMTP id le20so4504911vcb.41
        for <linux-mips@linux-mips.org>; Mon, 22 Sep 2014 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=xoGXbe2xNoO5JrFHMYfmcnY4ERzibBt0rvt40ryTUaI=;
        b=kQWZTI0QaRLwACgrORYY445f16Mp0S5EmQWYWx4WqeNjXxAEGhybhSoVVDe5RxvyHc
         HASkrM94rs7fRUsrZwRseRbJav4Z0CKivN1Jon9SPlZ/Xu2fsFjpHmjgwDGi2C4TVWRD
         o3SE/ukkhU1gGfbN8WlCo/JBl+k7N3w+EhmJIoUzS35nos0vHs2KodcCv4lO47wkqn1A
         Q1PD+Pz2zQkaXbyAEV0xvbanfXbx5cgxgY0yWjq5kBaIY4hdzXHIDxX8jZhIkFbHuBTx
         L6I1UUXr3ToX80Yt+/EsBu19ZXjYay58iTNdGrz4CS8qOCDmbDpo6ujgKQbnGYFLhtn5
         h9qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=xoGXbe2xNoO5JrFHMYfmcnY4ERzibBt0rvt40ryTUaI=;
        b=S/bgXwgVdtla/8nQNjSh9iqYg7mezMLpFqkWgieZJmSSdZc8bGOB82X1gLetDXatN7
         BvrGHQi6kq52w8Cf+PxUs7qm6w9oVOSZcLXtTVFuabB9dq7r4YLZMoCSw5mgD+jfA7PF
         969i3i7h1VxfZuVt1/2J4jNVm64mdL9rAM1W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xoGXbe2xNoO5JrFHMYfmcnY4ERzibBt0rvt40ryTUaI=;
        b=CH7IexowChrXDVxO5C9K2V2xUPW/Otl6sOKKndyrBLQ70NXq3rqKfNayLbOC1TnuM2
         1uiTQ1glLj9pPjlA6gNVuQJ+zCBagNaUfxPcYGZPb2FG/JPVDWmr/ESssqOkvNY2wkgg
         V1v6AO8NV8jcmg2MhsLHNAhqHaQD41X4hTcELI1Vw8PVOtDlDfumEjXR6FInrlfb9FQK
         7dRhXtO43I+yXfbH/na2pj5a3DCKp1URiYRoyR270fCv8G0DN0GhKwhbnxP3hzK0o3Ck
         cVs6TxikmpAZqoMgiVCg+lzAXYgk0mcl3RXTKX7wM1hcpuh4TrnjufPTHKjD96rBwmhR
         bovg==
X-Gm-Message-State: ALoCoQn1sL3J3CORbrBB5MEzV1YVZm5PQMPfXVRTbTgRFxLk3Xdkj+LeCFOio8bmj0z4hs0plSxY
MIME-Version: 1.0
X-Received: by 10.52.119.239 with SMTP id kx15mr2848230vdb.70.1411415008670;
 Mon, 22 Sep 2014 12:43:28 -0700 (PDT)
Received: by 10.52.168.200 with HTTP; Mon, 22 Sep 2014 12:43:28 -0700 (PDT)
In-Reply-To: <C73B2A63-4396-462B-8172-F9CA32E573F1@codeaurora.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
        <1409938218-9026-11-git-send-email-abrestic@chromium.org>
        <CAL_JsqKGG3ei9=Od74VSL9Sm_=+vsW4U+WBgXmCEtK3iTDfJ0g@mail.gmail.com>
        <CAL1qeaGgBpkuGyxu_P9BNdHjncLA1pfPc-yE98UBj9Ot1koLrA@mail.gmail.com>
        <1E0E7540-B04F-4E89-91F7-B6FAC3C5D889@codeaurora.org>
        <CAL1qeaEd2L8NUugh27hkGMa1aqaxviupRJnBd2+aru1wq6KKGg@mail.gmail.com>
        <C73B2A63-4396-462B-8172-F9CA32E573F1@codeaurora.org>
Date:   Mon, 22 Sep 2014 12:43:28 -0700
X-Google-Sender-Auth: 3k_UYAcx0YePJHwohWfETQqbU8E
Message-ID: <CAL1qeaFjxhAJK6hcbA46Gu20SrRg=cpAekByn--aWLKes9OwfQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] of: Add vendor prefix for MIPS Technologies, Inc.
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Kumar Gala <galak@codeaurora.org>
Cc:     Rob Herring <robherring2@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42735
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

On Mon, Sep 22, 2014 at 12:36 PM, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Sep 22, 2014, at 2:30 PM, Andrew Bresticker <abrestic@chromium.org> wrote:
>
>> On Mon, Sep 22, 2014 at 12:01 PM, Kumar Gala <galak@codeaurora.org> wrote:
>>>
>>> On Sep 22, 2014, at 11:28 AM, Andrew Bresticker <abrestic@chromium.org> wrote:
>>>
>>>> On Mon, Sep 22, 2014 at 7:23 AM, Rob Herring <robherring2@gmail.com> wrote:
>>>>> On Fri, Sep 5, 2014 at 12:30 PM, Andrew Bresticker
>>>>> <abrestic@chromium.org> wrote:
>>>>>> Add the vendor prefix "mti" for MIPS Technologies, Inc.
>>>>>>
>>>>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>>>>> ---
>>>>>> New for v2.
>>>>>> ---
>>>>>> Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>>>>> 1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>>>> index ac7269f..efa5a5b 100644
>>>>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>>>> @@ -86,6 +86,7 @@ microchip     Microchip Technology Inc.
>>>>>> mosaixtech     Mosaix Technologies, Inc.
>>>>>> moxa   Moxa
>>>>>> mpl    MPL AG
>>>>>> +mti    MIPS Technologies, Inc.
>>>>>
>>>>> Why not mips as that is more common and the stock ticker.
>>>>
>>>> "mti" is already in use, see
>>>> Documentation/devicetree/bindings/mips/cpu_irq.txt,
>>>> arch/mips/mti-sead3/sead3.dts, and arch/mips/ralink/dts/*.dtsi.
>>>
>>> Isn’t mips already used as well:
>>
>> Yes, however it is only used for CPUs, it does not appear in any
>> binding document, and no code actually matches against it.
>
> Do you intend to change those usages to “mti” than?

I was not originally planning on it, but I could.
