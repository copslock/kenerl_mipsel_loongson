Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Aug 2013 01:01:08 +0200 (CEST)
Received: from mail-bk0-f47.google.com ([209.85.214.47]:61674 "EHLO
        mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822345Ab3HWXBGQxfQZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Aug 2013 01:01:06 +0200
Received: by mail-bk0-f47.google.com with SMTP id mx12so437730bkb.6
        for <multiple recipients>; Fri, 23 Aug 2013 16:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6dLE+8S4cohL+yB4BrFuQfjhYrT02HvkR9t66DVsRWk=;
        b=ryXdN5mf09wA90vSHsWXf1snzoGiKYLVp7kYzP4TW8+t1I+v2Q1+i65vucQBGttcfy
         vJsh/YDclcOR/P6AbVpciNu7m5GgtATiFmNL66CgIcXlLre7gy81pTIiE+4AxZ8gTPVu
         LTGcQNhuKf+j5YULXrAjyVPFMTFSYH6Q3RswBRt/SAgxt0+vjZ8guY9HXhw/pM9H8LyE
         4QP09I9lK1yvogDzt/jGjxTpm+PGXpT3R3iyaD5LgYUZKgrA53Dq7n8PTAZene66xqkB
         du+ZFek0YqZh6QrnqaqGside4vyTbQoNkLwl+6z3hvRdX+MyIH95cah5knFhM6LuQPBB
         BppA==
X-Received: by 10.204.162.10 with SMTP id t10mr1163597bkx.26.1377298860578;
        Fri, 23 Aug 2013 16:01:00 -0700 (PDT)
Received: from [192.168.1.110] (093105185086.warszawa.vectranet.pl. [93.105.185.86])
        by mx.google.com with ESMTPSA id pk7sm453323bkb.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 16:00:59 -0700 (PDT)
Message-ID: <5217E9A5.8030503@gmail.com>
Date:   Sat, 24 Aug 2013 01:00:53 +0200
From:   Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120412 Thunderbird/11.0.1
MIME-Version: 1.0
To:     Mike Turquette <mturquette@linaro.org>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk,
        jiada_wang@mentor.com, robherring2@gmail.com,
        grant.likely@linaro.org, broonie@kernel.org, vapier@gentoo.org,
        ralf@linux-mips.org, kyungmin.park@samsung.com,
        shawn.guo@linaro.org, sebastian.hesselbarth@gmail.com,
        LW@KARO-electronics.de, t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 2/4] clk: implement clk_unregister
References: <1377020063-30213-1-git-send-email-s.nawrocki@samsung.com> <1377020063-30213-3-git-send-email-s.nawrocki@samsung.com> <20130823215838.8231.21635@quantum>
In-Reply-To: <20130823215838.8231.21635@quantum>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sylvester.nawrocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sylvester.nawrocki@gmail.com
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

On 08/23/2013 11:58 PM, Mike Turquette wrote:
>> +static void clk_nodrv_disable_unprepare(struct clk_hw *hw)
>> >  +{
>> >  +       WARN_ON(1);
>
> Ideally we shouldn't get here, but if we do I guess it could be very
> noisy. How about WARN_ONCE?

Yes, I guess that would be much better. I could resend it tomorrow if 
needed.

> After you address Russell's comments in patch #1 I will be happy to take
> this series.

I have posted today v3 addressing Russell's comments. Hopefully patch #3
(the patches got reordered) looks OK now. v3 includes actual assigning
of clk->owner I somehow managed to miss in previous series :/ Please have
a look at it.

--
Regards,
Sylwester
