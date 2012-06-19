Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 23:50:45 +0200 (CEST)
Received: from mail-qc0-f177.google.com ([209.85.216.177]:33995 "EHLO
        mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903686Ab2FSVui (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2012 23:50:38 +0200
Received: by qcsu28 with SMTP id u28so4250854qcs.36
        for <linux-mips@linux-mips.org>; Tue, 19 Jun 2012 14:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=U1ttGbzfNWrkcS+F1byqg2PI81ZzfZsuHnZwCacj8sE=;
        b=REytqFHZtAGYv4xhIRee1eNO5RNrnlVhtrDXTm2BR1ExNjA1kZgGloS8/WMLkXkaOp
         mGgoB5tpklh+ca97DGiZNFGvzPO7IpreFwovhm+fL/av6A6gIN4dC+aO4ae0hh3+Qowu
         wRteAZ/zwY/CNpRs/slRriI81zCyWPUTll/aLS/cnSy/wLAktxM8FDxCcpNlFpOCxg4K
         nW2JXMUaX/frWTcorzh7Q0uwmHS/+UPlG5gIKHaQ2GCF7ls6CO14sqgt86LHRAV5Amno
         6LzPAGrNrUnh82LNW94TdyQ1tSc5LUQtjVRwabZ+d1eRMsyy7BDne+6ZRKJPn3Y1WnCB
         CLZQ==
MIME-Version: 1.0
Received: by 10.224.187.206 with SMTP id cx14mr35978582qab.72.1340142632077;
 Tue, 19 Jun 2012 14:50:32 -0700 (PDT)
Received: by 10.229.5.15 with HTTP; Tue, 19 Jun 2012 14:50:32 -0700 (PDT)
In-Reply-To: <1340011706-32281-1-git-send-email-stigge@antcom.de>
References: <1340011706-32281-1-git-send-email-stigge@antcom.de>
Date:   Tue, 19 Jun 2012 23:50:32 +0200
Message-ID: <CACRpkdZH7bMVRLYdrSJjcuNOPvY5P8yGMnoVhih4ycD7AV8kUw@mail.gmail.com>
Subject: Re: [PATCH] mips: pci-lantiq: Fix check for valid gpio
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Roland Stigge <stigge@antcom.de>
Cc:     ralf@linux-mips.org, blogic@openwrt.org, jkosina@suse.cz,
        standby24x7@gmail.com, bhelgaas@google.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        grant.likely@secretlab.ca, linus.walleij@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQm2uFKPQrtDFLS3/5C/PRw0snrTXnolDbbyxYLfprWdpSnM6p9mJhzP44VvR+32QaAcd5Hh
X-archive-position: 33728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Jun 18, 2012 at 11:28 AM, Roland Stigge <stigge@antcom.de> wrote:

> This patch fixes two checks for valid gpio number, formerly (wrongly)
> considering zero as invalid, now using gpio_is_valid().
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
