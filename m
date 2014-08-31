Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Aug 2014 20:32:40 +0200 (CEST)
Received: from mail-vc0-f169.google.com ([209.85.220.169]:41207 "EHLO
        mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007692AbaHaSciuY2gY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Aug 2014 20:32:38 +0200
Received: by mail-vc0-f169.google.com with SMTP id hq11so4616590vcb.14
        for <linux-mips@linux-mips.org>; Sun, 31 Aug 2014 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ey3zZRovNtQHzkYQOPgWms6nrg7di8ICUEmEYAbWhIQ=;
        b=J2A8bwcY7LkLXzFCOD3MvkpqwRN7dicIPdUKxkyONsfbNMfbCvt8sZZo7/OzPekmmG
         gJrv68ik0w/wHGRKWmkXBp5VLTnwkRPO7qCsZOlZUblp7+LiqTtYwh4WSB02FE4R3LKA
         pMGVsuinJCKgEtCizCBvFY3dCspNLguAwvR2A9C374Fi5AZoq4Mz5A2Kl4OCXfcPYP76
         WNKKSNyNKKwxIlhXLGHzPnN1g1SGb/Y20oZQtbum8D/IQdkzKvhI1VbCeBzCcmFSLg/c
         JD+ueMwNx8XPM/G7k4Q9KKVzfjAQeQVJoRNytgLtdkqWZ85LNhF5zTqlCWKHOhU0NzzB
         JVZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ey3zZRovNtQHzkYQOPgWms6nrg7di8ICUEmEYAbWhIQ=;
        b=UNZ2LobrfYmZKCb5OY3DBfvYVrEObSBUDDm6kj3a5TtB1ObRIRNQjy15otup578Ypc
         EmCUsVrxAaBDJCVjRoVVt0RddHxFYM0A0+O7/5B2cyjFuqb1AeorT++0xKejEPFQTANI
         +o2xas642cOOFq4jJfh4pRGSecnq3N2JDLL3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Ey3zZRovNtQHzkYQOPgWms6nrg7di8ICUEmEYAbWhIQ=;
        b=SfQV1MuCnrjj9lBz75RYHIZdZVaQEeNf2XWfY87TDY38jBa85F0w/kjMfLlbrGrNo9
         31axq7eVT7sCPqllDVb3LYLsXnS0k+PRj63pSQWJRX9jJNc433VfEPgl+dEUCTtzfzNP
         eiM07gQ35ajfJ3wsfIO7kYpEAqlJjsM63/dfAyq0/5xBuBkHW+Ejal3NTW9WMHbS2JN3
         FFq8jVUBqHDIOjjfGF6h9rfH+n1kWLdMFp+809FA7JXxMbA9feDB6/j8nOTqfkdN+vXZ
         i7z2WV28o6z2gERsyzuQjSR9y5BW2haWrKmuZvOQLWZOMRpe9jg4m9ZWQyi4euCFNll7
         QiOQ==
X-Gm-Message-State: ALoCoQkWOkPCMKuB25CzvdzrILS9fxWJQ1D30scnPaZDu6W46oTgkaE2qSQr8J67bWorrVtgyzN8
MIME-Version: 1.0
X-Received: by 10.220.169.72 with SMTP id x8mr3053621vcy.45.1409509952633;
 Sun, 31 Aug 2014 11:32:32 -0700 (PDT)
Received: by 10.53.5.133 with HTTP; Sun, 31 Aug 2014 11:32:32 -0700 (PDT)
In-Reply-To: <5401703B.4090801@openwrt.org>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
        <5401703B.4090801@openwrt.org>
Date:   Sun, 31 Aug 2014 11:32:32 -0700
X-Google-Sender-Auth: 8-t7nfBXHyYcZOh_On04gKMfJkQ
Message-ID: <CAL1qeaH7q1N8oPpyyhTkwDhwGjn80CcfHZt6jqgFVg9ik=KdAQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] MIPS: GIC device-tree support
From:   Andrew Bresticker <abrestic@chromium.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42349
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

On Fri, Aug 29, 2014 at 11:33 PM, John Crispin <blogic@openwrt.org> wrote:
> Hi Andrew,
>
> On 30/08/2014 00:14, Andrew Bresticker wrote:
>> Based on 3.17-rc2 and boot tested on Danube (+ out of tree patches) and
>> Malta.
>
> Lantiq makes a mips soc called danube. is this the same family or is
> this just a name collision between 2 chip vendors ?

They are unrelated.  It's just a name collision.
