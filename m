Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Oct 2017 11:23:44 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:40926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990408AbdJYJXgMsmuK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Oct 2017 11:23:36 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CB6E8607BA; Wed, 25 Oct 2017 09:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1508923412;
        bh=1xBWRij1wIKsQzEZY9hAx/PUaD+7DBqH3quoWcxJqA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3WhRn9dvZsGQ4RiXXjudZrz1lNCudch/6bLjpGdiK732CQXLg5zx9jDxSyK2mDgk
         UhdmK2Y197a1Tls3J+m9ROOjIiPEOi9v8VuBUmJqWLdhQ3r7tcj1Apmdf5P1ciDBG/
         4xneEUMuap8i3y025Tx5jAuSeN984zKOfcN+vl9U=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA9E06034D;
        Wed, 25 Oct 2017 09:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1508923412;
        bh=1xBWRij1wIKsQzEZY9hAx/PUaD+7DBqH3quoWcxJqA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3WhRn9dvZsGQ4RiXXjudZrz1lNCudch/6bLjpGdiK732CQXLg5zx9jDxSyK2mDgk
         UhdmK2Y197a1Tls3J+m9ROOjIiPEOi9v8VuBUmJqWLdhQ3r7tcj1Apmdf5P1ciDBG/
         4xneEUMuap8i3y025Tx5jAuSeN984zKOfcN+vl9U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA9E06034D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Wed, 25 Oct 2017 02:23:30 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        mturquette@baylibre.com, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@crapouillou.net,
        malat@debian.org, dom.peklo@gmail.com
Subject: Re: [RFC 2/4] clk: Add Ingenic X1000 CGU driver
Message-ID: <20171025092330.GD30645@codeaurora.org>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
 <20170927151527.25570-3-prasannatsmkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170927151527.25570-3-prasannatsmkumar@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60548
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

On 09/27, PrasannaKumar Muralidharan wrote:
> Add support for the clocks provided by CGU in Ingenic X1000 SoC.
> 
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
