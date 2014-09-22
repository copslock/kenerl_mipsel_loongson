Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2014 18:28:19 +0200 (CEST)
Received: from mail-vc0-f180.google.com ([209.85.220.180]:35195 "EHLO
        mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008930AbaIVQ2Rd2PBt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Sep 2014 18:28:17 +0200
Received: by mail-vc0-f180.google.com with SMTP id hq11so4100539vcb.25
        for <linux-mips@linux-mips.org>; Mon, 22 Sep 2014 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=eKqvqEIpyJshhMmIqmtWsIs27VRVhrO2BcZaJQ66QD8=;
        b=m31L1oP63TmIaYILZ3tXdd7AzNtBLv8A7/A2aXdvAfqMUSPz78o8r4yXoNr6UtycgA
         YM4bRQth2mv43pdbckTvgcei9DojdpGqYEhVqu6pJdbWkEsAWs0W6fwd1BjJDHRwtTSi
         UlKAPfgQi/Tl96MLsGVSihzHn+VpXK6BWJC7fFerL8b6QpRl91YmmJvSCh7cilyIUUO0
         fpDvUdTplDlcDMBuWSVDsqk88TQSA7VBGqotNcvTG4kdlqxdDqirmoPV1GOfdGTA+Q9w
         4B7B+0td2qyhhschnTMaAbVjY9XN3Z0TQB3cZ3XgJm2OC5ICHTT/GUSjx67I2ock7Heg
         014A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=eKqvqEIpyJshhMmIqmtWsIs27VRVhrO2BcZaJQ66QD8=;
        b=bShWtqr544j8Ci7TTOnuxJuyHYPCWwGfCybI9AqJUAFwRR+MMHK3qpafditkzxTpiL
         zBePnJdez+U64FR/AOFXhhYPZb8N31UKBCPRRnsD/qF9vM4QA6t6lQSMwGZCqb0l1KMd
         LCyq01c/Ue8Ekyht9Zz8CN2GjyQvgB4pqVPF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=eKqvqEIpyJshhMmIqmtWsIs27VRVhrO2BcZaJQ66QD8=;
        b=f1tyHp9zaLPfEGqW6VRMN3rTqRHnlg3h7yaPMTuyHNXSFriF5URfZxu1tD5m6HwyWd
         mHXbG2MAYo1bhUqtNfUuc49Xnh2kkRjdmu60Vf/8NzmQg1JCRBr58XfjXaamQA7cv6kl
         nk8wSq/3lOLOBt3IVM1fu2dzl3N9iS3UusvQu2hgzLJ0g3bQJ3tt9vWpvqzS4mS16vRV
         5a5YWoCn6xrwPY7lIScumelMPQ1ygHxjZwLW8RgVGp/eV0saH6vRv8wZ9ZbYZ+ZAQYri
         lRL7H9wvYzo1jMxiNRdVa/TECHAIBCVfqtff2hWT/5v/H5uNXBDEDbJdjmpjwTyyyTgT
         RItg==
X-Gm-Message-State: ALoCoQkOUsfxuE8chE3ptlU8+n4kmjvxxo9xsSROFusTToAV97glnJDFkOVhakDoAjnHkK3MQSJm
MIME-Version: 1.0
X-Received: by 10.52.178.98 with SMTP id cx2mr6365031vdc.62.1411403291332;
 Mon, 22 Sep 2014 09:28:11 -0700 (PDT)
Received: by 10.52.168.200 with HTTP; Mon, 22 Sep 2014 09:28:11 -0700 (PDT)
In-Reply-To: <CAL_JsqKGG3ei9=Od74VSL9Sm_=+vsW4U+WBgXmCEtK3iTDfJ0g@mail.gmail.com>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
        <1409938218-9026-11-git-send-email-abrestic@chromium.org>
        <CAL_JsqKGG3ei9=Od74VSL9Sm_=+vsW4U+WBgXmCEtK3iTDfJ0g@mail.gmail.com>
Date:   Mon, 22 Sep 2014 09:28:11 -0700
X-Google-Sender-Auth: OTzuV_84x7IuDp-qUMHQdqXP6Zg
Message-ID: <CAL1qeaGgBpkuGyxu_P9BNdHjncLA1pfPc-yE98UBj9Ot1koLrA@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] of: Add vendor prefix for MIPS Technologies, Inc.
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
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
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42728
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

On Mon, Sep 22, 2014 at 7:23 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Sep 5, 2014 at 12:30 PM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
>> Add the vendor prefix "mti" for MIPS Technologies, Inc.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>> New for v2.
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index ac7269f..efa5a5b 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -86,6 +86,7 @@ microchip     Microchip Technology Inc.
>>  mosaixtech     Mosaix Technologies, Inc.
>>  moxa   Moxa
>>  mpl    MPL AG
>> +mti    MIPS Technologies, Inc.
>
> Why not mips as that is more common and the stock ticker.

"mti" is already in use, see
Documentation/devicetree/bindings/mips/cpu_irq.txt,
arch/mips/mti-sead3/sead3.dts, and arch/mips/ralink/dts/*.dtsi.
