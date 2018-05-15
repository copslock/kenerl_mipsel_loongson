Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2018 20:28:54 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992848AbeEOS2rhAlMd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2018 20:28:47 +0200
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6746F20677;
        Tue, 15 May 2018 18:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526408921;
        bh=0MaLvbWan03WnEh2nVVBH2Vd6x+XYJwrE4kAr21ghEc=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=IjqWfL9LjCNuTaECahT7mSdHqi9EhQyXf+pBiRUSIPvEmKRbYmKecs8OYyJpXgkNU
         /7E0mLmclzZ/9UX1nzQ5wcYnlBi2sIZRgO1yDkwMTxTP+3cMW66kzrhpasABEQF4IQ
         R49/Sd8DtfXlwWKYGU5pz7xAQnCFnSEWtZNfBzsY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Paul Burton <paul.burton@mips.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180510065951.fiojonx5f776z5jm@mwanda>
Cc:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180509134031.11611-1-colin.king@canonical.com>
 <20180509140135.4dndt3baomtxups5@mwanda>
 <20180509163311.alvyibwwuwkumyxf@pburton-laptop>
 <20180510065951.fiojonx5f776z5jm@mwanda>
Message-ID: <152640892003.34267.13202118557714072290@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: boston: fix memory leak of 'onecell' on error return paths
Date:   Tue, 15 May 2018 11:28:40 -0700
Return-Path: <sboyd@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@kernel.org
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

Quoting Dan Carpenter (2018-05-09 23:59:51)
> It would be nice to make things static check clean.  One idea would be
> that the static checker could ignore resource leaks in __init functions.
> 

Typically if the stuff is so important that it doesn't work without it
then we throw in a panic() or a BUG() call to indicate that all hope is
lost. Otherwise, I'm not sure what's wrong with adding in proper error
paths for clean recovery.
