Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 13:09:59 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:47970 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822680Ab3FTLJykLVue (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 13:09:54 +0200
Received: by mail-lb0-f171.google.com with SMTP id 13so5728385lba.30
        for <linux-mips@linux-mips.org>; Thu, 20 Jun 2013 04:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=f5wKlMvs7x5TBSCAXSmhkgGaCh9GSl6GIMC7tD+A10w=;
        b=PXqb6cQRYdhaYfz0lU1+tqnQvhqqlQqzIyfU35FNmzT+PwQ/dtHJbnSyRXDmeR7mJ+
         TQasEKNlKcy5Xpc1SPdw9QaqpBG2E9RhThzZPD1/c9N63ycwsqzC7DfWRi+YyrpTxh73
         MamGTjL25R8mD0Y9PWlO4ac63bsvOhwiaSlfKQG32/udXb7BXXka82g2/gEUeE4AdEkt
         iR+Q7xjkDarlQDFhT1hoinbWnK8H8jnIsTNkLmCFu67vmMTIrkbglecNBorl3f900y6V
         zJwtLkfskJoLUJ42P8+FPrEIAgs64TXY3GvfsdemtsXn+fAIsdEuMBwS3YMAmi8xaLpi
         yuYw==
X-Received: by 10.112.55.104 with SMTP id r8mr4353008lbp.49.1371726589108;
        Thu, 20 Jun 2013 04:09:49 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-149-191.pppoe.mtu-net.ru. [91.76.149.191])
        by mx.google.com with ESMTPSA id zo6sm160564lbb.9.2013.06.20.04.09.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 04:09:48 -0700 (PDT)
Message-ID: <51C2E2FF.9070703@cogentembedded.com>
Date:   Thu, 20 Jun 2013 15:09:51 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        ralf@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account for
 PHYS_OFFSET"
References: <1371705218-4570-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1371705218-4570-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlrxMHxKDIRtSeTIfV9Ay9+psPDcjco61dQ0iiCxC8OoCmljPfObodOC7pRjJuHPhj3lNgJ
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 20-06-2013 9:13, Steven J. Hill wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

> This reverts commit 3f4579252aa166641861a64f1c2883365ca126c2. It is
> invalid because the macros CAC_ADDR and UNCAC_ADDR have a kernel
> virtual address as an argument and also returns a kernel virtual
> address. Using and physical address PHYS_OFFSET is blatantly wrong
> for a macro common to multiple platforms.

> Change-Id: I19feb1e537c6a517e6b42f3ec6ce746b6a97617e

     Same comment as on all Leonid's patches -- remove this line.

> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>

WBR, Sergei
