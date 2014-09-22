Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2014 21:30:14 +0200 (CEST)
Received: from mail-vc0-f173.google.com ([209.85.220.173]:42077 "EHLO
        mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009370AbaIVTaMLsJne convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Sep 2014 21:30:12 +0200
Received: by mail-vc0-f173.google.com with SMTP id le20so4662127vcb.32
        for <linux-mips@linux-mips.org>; Mon, 22 Sep 2014 12:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=IOWZ1ZxrsdJkKkCSRqS594q/8lrYbKGw84u5U4yvsx8=;
        b=gdpr7gxANLCSntz+qPSCDjAu5I+85IC3EpY2vf2doAzpKvJF49eoQ9UoQPbFdUHk2m
         Wv0oLCBXMDM5wsEYXUb+q7kdsuyMaB15bSo0ExTALgs9meKcRFTU3YodbA93a/0Z5gur
         QatbBduYqqUiuroOBkdkg2PykjMKO3m1PZxcyiAuhA3NepAkO6txMDyDmGbIqKh0by0W
         dmFu8uOx1GgxPigXUb3Xtzz14K8zbRPEMxxjl+Z2byvcda2I8OYDsXM+9LzDPq/GSXFB
         zifgRFZn5g23MapF1NudI0Ci3NZGizSJT4I/hV/lg3aNRhCp/a3zL2bObtA+N3aQsPVU
         huBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=IOWZ1ZxrsdJkKkCSRqS594q/8lrYbKGw84u5U4yvsx8=;
        b=nC4qVIcR2KftuseKSjc0z7AbQvGDtzoJTc3pU2nBHsL7SaJlJRFq96f9Bc57plYfxI
         z3/Q3cO8N8bz7vWigqowtqw0tBj8j8F3nQRwGrvY6ux+nw4BLwMxoLIwkpR2lFxQbMO6
         rnADTqKXjhSLrJXELW9q64C7tJ30Zl00zzl5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IOWZ1ZxrsdJkKkCSRqS594q/8lrYbKGw84u5U4yvsx8=;
        b=PuWl5TC7t/JgCWfK3phMWEdeg0eqPHJWOGgHJsS/5B9yDy7/sgZ1Yf91P7hvy7V6jj
         zhiLXlUnmRFvZfjKJ9JbCcBRLvlXhHtoew50aszGoBz1R+W1sy0PmR5XueJnMlllCJeh
         7q3LRRXcCrzO0+2hx1I8vw4F90I9Um2Bm3FD/bNlTZhn6ll86w6thxpsNjl4ps7mHR29
         cezWMuESqN13PeMH4vV1FK+bR3JzZdqF4B9MOVoLUgWVSCxvnjT3Fu1rnGI5rPoecXSH
         NDzAUSkr305MOZqdxE3+kpcLB0nTCs2dNmgw8hYA/3Yrl2krIoJB2wmKWPwy29uehRhN
         vTUA==
X-Gm-Message-State: ALoCoQlETxJ+RUxKzGl80sANvNd0imfWFD2tZiNrL5X9LuN+rye6xVBW2S5NyYv+zDjD/OX3CHhn
MIME-Version: 1.0
X-Received: by 10.52.178.98 with SMTP id cx2mr7040834vdc.62.1411414205968;
 Mon, 22 Sep 2014 12:30:05 -0700 (PDT)
Received: by 10.52.168.200 with HTTP; Mon, 22 Sep 2014 12:30:05 -0700 (PDT)
In-Reply-To: <1E0E7540-B04F-4E89-91F7-B6FAC3C5D889@codeaurora.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
        <1409938218-9026-11-git-send-email-abrestic@chromium.org>
        <CAL_JsqKGG3ei9=Od74VSL9Sm_=+vsW4U+WBgXmCEtK3iTDfJ0g@mail.gmail.com>
        <CAL1qeaGgBpkuGyxu_P9BNdHjncLA1pfPc-yE98UBj9Ot1koLrA@mail.gmail.com>
        <1E0E7540-B04F-4E89-91F7-B6FAC3C5D889@codeaurora.org>
Date:   Mon, 22 Sep 2014 12:30:05 -0700
X-Google-Sender-Auth: aEkrczW088li41yApwfNG3EX1Qc
Message-ID: <CAL1qeaEd2L8NUugh27hkGMa1aqaxviupRJnBd2+aru1wq6KKGg@mail.gmail.com>
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
X-archive-position: 42733
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

On Mon, Sep 22, 2014 at 12:01 PM, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Sep 22, 2014, at 11:28 AM, Andrew Bresticker <abrestic@chromium.org> wrote:
>
>> On Mon, Sep 22, 2014 at 7:23 AM, Rob Herring <robherring2@gmail.com> wrote:
>>> On Fri, Sep 5, 2014 at 12:30 PM, Andrew Bresticker
>>> <abrestic@chromium.org> wrote:
>>>> Add the vendor prefix "mti" for MIPS Technologies, Inc.
>>>>
>>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>>> ---
>>>> New for v2.
>>>> ---
>>>> Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>> index ac7269f..efa5a5b 100644
>>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>> @@ -86,6 +86,7 @@ microchip     Microchip Technology Inc.
>>>> mosaixtech     Mosaix Technologies, Inc.
>>>> moxa   Moxa
>>>> mpl    MPL AG
>>>> +mti    MIPS Technologies, Inc.
>>>
>>> Why not mips as that is more common and the stock ticker.
>>
>> "mti" is already in use, see
>> Documentation/devicetree/bindings/mips/cpu_irq.txt,
>> arch/mips/mti-sead3/sead3.dts, and arch/mips/ralink/dts/*.dtsi.
>
> Isn’t mips already used as well:

Yes, however it is only used for CPUs, it does not appear in any
binding document, and no code actually matches against it.
