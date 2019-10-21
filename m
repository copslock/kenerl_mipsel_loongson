Return-Path: <SRS0=F5TX=YO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E7DCA9EB9
	for <linux-mips@archiver.kernel.org>; Mon, 21 Oct 2019 14:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4886F2053B
	for <linux-mips@archiver.kernel.org>; Mon, 21 Oct 2019 14:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfJUOwi (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:52:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35115 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfJUOwi (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 21 Oct 2019 10:52:38 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iMZ2r-0003zO-BK; Mon, 21 Oct 2019 16:52:29 +0200
Date:   Mon, 21 Oct 2019 16:52:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Huacai Chen <chenhc@lemote.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        chenhuacai@gmail.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 110/110] lib/vdso: Improve do_hres() and update vdso data
 unconditionally
In-Reply-To: <1571662320-1280-1-git-send-email-chenhc@lemote.com>
Message-ID: <alpine.DEB.2.21.1910211648200.1904@nanos.tec.linutronix.de>
References: <1571662320-1280-1-git-send-email-chenhc@lemote.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, 21 Oct 2019, Huacai Chen wrote:
> @@ -50,7 +50,7 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
>  		cycles = __arch_get_hw_counter(vd->clock_mode);
>  		ns = vdso_ts->nsec;
>  		last = vd->cycle_last;
> -		if (unlikely((s64)cycles < 0))
> +		if (unlikely(cycles == U64_MAX))
>  			return -1;

That used to create worse code than the weird (s64) type cast which has the
same effect. Did you double check that there is no change?

Thanks,

	tglx
