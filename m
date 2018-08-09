Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 17:49:17 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:58996 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994542AbeHIPtOnB5MI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2018 17:49:14 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F214160B74; Thu,  9 Aug 2018 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533829748;
        bh=4Nj5+8/soLOeBJIItHvHi97HqCf3cvzmLRCChSyhsVw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hz9NixG5vkCpJn8nRr205NmamWo1NGjoWEgGkQMSV/ihSyB0h3Ee+tH/OJKSFpUxw
         sosCtyvZ0T8tJgHJEkTmLf2Qaj3ZfdSlyofZmKdr3c50Z+xQRuz5FsIglceCPu+2JN
         8wOcZiUrTAlGC3WeGxgSZCWUdnPMtUWVUXiR6gjs=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E91E3607EB;
        Thu,  9 Aug 2018 15:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533829747;
        bh=4Nj5+8/soLOeBJIItHvHi97HqCf3cvzmLRCChSyhsVw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Jc9wYdeEh8K4Hdyhmgvo9bDR70QU+njFEI6+kjZ3OfgqiAj95trS0w79ouiSFqA2L
         dPY5REXQAim/7J+lrMn/OFheafMqyftqZHC4IBo2VNYlC0x/2Q9rDkDVk8Bnj+Civc
         ECzGTwrZ/LUFXfMS7wYCjspI2WqVq4c5qyj/8CpE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E91E3607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Michael =?utf-8?Q?B=C3=BCsch?= <m@bues.ch>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        b43-dev <b43-dev@lists.infradead.org>,
        Joe Perches <joe@perches.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: ssb: Remove SSB_WARN_ON, SSB_BUG_ON and SSB_DEBUG
References: <20180731221509.59c0a17a@wiggum>
Date:   Thu, 09 Aug 2018 18:49:02 +0300
In-Reply-To: <20180731221509.59c0a17a@wiggum> ("Michael \=\?utf-8\?Q\?B\=C3\=BCs\?\=
 \=\?utf-8\?Q\?ch\=22's\?\= message of
        "Tue, 31 Jul 2018 22:15:09 +0200")
Message-ID: <8736vn1qxd.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kvalo@codeaurora.org
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

Michael Büsch <m@bues.ch> writes:

> Use the standard WARN_ON instead.
> If a small kernel is desired, WARN_ON can be disabled globally.
>
> Also remove SSB_DEBUG. Besides WARN_ON it only adds a tiny debug check.
> Include this check unconditionally.
>
> Signed-off-by: Michael Buesch <m@bues.ch>

Applied manually:

209b43759d65 ssb: Remove SSB_WARN_ON, SSB_BUG_ON and SSB_DEBUG

-- 
Kalle Valo
