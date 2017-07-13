Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2017 19:50:32 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:43082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992262AbdGMRuYiBSeS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jul 2017 19:50:24 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 16607612BA; Thu, 13 Jul 2017 17:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1499968223;
        bh=V6rMqMvAJ+0/ZzCwfmnzN3jaNPRJJOixuOOkEYsayAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RlFWEjuICr35AMTyNU2VpySmi/y+ldF9MOGvqu9n2zT2WCtLPOUMf8kxgHprJHA9g
         bNTKJZwhxowW853qtLmgOX/M8evi8wwO6pLheP5c/N7L+YqIZ/27EvCFBm8Nd2oS8m
         Sx+Skk9Ef82piDMLP1I9FH83j2mJPF4DA5/8VR3k=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D0B66128F;
        Thu, 13 Jul 2017 17:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1499968222;
        bh=V6rMqMvAJ+0/ZzCwfmnzN3jaNPRJJOixuOOkEYsayAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDt5rNQTdDYMGuUNnP66ByRjfHrYULFc8TqWWLruxFRz69zLzGM5JH+G7zH6dkH1W
         f81yTk614FIJMVr3jgdzrnntAbdcBuftZhxIUG2eLkWcdO+3szWUGqZqIm6/5jAltg
         fo8ZR5dTdDo9VqZVaNbTmwn8uVzcRJqhvCFYhCVo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D0B66128F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Thu, 13 Jul 2017 10:50:21 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 01/18] clk: ingenic: Use const pointer to clk_ops in
 struct
Message-ID: <20170713175021.GA22780@codeaurora.org>
References: <20170607200439.24450-2-paul@crapouillou.net>
 <20170702163016.6714-1-paul@crapouillou.net>
 <20170702163016.6714-2-paul@crapouillou.net>
 <20170712232037.GR22780@codeaurora.org>
 <ca4da3fa3067a7301f8fc1539e9e4362@crapouillou.net>
 <20170713114916.GA17495@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170713114916.GA17495@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

On 07/13, Ralf Baechle wrote:
> On Thu, Jul 13, 2017 at 12:07:25PM +0200, Paul Cercueil wrote:
> 
> > > Sorry I forgot, did you want an ack for these clk patches or for
> > > me to take them through clk tree. If it's the ack case,
> > > 
> > > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > > 
> > > for patches 1 through 6.
> > 
> > I think ACK; then Ralf can take them in 4.13 :)
> 
> My pull request for 4.13 is already finalized so it'd be great if this
> could make it to 4.13 through the clk tree.  If that should be impossible
> I'd like to merge this via the MIPS tree for 4.14.
> 

It's too late for v4.13, so you can take it for v4.14.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
