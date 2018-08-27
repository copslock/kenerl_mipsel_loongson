Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Aug 2018 07:15:08 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990471AbeH0FPFeDdI9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Aug 2018 07:15:05 +0200
Received: from localhost (unknown [106.200.197.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C90A20C51;
        Mon, 27 Aug 2018 05:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535346898;
        bh=1G/1biGqj8Ja1t2gJIfpTh6FPYc9yhMY7ZPPmgod0ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DyYpW6tIf8ijCUvhKH6tILTu7c/1MAXokIv14Vrz6O4IvWbufi4Rnw22uOtHiq+tE
         NitT0gtl6kpxbsp0TjZIsu9Qbp3RS/5411NQ4PxGQgmNMW5aPIXifb4cWfGeYB+TcN
         SuzAFkB8taspMZomQvPIATlbJMxRQ9MwhwKg5OS0=
Date:   Mon, 27 Aug 2018 10:44:50 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v4 00/18] JZ47xx DMA patchset v4
Message-ID: <20180827051450.GS2388@vkoul-mobl>
References: <20180807114218.20091-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807114218.20091-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vkoul@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vkoul@kernel.org
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

On 07-08-18, 13:42, Paul Cercueil wrote:
> Hi,
> 
> This is the V4 of my Ingenic JZ47xx DMA patchset.

This does not apply for me. Please rebase on rc1, fix Rob's and my
comment and send

Also I noticed checkpatch gave warns on some style issues (--strict
option) please see if they make sense and fix if it does.

Thanks
-- 
~Vinod
