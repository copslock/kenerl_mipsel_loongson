Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 22:26:38 +0100 (CET)
Received: from mail-vc0-f182.google.com ([209.85.220.182]:57345 "EHLO
        mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013876AbaKQV0gKlZRy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 22:26:36 +0100
Received: by mail-vc0-f182.google.com with SMTP id im17so7793488vcb.13
        for <linux-mips@linux-mips.org>; Mon, 17 Nov 2014 13:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=diU8P5SHkHvCv8G3nBqTp0FmrgNmdtkDM4NZ7gWI/jo=;
        b=ckH0wYayej67/sPJYrF9VLo+PkfAxVqJQTUvfnADK/eDXcuDHYwb17ceHnvJES40WT
         bMpZh2K+EmiVrr4Wfz++g12CAxRYCUMGvFsWIjQWVtlQkDcOUTsvPio8J3ya9V5U7KTZ
         zyeW0tc1pNVO5gQjl7sH2GVRoUGSomNJ9Rm0MNB2EcgxMqUum22Xzi/osxafn4zzxLLn
         oeYz1MKRQjbdoC0B+0kxeJ4dpEp1GzRTsYQHJNb79fvMT+OSpQZ/cSwPpp7vb5EXCD8G
         IbQH+szUnpdv2zBRtiTaIdgmdQzknFdk21fpIGEurKQ8qRZmpixLKPLjkZdLtJAaWYlP
         AdmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=diU8P5SHkHvCv8G3nBqTp0FmrgNmdtkDM4NZ7gWI/jo=;
        b=nAYsCGpgBonpGUlnbQGyZTALBO6leLCBv65mI5qrPvnCe9GXMgZNBbRi6XjuhmBzg9
         3IeSexwPR5Cdqmoehfmg/c47JIRqjpeVXPGbB+EWevY5du1X10YEv+xElW0e6dW028UL
         pg7I+e27FCYSOFjOBkGDx9I3WZId23HGa0duU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=diU8P5SHkHvCv8G3nBqTp0FmrgNmdtkDM4NZ7gWI/jo=;
        b=P0P7qCOzxuZegnz/xBSNADIn6P+JrV4Vgn0aOv9kH5cTU/0tZY1318rqOL5SCFfiMA
         +Ilf1/eZ+l7p9CftBSh191aEcqbpoeZ+7bQgNqEiczt6CIEgKm7qHNUyh30XKUzZDhkF
         sny6buSlYJxIxB4l1w97kLgjKIKBmyThLpr6dUXjuBn3KeCOlR3l4fBiGIL0ywp2K+u4
         uZBmKQWaTHhcIVc1d3Xh5kJN2OFoP0Bh+q49dbxiKasyYuGeQaP707GdB0PKYftwJVjE
         Jtw2ot+14XdKdI/xd49Q9ubt7maqk38ErUPRwLwGfcIHUyZbb9/aiGdcWmxDLHAkhjN+
         BK9g==
X-Gm-Message-State: ALoCoQnqh2XAXDYtQtuX0YmG5dXgjmi4IFX9azgVAItqKLMirc0oMy98XMkTL2j88uJSQZB0hLnr
MIME-Version: 1.0
X-Received: by 10.52.74.65 with SMTP id r1mr14158750vdv.62.1416259590183; Mon,
 17 Nov 2014 13:26:30 -0800 (PST)
Received: by 10.52.168.200 with HTTP; Mon, 17 Nov 2014 13:26:30 -0800 (PST)
In-Reply-To: <546A66EA.3090107@linaro.org>
References: <1415821419-26974-1-git-send-email-abrestic@chromium.org>
        <1415821419-26974-5-git-send-email-abrestic@chromium.org>
        <546A66EA.3090107@linaro.org>
Date:   Mon, 17 Nov 2014 13:26:30 -0800
X-Google-Sender-Auth: Ua4fJoY3AKbKi06PJrGCvOTSEqc
Message-ID: <CAL1qeaHpK0a+ONK3bhVrRk-G7iwRw_HwpjtLwi6E6EJ+rccbww@mail.gmail.com>
Subject: Re: [PATCH V5 4/4] clocksource: mips-gic: Add device-tree support
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44251
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

On Mon, Nov 17, 2014 at 1:21 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 11/12/2014 08:43 PM, Andrew Bresticker wrote:
>>
>> Parse the GIC timer frequency and interrupt from the device-tree.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
>
> Hi Andrew,
>
> through which tree is this patch supposed to go ?
>
> Is there any dependency ?

There are quite a few dependencies, so this series and all the other
MIPS GIC stuff is going through the MIPS tree.
