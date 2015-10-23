Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 05:58:32 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32894 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007575AbbJWD6ahlKDR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 05:58:30 +0200
Received: by pabrc13 with SMTP id rc13so105483727pab.0;
        Thu, 22 Oct 2015 20:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wVPHEsgKB7aSGEwHhgBbbfq6oQ0F1xPJnMLMQskY7fA=;
        b=rA8QX+bW3vYF/oGxS5a2R+cb79Sq7myy0jc+4uvq49m+W0USfDDVaxtIj6Nbop+kcH
         coJxIX92A51BoQGvfB5F79mv+vt8/J5VgT8xeT+EQXyZ9UMY1xJDEbFFPq5xTcDxSOBV
         CsFnFkpWFye7KoGFpIzsiO3BRjMDCwKzgfWbKHHUAyOHK9xM83GJE8nunQPYgZK1FyG7
         dovV7mk9QSWIGfDUm7mQlWeiXKC4Ptp7Ak9jK6TkfAHhP/jPiR+nY5QkB3CT0NBHHa6E
         fSIktXQLMiA1UBb3m4ObwXu4O2muqksgx44Bu/yeBd+IAKLvpy2XQvapJ3cU4K0D11zd
         UEYg==
X-Received: by 10.68.225.66 with SMTP id ri2mr2435229pbc.59.1445572704347;
        Thu, 22 Oct 2015 20:58:24 -0700 (PDT)
Received: from mtj.duckdns.org (mobile-166-171-248-169.mycingular.net. [166.171.248.169])
        by smtp.gmail.com with ESMTPSA id pu5sm16327975pbc.58.2015.10.22.20.58.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Oct 2015 20:58:23 -0700 (PDT)
Date:   Fri, 23 Oct 2015 12:58:17 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 00/10] add support SATA for BMIPS_GENERIC
Message-ID: <20151023035817.GA18907@mtj.duckdns.org>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
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

On Fri, Oct 23, 2015 at 10:44:13AM +0900, Jaedon Shin wrote:
> Hi all,
> 
> This patch series adds support SATA for BMIPS_GENERIC.
> 
> Ralf,
> I request you to drop already submitted patches for NAND device nodes.
> It is merge conflicts with this patches.
> http://patchwork.linux-mips.org/patch/10577/
> http://patchwork.linux-mips.org/patch/10578/
> http://patchwork.linux-mips.org/patch/10579/
> http://patchwork.linux-mips.org/patch/10580/
> 
> Jaedon Shin (10):
>   ata: ahci_brcmstb: make the driver buildable on BMIPS_GENERIC
>   ata: ahch_brcmstb: add data for port offset
>   ata: ahci_brcmstb: add support 40nm platforms

ata part looks fine to me.  Let me know when the other parts get in.
I'll apply the ata ones to libata/for-4.4.

Thanks.

-- 
tejun
