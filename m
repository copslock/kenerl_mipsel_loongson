Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 09:31:30 +0200 (CEST)
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34931 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990514AbcIAHbXFlLxI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 09:31:23 +0200
Received: by mail-pf0-f169.google.com with SMTP id x72so28524769pfd.2
        for <linux-mips@linux-mips.org>; Thu, 01 Sep 2016 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1/u7srTLluux/1N2fkj9UPymhYw4j3dj/tukKwmFx8A=;
        b=JsrZtOwTiArsWs7pEJnvOU0nSrR+LKnVG0WnbOz5K3QfmnX1xeoSSq/QVbdb+RoWCO
         Xc///WVyGgi5Pkh6Nak+F0aSIrCxUrxBzM3GhhXco6q8FBTp7TuGSBzdNfMsZCZC9lup
         2Ym86/FYiVCPFrP93ienYyPHdVxFBneoS57TxNmf7fT+tclLT5KmFaMWbKRUq86vogbV
         Sqpgobm8oP5X6sonoet5NCUwdoXseSSFk7HqwIb9sxmHPIXJCBC+jEqmfSydDWqc6pw0
         XJ6Dd4VXbAtA10E674DqhyNG4zD6W2syrjh//1EW4q9tjkDGvyyJ80srNdAoH2+rNI31
         w8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1/u7srTLluux/1N2fkj9UPymhYw4j3dj/tukKwmFx8A=;
        b=e/Nb3wVIF/xgZgtlmADMVPeTgzxzJSX3D7hHtg2G8pih+snRXMXGV+CtewBzij37Rs
         /lkxSxqBMUQkQ5eKVT7QSOKkAZPljX1nyV7hbHDh/xRcTEsII7eKHXGLjSu8+WblexLp
         CzZHu3Zsejc+Z6UTr0buUQeaX4yPK/BNa/ria/79WE68/FJPiDFyuuSIUXKg1DLfOZsR
         aF20QJDI6MZy9Y0/5PyVI9lKikZzztOiLvRwGf/5f7NEX31js32ule34Y8OXd5inJZO2
         Ma99EMfnxTb2yBAYK07ssdoEW8rdPUcASTdv8M5xrk+/aDRW3IHtzv2igQ2rWakSjBhg
         LuiA==
X-Gm-Message-State: AE9vXwNSv4p4Q+9beWmWfIXviXSwxW2ReklIfv/3EiyJq36M1+NPTsUn3HedVjEMF/VVRg==
X-Received: by 10.98.64.93 with SMTP id n90mr24399009pfa.29.1472715077224;
        Thu, 01 Sep 2016 00:31:17 -0700 (PDT)
Received: from ly-pc (ec2-52-77-214-225.ap-southeast-1.compute.amazonaws.com. [52.77.214.225])
        by smtp.gmail.com with ESMTPSA id i62sm4751021pfg.62.2016.09.01.00.31.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Sep 2016 00:31:16 -0700 (PDT)
From:   Yang Ling <gnaygnil@gmail.com>
X-Google-Original-From: Yang Ling <gnaygnail@gmail.com>
Date:   Thu, 1 Sep 2016 15:31:03 +0800
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Yang Ling <gnaygnil@gmail.com>, keguang.zhang@gmail.com,
        mturquette@baylibre.com, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] CLK: Add Loongson1C clock support
Message-ID: <20160901073100.GA11754@ly-pc>
References: <20160822045034.GA6545@ly-pc>
 <20160831225113.GL12510@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160831225113.GL12510@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

On Wed, Aug 31, 2016 at 03:51:13PM -0700, Stephen Boyd wrote:
> On 08/22, Yang Ling wrote:
> > This patch adds clock support to Loongson1C SoC.
> > 
> > Signed-off-by: Yang Ling <gnaygnil@gmail.com>
> > 
> 
> It would be better to use the new clk_hw_*() and clkdev_hw_*()
> registration APIs. Care to make that change? Obviously
> clk_register_pll() isn't going to work there, but we can fix that
> later.
> 

Well, I will use the new APIs to debug the code.
Thanks for your friendly reminder.
