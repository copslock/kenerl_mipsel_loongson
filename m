Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 18:57:10 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:41772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992852AbeKFR5GYAxzI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Nov 2018 18:57:06 +0100
Received: from localhost (unknown [131.107.160.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9237920862;
        Tue,  6 Nov 2018 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541527024;
        bh=dE8q89PzoeDFNnMvo7hPhMLTxOSh0ij9spgfVdpjT/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Z3le6zv0GuRjzBkMt6fBOwhgTYrTHtFAmK1HE/LAuq/g4q9I2tYG5QRJifEuOLPO
         oYrMsBU88xQem8/ZIEa7e9Ygj75DO4yasjgoNssDcKxOTrRpOWCaFMkfAsNT7nc6MB
         z7DMjwdx2KVzDtu3S7qM66QXBDQ5MXi3d3LgiBPY=
Date:   Tue, 6 Nov 2018 12:56:52 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <pburton@wavecomp.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [4.19 PATCH] MIPS: VDSO: Reduce VDSO_RANDOMIZE_SIZE to 64MB for
 64bit
Message-ID: <20181106175652.GF151445@sasha-vm>
References: <20181105225815.24489-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181105225815.24489-1-paul.burton@mips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <sashal@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sashal@kernel.org
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

On Mon, Nov 05, 2018 at 10:58:30PM +0000, Paul Burton wrote:
>From: Huacai Chen <chenhc@lemote.com>
>
>[ Upstream commit c61c7def1fa0a722610d89790e0255b74f3c07dd ]
>
>Commit ea7e0480a4b6 ("MIPS: VDSO: Always map near top of user memory")
>set VDSO_RANDOMIZE_SIZE to 256MB for 64bit kernel. But take a look at
>arch/mips/mm/mmap.c we can see that MIN_GAP is 128MB, which means the
>mmap_base may be at (user_address_top - 128MB). This make the stack be
>surrounded by mmaped areas, then stack expanding fails and causes a
>segmentation fault. Therefore, VDSO_RANDOMIZE_SIZE should be less than
>MIN_GAP and this patch reduce it to 64MB.
>
>Signed-off-by: Huacai Chen <chenhc@lemote.com>
>Signed-off-by: Paul Burton <paul.burton@mips.com>
>Fixes: ea7e0480a4b6 ("MIPS: VDSO: Always map near top of user memory")
>Patchwork: https://patchwork.linux-mips.org/patch/20910/
>Cc: Ralf Baechle <ralf@linux-mips.org>
>Cc: James Hogan <jhogan@kernel.org>
>Cc: linux-mips@linux-mips.org
>Cc: Fuxin Zhang <zhangfx@lemote.com>
>Cc: Zhangjin Wu <wuzhangjin@gmail.com>
>Cc: Huacai Chen <chenhuacai@gmail.com>
>Cc: stable@vger.kernel.org # 4.19

Now queued for 4.19, thank you.

--
Thanks,
Sasha
