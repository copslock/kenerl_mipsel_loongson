Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 09:21:30 +0200 (CEST)
Received: from mail-qg0-f50.google.com ([209.85.192.50]:60958 "EHLO
        mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010898AbaJIHV15vkU4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 09:21:27 +0200
Received: by mail-qg0-f50.google.com with SMTP id q108so820055qgd.9
        for <multiple recipients>; Thu, 09 Oct 2014 00:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3On/fayIYaB8YJAi8qm2k86gpI/Fc5LO9nGVESrZI6g=;
        b=Y4gnqAeMIsmmSrHSBf4CdpIgakohwXq2i7DQClA6DLhBPiWJ176p/6sf4oSsC1W3xB
         Ebg6HQgYGSroEEGvnKonj6OZ/74L+1f9b6pVqCuYaXgP9zRjRvCh/hY0WgH4fULJy43R
         Psu3UgCD01SGGmJAV30mu1RlU1YEFr5cLhKxHpOzhbuEnggDL9cyQjD4jvDj7vOZ+rLz
         Gt8trY6l2pEKwdc1YegZcy5JlJQzvvcSATS5e3489x9CoAGxmBwCJDPm3zRDLKoegim+
         c0Fc1wy07L3aRXd/OpJ2SFUX23Kk3B/pABJoNr/pV17Rc6O1Oekqwxi3yydR2dELf4YY
         4PHA==
X-Received: by 10.224.37.69 with SMTP id w5mr20314829qad.67.1412839281293;
 Thu, 09 Oct 2014 00:21:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.141.78 with HTTP; Thu, 9 Oct 2014 00:21:01 -0700 (PDT)
In-Reply-To: <5435E5B0.90900@codeaurora.org>
References: <1412695334-2608-1-git-send-email-tomeu.vizoso@collabora.com> <5435E5B0.90900@codeaurora.org>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date:   Thu, 9 Oct 2014 09:21:01 +0200
X-Google-Sender-Auth: k97r5snLsIAw7JIWaYctHxpbH0Y
Message-ID: <CAAObsKBZ8irmk0fdEQUvT60ffu0oytVdJTu5s3+BXMCPaosPDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Per-user clock constraints
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Mike Turquette <mturquette@linaro.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Alex Elder <elder@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-omap@vger.kernel.org,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Matt Porter <mporter@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Tim Kryger <tim.kryger@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <tomeu.vizoso@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomeu.vizoso@collabora.com
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

On 9 October 2014 03:32, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 10/07/2014 08:21 AM, Tomeu Vizoso wrote:
>>
>> Hello,
>>
>> this second version of the series adds several cleanups that were
>> suggested by
>> Stephen Boyd and contains several improvements to the seventh patch (clk:
>> Make
>> clk API return per-user struct clk instances) that were suggested by him
>> during
>> the review of v1.
>>
>> The first six patches are just cleanups that should be desirable on their
>> own,
>> and that should make easier to review the actual per-user clock patch.
>>
>> The seventh patch actually moves the per-clock data that was stored in
>> struct
>> clk to a new struct clk_core and adds references to it from both struct
>> clk and
>> struct clk_hw. struct clk is now ready to contain information that is
>> specific
>> to a given clk consumer.
>>
>> The eighth patch adds API for setting floor and ceiling constraints and
>> stores
>> that information on the per-user struct clk, which is iterable from struct
>> clk_core.
>>
>>
>
> As said in the patches, can you please indicate which baseline this is on?

Sure, this was based on v3.17. Also available at:

http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=per-user-clk-constraints-v2

> Also can you rebase onto clk-next if you send again before that is merged
> into 3.18-rc1? There are some changes in the debugfs part that will
> conflict. I'll review the more complicated parts in detail soon.

Ack.

Thanks,

Tomeu
