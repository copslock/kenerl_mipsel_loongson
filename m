Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 17:00:55 +0100 (CET)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34527 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006757AbcAEQAxbxQPe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 17:00:53 +0100
Received: by mail-pa0-f47.google.com with SMTP id uo6so197878987pac.1
        for <linux-mips@linux-mips.org>; Tue, 05 Jan 2016 08:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=hL2Ii8GgpcVTmRC4eUkjV7rV54w9vOVG+MMh/5T6PPI=;
        b=hG+uWVAea8Pf9cvR7Ym162XIDFM4qb4WkPhs83x9vDtqVb7A5btaWoJvU0rtj+H3i8
         YSLDEw6TdNpchQOfUCS31eS36AbktcDBk2IQ7qf5hyReb6mIKDJkQrM/UoDQR48WqTzi
         xpr10LcHNboBm7/eopCrANazYJBBOkfwzp6tNfbXPoClCiHCpL8FDtKAk3t37f7mhRtu
         nCjvAZXu94ktPmG7tMrcW8yt8SLFiLQNvbMDeo1eVGSkbZYH9QFutsOqabP/TW7ZDRks
         KRGSXinaWvWC35be/50vAZv5E3PxF9YKkfYmhLVyK8VI5Sn2v+CoA7SR9FXDw40pyOv2
         0cDg==
X-Received: by 10.67.5.2 with SMTP id ci2mr135073267pad.47.1452009647530;
        Tue, 05 Jan 2016 08:00:47 -0800 (PST)
Received: from ?IPv6:2620:0:1000:3e02:281f:ec8b:a5c5:b517? ([2620:0:1000:3e02:281f:ec8b:a5c5:b517])
        by smtp.gmail.com with ESMTPSA id k77sm47305880pfb.37.2016.01.05.08.00.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jan 2016 08:00:46 -0800 (PST)
Message-ID: <1452009645.8255.96.camel@edumazet-glaptop2.roam.corp.google.com>
Subject: Re: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Rabin Vincent <rabin@rab.in>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, daniel@iogearbox.net,
        ast@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 05 Jan 2016 08:00:45 -0800
In-Reply-To: <1452007387-626-1-git-send-email-rabin@rab.in>
References: <1452007387-626-1-git-send-email-rabin@rab.in>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <eric.dumazet@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.dumazet@gmail.com
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

On Tue, 2016-01-05 at 16:23 +0100, Rabin Vincent wrote:
> The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
> instructions since it XORs A with X while all the others replace A with
> some loaded value.  All the BPF JITs fail to clear A if this is used as
> the first instruction in a filter.

Is x86_64 part of this 'All' subset ? ;)

>   This was found using american fuzzy
> lop.
> 
> Add a helper to determine if A needs to be cleared given the first
> instruction in a filter, and use this in the JITs.  Except for ARM, the
> rest have only been compile-tested.
> 
> Fixes: 3480593131e0 ("net: filter: get rid of BPF_S_* enum")
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
