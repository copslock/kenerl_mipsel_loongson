Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Nov 2013 09:43:30 +0100 (CET)
Received: from mail-ie0-f179.google.com ([209.85.223.179]:41422 "EHLO
        mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822679Ab3KDIn1QoDF0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Nov 2013 09:43:27 +0100
Received: by mail-ie0-f179.google.com with SMTP id aq17so11412078iec.24
        for <linux-mips@linux-mips.org>; Mon, 04 Nov 2013 00:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z6bgJKFUz5vMh0qYu+pKrqM4o2NwbtkdSAVssJEGmiw=;
        b=WsJ7FaHe8dA1z76YXppioKpbdMkwvATT9v3tm/Rwi37yGzl1bBtJ6avbvy62ZQ/MD9
         xbKtsJK+yUd6/7ZSRZUJH8pP20xGvY70ZYKPxuKzURMejZquCP9vZmIYF2ZflapwTJXJ
         actTTTGGolNn4R090jDoEHC8U4k+OXsYwzaMAuSEyZhu1KK3M0GjyJ8A61zzrLsAKZvT
         q2iKmzWRiGwPubJAj4WeSFrbR9aFgIVmiZj4SrlCzh7WGryfbln2sfJeOuDzmvFS16q2
         6+iqwHyoqSK48D2TRY9itkMltTWAylLCDUcdIOvxLt6JtnvZ1FbO8iW4Fdme5Ruftdig
         VZHQ==
MIME-Version: 1.0
X-Received: by 10.42.250.148 with SMTP id mo20mr2776720icb.34.1383554600740;
 Mon, 04 Nov 2013 00:43:20 -0800 (PST)
Received: by 10.50.6.49 with HTTP; Mon, 4 Nov 2013 00:43:20 -0800 (PST)
In-Reply-To: <5273D9CD.2010800@gmail.com>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
        <CACmBeS2TiiTJ_n0bEzXGKN8B=U9EKXeVtrE2q0jgxsxf5TBivw@mail.gmail.com>
        <5273D9CD.2010800@gmail.com>
Date:   Mon, 4 Nov 2013 09:43:20 +0100
Message-ID: <CACmBeS3DhHnQR7Ze8oZVAC9HThmXR4n7f90yje+R=8uRq9Nvsg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] clk: clock deregistration support
From:   Jonas Jensen <jonas.jensen@gmail.com>
To:     Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mike Turquette <mturquette@linaro.org>,
        linux-mips@linux-mips.org,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        linux-sh@vger.kernel.org, jiada_wang@mentor.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        laurent.pinchart@ideasonboard.com,
        uclinux-dist-devel@blackfin.uclinux.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jonas.jensen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.jensen@gmail.com
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

On 1 November 2013 17:41, Sylwester Nawrocki
<sylvester.nawrocki@gmail.com> wrote:
> It is recommended to quote also human readable patch summary line,
> so it's more immediately clear which patch you refer to.

Sorry about that. This was tested on a clean (some added moxart
drivers but no other patches) next-20131031, reverting the following
patch:
"clkdev: Fix race condition in clock lookup from device tree" -
0b35b92fb3600a2f9ca114a6142db95f760d55f5

> Is the warning still triggered when you apply this patch:
> http://www.spinics.net/lists/arm-kernel/msg283550.html
> onto next-20131031 instead of reverting ?

After patch, the warning is no longer triggered.

Thanks,
Jonas
