Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 22:51:27 +0200 (CEST)
Received: from mail-ea0-f179.google.com ([209.85.215.179]:40524 "EHLO
        mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819473Ab3IYUvZf7gdp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Sep 2013 22:51:25 +0200
Received: by mail-ea0-f179.google.com with SMTP id b10so97242eae.24
        for <linux-mips@linux-mips.org>; Wed, 25 Sep 2013 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FaqBSbH6YjwRD3ndDCIIT2RMUktFgScfNb0N3LqtUMw=;
        b=FI9mlNaSEzPR3daDVKjLsTDUkELmwx52xSataAwBjJ/kLtRkFiQ5/bDRxCbwpJFptH
         wBRhCu21DLBKwfDHITcZQip2JXTIF54gz7jJmxyhq+z2dDPJxgGPNuioVOR0ExdJkl4W
         /hFL6IFDxpxOyfHAGJoX0dYPy2PKSFCS46zXot8Vxxx9SCjWym5zsbmUzLDEzq5a3mB0
         G5UDeWhFLXEJSqb0mHZeMUWvlBDfllZD8Zfy+MIqfSRz5FWuth2/s9ljWo52HZ/CzAmz
         KGrFh2kfr2Zq/esgZR9Geu+7hjUfnnLuAvmpi8E50TRrNlzXP5jKVLGhI1R89Z3YFaaF
         NbYA==
X-Received: by 10.15.102.71 with SMTP id bq47mr5920628eeb.66.1380142280265;
        Wed, 25 Sep 2013 13:51:20 -0700 (PDT)
Received: from [192.168.1.110] (093105185086.warszawa.vectranet.pl. [93.105.185.86])
        by mx.google.com with ESMTPSA id x47sm69676712eea.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 13:51:19 -0700 (PDT)
Message-ID: <52434CBC.2070408@gmail.com>
Date:   Wed, 25 Sep 2013 22:51:08 +0200
From:   Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120412 Thunderbird/11.0.1
MIME-Version: 1.0
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     linux@arm.linux.org.uk, mturquette@linaro.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH v6 0/5] clk: clock deregistration support
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com> <52420664.2040604@gmail.com> <3160771.O1gFkR91vK@avalon>
In-Reply-To: <3160771.O1gFkR91vK@avalon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sylvester.nawrocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37977
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

Hi Laurent,

On 09/25/2013 11:47 AM, Laurent Pinchart wrote:
> Doesn't that introduce race conditions ? If the sub-drivers require the clock,
> they want to be sure that the clock won't disappear beyond their backs. I
> agree that the circular dependency needs to be solved somehow, but we probably
> need a more generic solution. The problem will become more widespread in the
> future with DT-based device instantiation in both V4L2 and KMS.

It doesn't introduce any new race conditions AFAICT. I doubt all these 
issues
can be resolved in one single step. Currently the modular clock 
providers are
seriously broken, there is no reference tracking and the clock consumers 
can
easily get into a state where they have invalid references to clocks 
supplied
by already unregistered drivers.

With this patch series the clock consumer drivers will not crash thanks 
to the
clock object reference counting. So the worst thing may happen is a 
clock left
in an unexpected state.

However there should be no problems with the v4l2-async API, the host driver
in its de-initialization routine unregisters its sub-drivers (they 
should stop
using the clock when notified of such an event), only then the host would
unregister the clock (subsequently the sub-drivers get re-attached and put
into deferred probing state).

There may be issues when a sub-driver's file handle is opened while the host
is about to de-initialize. But I doubt resolution of such problems belongs
to the common clock framework. I have been trying to improve the situation
in small steps, rather than waiting forever for a perfect solution.

Do you perhaps have any ideas WRT to a "more generic solution" ? In general
I have been trying to avoid using v4l2-clk and add what's missing in the
common clock framework.

Perhaps we should leave only the kref part in the __clk_get(), __clk_put()
hooks and be taking reference to a clock in clk_prepare() and releasing it
in clk_unprepare() ? This way circular reference would exist only between
clk_prepare(), clk_unprepare() calls.

Assuming a driver prepares clock in device's open() and unprepares in device
close() handler perhaps it could all work better, without relying on the 
host
to ensure the resource reference tracking. I'm not sure if that is not 
making
too many assumptions for a generic API.


Thanks for the feedback.

--
Regards,
Sylwester
