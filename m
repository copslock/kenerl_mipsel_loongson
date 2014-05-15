Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2014 16:51:19 +0200 (CEST)
Received: from mail-ig0-f172.google.com ([209.85.213.172]:61667 "EHLO
        mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816615AbaEOOvPJKTYz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 May 2014 16:51:15 +0200
Received: by mail-ig0-f172.google.com with SMTP id uy17so8011536igb.5
        for <linux-mips@linux-mips.org>; Thu, 15 May 2014 07:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-type;
        bh=a31MNXsOV8WibLcR7q1xcDBkdSVlbINu0ADk64VxeUo=;
        b=jq0VnRtULXJRk/0cdXkC7PxnhXwQK9Y+qMskevxvc0boj/2sMW1xgFmkBJECvZuG6d
         bQVOboRgQh9iL9227+c2m1DFAsMDqICXq16Gt+uvxtwrN8M0LTEorIRwvMyfYGL26K0e
         BIixMa6jMyfvf3N18kqCbPLkSod2HBS7UqD/FLLwmVN36M31ud58Esz+ME7g+hNPLrIn
         2Yp35KBDiAdQbJBUVvpT6yXvrLo6boaO4wSXoTviJwNTDnpn7Q/xsywFAAJPY46WzMN4
         0gcYuetVknJWq5jx4wFVgwaKF5BeNmDXHcuZhrYJ3uEYiRH3Mzf99OXO1SSPeclcBlRn
         cGsw==
X-Gm-Message-State: ALoCoQm8yTXIhvYRCy5di09eJStVeMhrhl65qyXZL5jrB3vqqEyjR14MF/8WiQyE7X1d8pSYQ9i8
X-Received: by 10.50.130.37 with SMTP id ob5mr10880224igb.46.1400165468780;
 Thu, 15 May 2014 07:51:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.211.198 with HTTP; Thu, 15 May 2014 07:50:48 -0700 (PDT)
In-Reply-To: <20140422131309.9E6E1C40754@trevor.secretlab.ca>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
 <1397756521-29387-3-git-send-email-leif.lindholm@linaro.org> <20140422131309.9E6E1C40754@trevor.secretlab.ca>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Thu, 15 May 2014 15:50:48 +0100
X-Google-Sender-Auth: dezU_rShc-vQyp0IQrY7aaIoESU
Message-ID: <CACxGe6suKO5n0fg8dHGSwi0Esjbu6dyYdJPLH0AScKsDCABKbg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mips: dts: add device_type="memory" where missing
To:     Leif Lindholm <leif.lindholm@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "patches@linaro.org" <patches@linaro.org>,
        linux-mips <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        John Crispin <blogic@openwrt.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
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

On Tue, Apr 22, 2014 at 2:13 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, 17 Apr 2014 18:42:00 +0100, Leif Lindholm <leif.lindholm@linaro.org> wrote:
>> A few platforms lack a 'device_type = "memory"' for their memory
>> nodes, relying on an old ppc quirk in order to discover its memory.
>> Add this, to permit that quirk to be made ppc only.
>>
>> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
>> Cc: linux-mips@linux-mips.org
>> Cc: devicetree@vger.kernel.org
>> Cc: John Crispin <blogic@openwrt.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>
> Acked-by: Grant Likely <grant.likely@linaro.org>

Applied, thanks.

g.

>
>> ---
>>  arch/mips/lantiq/dts/easy50712.dts    |    1 +
>>  arch/mips/ralink/dts/mt7620a_eval.dts |    1 +
>>  arch/mips/ralink/dts/rt2880_eval.dts  |    1 +
>>  arch/mips/ralink/dts/rt3052_eval.dts  |    1 +
>>  arch/mips/ralink/dts/rt3883_eval.dts  |    1 +
>>  5 files changed, 5 insertions(+)
>>
>> diff --git a/arch/mips/lantiq/dts/easy50712.dts b/arch/mips/lantiq/dts/easy50712.dts
>> index fac1f5b..143b8a3 100644
>> --- a/arch/mips/lantiq/dts/easy50712.dts
>> +++ b/arch/mips/lantiq/dts/easy50712.dts
>> @@ -8,6 +8,7 @@
>>       };
>>
>>       memory@0 {
>> +             device_type = "memory";
>>               reg = <0x0 0x2000000>;
>>       };
>>
>> diff --git a/arch/mips/ralink/dts/mt7620a_eval.dts b/arch/mips/ralink/dts/mt7620a_eval.dts
>> index 35eb874..709f581 100644
>> --- a/arch/mips/ralink/dts/mt7620a_eval.dts
>> +++ b/arch/mips/ralink/dts/mt7620a_eval.dts
>> @@ -7,6 +7,7 @@
>>       model = "Ralink MT7620A evaluation board";
>>
>>       memory@0 {
>> +             device_type = "memory";
>>               reg = <0x0 0x2000000>;
>>       };
>>
>> diff --git a/arch/mips/ralink/dts/rt2880_eval.dts b/arch/mips/ralink/dts/rt2880_eval.dts
>> index 322d700..0a685db 100644
>> --- a/arch/mips/ralink/dts/rt2880_eval.dts
>> +++ b/arch/mips/ralink/dts/rt2880_eval.dts
>> @@ -7,6 +7,7 @@
>>       model = "Ralink RT2880 evaluation board";
>>
>>       memory@0 {
>> +             device_type = "memory";
>>               reg = <0x8000000 0x2000000>;
>>       };
>>
>> diff --git a/arch/mips/ralink/dts/rt3052_eval.dts b/arch/mips/ralink/dts/rt3052_eval.dts
>> index 0ac73ea..ec9e9a0 100644
>> --- a/arch/mips/ralink/dts/rt3052_eval.dts
>> +++ b/arch/mips/ralink/dts/rt3052_eval.dts
>> @@ -7,6 +7,7 @@
>>       model = "Ralink RT3052 evaluation board";
>>
>>       memory@0 {
>> +             device_type = "memory";
>>               reg = <0x0 0x2000000>;
>>       };
>>
>> diff --git a/arch/mips/ralink/dts/rt3883_eval.dts b/arch/mips/ralink/dts/rt3883_eval.dts
>> index 2fa6b33..e8df21a 100644
>> --- a/arch/mips/ralink/dts/rt3883_eval.dts
>> +++ b/arch/mips/ralink/dts/rt3883_eval.dts
>> @@ -7,6 +7,7 @@
>>       model = "Ralink RT3883 evaluation board";
>>
>>       memory@0 {
>> +             device_type = "memory";
>>               reg = <0x0 0x2000000>;
>>       };
>>
>> --
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
