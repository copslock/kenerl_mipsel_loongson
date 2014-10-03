Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Oct 2014 03:26:32 +0200 (CEST)
Received: from mail-ig0-f180.google.com ([209.85.213.180]:55844 "EHLO
        mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010195AbaJCB0aka0m8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Oct 2014 03:26:30 +0200
Received: by mail-ig0-f180.google.com with SMTP id uq10so498310igb.13
        for <multiple recipients>; Thu, 02 Oct 2014 18:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=k/qECb9hM88L5aZcM7xB+RdVFFkR2pdGa3Ij4JYGCD4=;
        b=0zZb2vhGDHH47TnIO6l5CvphrEE7BldhrbxmaVi1mEcdyiCfLxMyMb3rhuUJ3FQ+gZ
         DQ/U+FlBuCfavojZ9e0QuAqkhsafacxIpGFuPwnyAuJps0Xr44ASpvK5Y12Z8/iTWyU7
         6/XnSz0WCFs7t96SICkrXJc+W53kc7nyA8YwLHFJUq82j8RsD9aOCC1x5C3fM3BMN1MC
         3aVnZMgt92E45nAYGkear2YHXv/llJ18FMMqsHHOO0nhKpH5zGId54UfLH8MvOWUR5Wg
         9/Pw2HOZHLZKxsGg6ubtbZM1V8p+lvaRBG7yd5n8N4U/sn+GIifoaioeDJ1lOPOyplQe
         GKAQ==
X-Received: by 10.50.134.163 with SMTP id pl3mr9819900igb.1.1412299584568;
        Thu, 02 Oct 2014 18:26:24 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ro6sm484731igb.3.2014.10.02.18.26.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 Oct 2014 18:26:24 -0700 (PDT)
Message-ID: <542DFB3E.30802@gmail.com>
Date:   Thu, 02 Oct 2014 18:26:22 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org, blogic@openwrt.org
Subject: Re: [PATCH] MIPS: DTS: add a .gitignore file to ignore .dtb
References: <1412296187-2370-1-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1412296187-2370-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/02/2014 05:29 PM, Florian Fainelli wrote:
> Build for Broadcom XLP revealed that we are not ignoring DTB files and
> that would clobber the git status output. Fix that by adding a
> .gitignore file in arch/mips/boot/dts/.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   arch/mips/boot/dts/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 arch/mips/boot/dts/.gitignore
>
> diff --git a/arch/mips/boot/dts/.gitignore b/arch/mips/boot/dts/.gitignore
> new file mode 100644
> index 000000000000..b60ed208c779
> --- /dev/null
> +++ b/arch/mips/boot/dts/.gitignore
> @@ -0,0 +1 @@
> +*.dtb

Do we check in .dtb files anywhere in the kernel tree?

If not, this could be moved to a higher level (perhaps top level) .gitignore

David Daney


>
