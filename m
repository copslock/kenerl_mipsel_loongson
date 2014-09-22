Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2014 21:37:03 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.11.231]:47515 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009533AbaIVTg7NALh6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Sep 2014 21:36:59 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 278C5140604;
        Mon, 22 Sep 2014 19:36:52 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 01D4E140600; Mon, 22 Sep 2014 19:36:51 +0000 (UTC)
Received: from galak-mac.qualcomm.com (rrcs-67-52-129-61.west.biz.rr.com [67.52.129.61])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: galak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 08BEC140600;
        Mon, 22 Sep 2014 19:36:46 +0000 (UTC)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2 10/16] of: Add vendor prefix for MIPS Technologies, Inc.
From:   Kumar Gala <galak@codeaurora.org>
In-Reply-To: <CAL1qeaEd2L8NUugh27hkGMa1aqaxviupRJnBd2+aru1wq6KKGg@mail.gmail.com>
Date:   Mon, 22 Sep 2014 14:36:44 -0500
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
Content-Transfer-Encoding: 8BIT
Message-Id: <C73B2A63-4396-462B-8172-F9CA32E573F1@codeaurora.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org> <1409938218-9026-11-git-send-email-abrestic@chromium.org> <CAL_JsqKGG3ei9=Od74VSL9Sm_=+vsW4U+WBgXmCEtK3iTDfJ0g@mail.gmail.com> <CAL1qeaGgBpkuGyxu_P9BNdHjncLA1pfPc-yE98UBj9Ot1koLrA@mail.gmail.com> <1E0E7540-B04F-4E89-91F7-B6FAC3C5D889@codeaurora.org> <CAL1qeaEd2L8NUugh27hkGMa1aqaxviupRJnBd2+aru1wq6KKGg@mail.gmail.com>
To:     Andrew Bresticker <abrestic@chromium.org>
X-Mailer: Apple Mail (2.1878.6)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <galak@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: galak@codeaurora.org
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


On Sep 22, 2014, at 2:30 PM, Andrew Bresticker <abrestic@chromium.org> wrote:

> On Mon, Sep 22, 2014 at 12:01 PM, Kumar Gala <galak@codeaurora.org> wrote:
>> 
>> On Sep 22, 2014, at 11:28 AM, Andrew Bresticker <abrestic@chromium.org> wrote:
>> 
>>> On Mon, Sep 22, 2014 at 7:23 AM, Rob Herring <robherring2@gmail.com> wrote:
>>>> On Fri, Sep 5, 2014 at 12:30 PM, Andrew Bresticker
>>>> <abrestic@chromium.org> wrote:
>>>>> Add the vendor prefix "mti" for MIPS Technologies, Inc.
>>>>> 
>>>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>>>> ---
>>>>> New for v2.
>>>>> ---
>>>>> Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>>>> 1 file changed, 1 insertion(+)
>>>>> 
>>>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>>> index ac7269f..efa5a5b 100644
>>>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>>> @@ -86,6 +86,7 @@ microchip     Microchip Technology Inc.
>>>>> mosaixtech     Mosaix Technologies, Inc.
>>>>> moxa   Moxa
>>>>> mpl    MPL AG
>>>>> +mti    MIPS Technologies, Inc.
>>>> 
>>>> Why not mips as that is more common and the stock ticker.
>>> 
>>> "mti" is already in use, see
>>> Documentation/devicetree/bindings/mips/cpu_irq.txt,
>>> arch/mips/mti-sead3/sead3.dts, and arch/mips/ralink/dts/*.dtsi.
>> 
>> Isn’t mips already used as well:
> 
> Yes, however it is only used for CPUs, it does not appear in any
> binding document, and no code actually matches against it.

Do you intend to change those usages to “mti” than?

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
