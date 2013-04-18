Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Apr 2013 14:50:14 +0200 (CEST)
Received: from mail-wi0-f179.google.com ([209.85.212.179]:62587 "EHLO
        mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826577Ab3DRMuMpAU8m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Apr 2013 14:50:12 +0200
Received: by mail-wi0-f179.google.com with SMTP id l13so2409270wie.6
        for <linux-mips@linux-mips.org>; Thu, 18 Apr 2013 05:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:subject:to:cc:in-reply-to:references:date
         :message-id:x-gm-message-state;
        bh=DOgmqExDsG3S1iVe02CkyAtlllbZzd0EfMot92UFm/s=;
        b=QZVp9EtmETakMQYB0tOC46UIfwaoY7P2aPurZ7Q8Th+Q/ZfCn4DZC5XGez2K1Sak33
         pZe4u2PPmmiVPvdkXaWeMVsJxiJbumWCff+nkq5epWIIisEqoUyoPg8SHbtEtyc38UHO
         0w26o1iI60wsPKZB9ChSzdS0ndZOc8a1Fpy77Mlagkov4UnHI3Vp1Hq57On7Ka8QJ5Rc
         /+Mn9pNYbEEPRXO0/Wg/+/KPkon7OVR07YJDshklppsAIoHd1p+Mfpx/lXtihz58WZST
         NgP1Cgu9il6L6FmWoqsl1IQhgzvCGCEOpSmk93tXLPfGFYEhIFoo+D81nqkUQtuoeA7Z
         h98Q==
X-Received: by 10.194.83.33 with SMTP id n1mr18528802wjy.7.1366289406680;
        Thu, 18 Apr 2013 05:50:06 -0700 (PDT)
Received: from localhost (host31-53-18-197.range31-53.btcentralplus.com. [31.53.18.197])
        by mx.google.com with ESMTPS id g9sm15973869wix.1.2013.04.18.05.50.04
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 05:50:05 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id DF39F3E118C; Thu, 18 Apr 2013 13:50:03 +0100 (BST)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V2 1/6] DT: add vendor prefixes for Ralink
To:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org
In-Reply-To: <1366103562-21463-1-git-send-email-blogic@openwrt.org>
References: <1366103562-21463-1-git-send-email-blogic@openwrt.org>
Date:   Thu, 18 Apr 2013 13:50:03 +0100
Message-Id: <20130418125003.DF39F3E118C@localhost>
X-Gm-Message-State: ALoCoQmKwcQM1Bu1sJeYV+G8OQM3j1dl+q70wv4gnJ+FAotpRAm0zyXpUoNspQ/n/fcwCgt5zz2H
Return-Path: <grant.likely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
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

On Tue, 16 Apr 2013 11:12:37 +0200, John Crispin <blogic@openwrt.org> wrote:
> Signed-off-by: John Crispin <blogic@openwrt.org>

For the whole series:
Acked-by: Grant Likely <grant.likely@secretlab.ca>

Please merge via a MIPS tree.

g.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 19e1ef7..6527412 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -41,6 +41,7 @@ onnn	ON Semiconductor Corp.
>  picochip	Picochip Ltd
>  powervr	PowerVR (deprecated, use img)
>  qcom	Qualcomm, Inc.
> +ralink	Mediatek/Ralink Technology Corp.
>  ramtron	Ramtron International
>  realtek Realtek Semiconductor Corp.
>  renesas	Renesas Electronics Corporation
> -- 
> 1.7.10.4
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
