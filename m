Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Feb 2015 18:26:32 +0100 (CET)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:40339 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013068AbbBRR0aiZBnX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Feb 2015 18:26:30 +0100
Received: by iebtr6 with SMTP id tr6so2977058ieb.7
        for <linux-mips@linux-mips.org>; Wed, 18 Feb 2015 09:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=9G5wQdhtHWs3j/s5aU9Bb3ADOfKJhwLFXwZutI4/xys=;
        b=ZgCbLxz0uy1S/s8BCch+dbw9Cbedsufac9HkER8Nav2Evo7lK8rOYMY+FXMobO1lIb
         1qczhpvL2tmG24svkFtrQC407Op3KJNKTSTYGgHQdfjaDPvgSo+sB38scwTFJOLmVZfG
         5qp3tkhFFurdmyXL/tXc8zYvcesEUY39uXzMn9IIm2IV74qY6I1KueZNhvAldOOG4YkF
         j+/yaBazOvALYKukhDoPKnEhNJMEEOg+D2oXcp+orALW7m0Bjb2iRVvS1PsKOr2CzC22
         G0hHzTdL9idK9VMSKH/Z/Gq9CvLHFmblx7nRERfKpsI2YwzUp5zPsMBvU/Iyknstp7eZ
         U6HQ==
X-Gm-Message-State: ALoCoQkb02GAn2O65r7B3CKruBfraXpBBoY4ByvBPtLZiU2Zi+Dq6lumgotw9PE76+GYc4+VZCOx
X-Received: by 10.107.170.8 with SMTP id t8mr505320ioe.7.1424280385222;
        Wed, 18 Feb 2015 09:26:25 -0800 (PST)
Received: from localhost (pool-71-119-96-202.lsanca.fios.verizon.net. [71.119.96.202])
        by mx.google.com with ESMTPSA id m38sm13453050ioi.39.2015.02.18.09.26.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Feb 2015 09:26:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Stephen Boyd <sboyd@codeaurora.org>,
        "Tomeu Vizoso" <tomeu.vizoso@collabora.com>,
        linux-mips@linux-mips.org
From:   Mike Turquette <mturquette@linaro.org>
In-Reply-To: <54DE28AE.8060301@codeaurora.org>
Cc:     "Javier Martinez Canillas" <javier.martinez@collabora.co.uk>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Manuel Lauss" <manuel.lauss@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1423834499-13674-1-git-send-email-tomeu.vizoso@collabora.com>
 <54DE28AE.8060301@codeaurora.org>
Message-ID: <20150218172613.421.46376@quantum>
User-Agent: alot/0.3.5
Subject: Re: [PATCH] MIPS: Alchemy: Remove bogus args from alchemy_clk_fgcs_detr
Date:   Wed, 18 Feb 2015 09:26:13 -0800
Return-Path: <mturquette@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@linaro.org
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

Quoting Stephen Boyd (2015-02-13 08:39:10)
> On 02/13/15 05:34, Tomeu Vizoso wrote:
> > They were added to this function by mistake when they were added to the
> > clk_ops.determine_rate callback.
> >
> > Fixes: 1c8e600440c7 ("clk: Add rate constraints to clocks")
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Applied to clk-next.

Regards,
Mike

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
