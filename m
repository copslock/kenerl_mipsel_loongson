Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 00:49:56 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:32994 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993961AbdFZWttcTFEt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2017 00:49:49 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E7F7460AD0; Mon, 26 Jun 2017 22:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1498517387;
        bh=bQwoKhPJyexbUVxvaR4ZKkRPZsem/NkqGSp9/4DqL8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oy9j3Nsy7L30ELwoRNGSC8hTrzYaj6AqfvL3/xNRn/GHib8oZ9T786/yXLNZBnW3u
         yVLB124xz9t21CbClaicAuTdwuy/prS/icOKUCsGnA0icFdcaL72SGhBMdl/RwQVxT
         UaQsnmMwVMtQ6HN4JSNE2KZS3+TGwYdFjavitUoU=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19C1A60724;
        Mon, 26 Jun 2017 22:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1498517387;
        bh=bQwoKhPJyexbUVxvaR4ZKkRPZsem/NkqGSp9/4DqL8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oy9j3Nsy7L30ELwoRNGSC8hTrzYaj6AqfvL3/xNRn/GHib8oZ9T786/yXLNZBnW3u
         yVLB124xz9t21CbClaicAuTdwuy/prS/icOKUCsGnA0icFdcaL72SGhBMdl/RwQVxT
         UaQsnmMwVMtQ6HN4JSNE2KZS3+TGwYdFjavitUoU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19C1A60724
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Mon, 26 Jun 2017 15:49:46 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 04/15] clk: Add Ingenic jz4770 CGU driver
Message-ID: <20170626224946.GR4493@codeaurora.org>
References: <20170607200439.24450-1-paul@crapouillou.net>
 <20170607200439.24450-5-paul@crapouillou.net>
 <20170607205943.GO20170@codeaurora.org>
 <639b492cc57200bab14572ac591ef8af@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <639b492cc57200bab14572ac591ef8af@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58822
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

On 06/26, Paul Cercueil wrote:
> Hi,
> 
> Le 2017-06-07 22:59, Stephen Boyd a écrit :
> >On 06/07, Paul Cercueil wrote:
> >>Add support for the clocks provided by the CGU in the Ingenic JZ4770
> >>SoC.
> >>
> >>Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> 
> [...]
> 
> >>diff --git a/include/dt-bindings/clock/jz4770-cgu.h
> >>b/include/dt-bindings/clock/jz4770-cgu.h
> >>new file mode 100644
> >>index 000000000000..54b8b2ae4a73
> >>--- /dev/null
> >>+++ b/include/dt-bindings/clock/jz4770-cgu.h
> >
> >Can you split this file off into a different patch? That way clk
> >tree can apply clk patches on top of a stable branch where this
> >file lives by itself.
> 
> Oops, I forgot that in the v2.
> 
> The jz4770-cgu.c file includes and uses
> <dt-bindings/clock/jz4770-cgu.h>, so I don't think
> it would make sense to split it, since it wouldn't compile without it.

I was suggesting this header file be a patch before the driver C
file patch, so that it would still compile. Does that change
anything?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
