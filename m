Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Apr 2017 20:18:11 +0200 (CEST)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:36858
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993892AbdDUSSEYigkZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Apr 2017 20:18:04 +0200
Received: by mail-wm0-x241.google.com with SMTP id u65so6317742wmu.3;
        Fri, 21 Apr 2017 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=55IpBPGJ9FUoLbAEqNpFSUYP4hR4KQkVPG5C0vFAU5Y=;
        b=hndhChrsIsG+35AxG2xwltCbgKjZ5w4izso+If14t12iFbVSh6u/iIy4g9dEJK2daX
         o5BmGgDLmaHOnTh1ZpVUhfLS53wczslNXSoGzH63lAKZOG7jYZLAXAEml5/w2e+NyY4b
         0PPbLLHD/mvFWj1in22VwvsxTwNXTS/KrbfFRMATjAF9R4h9X+tAzdMy+ZFIGUwp47MA
         TNxva2G/ZT2NNr3vWkLdLQWYvgycBgz4F2Tvc3shTk2p1uK5vO4qfciWz1yAPMPi/qD9
         fv6u6W9KMDHuxq30hL3m0xhllCOEs+uouD7Mku+zF5bbl3nYgrX1XvPS14N0YYmH0zfC
         avYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=55IpBPGJ9FUoLbAEqNpFSUYP4hR4KQkVPG5C0vFAU5Y=;
        b=R4cOcfjQ34k0w0HWSh8uRGO8wujGrGLz4RlE2D5NlVHyfTIN+qEjiPT2ew1SvHJSu1
         NfxyKIIrzxMyiD3j0I3y0DVNIgwPlILryFXtV30oqsRH0s5VP//oim75Y2+3czBj35+g
         oNteVmzGlsM9l4RB3vntAGg4MqoOgcCC6aLCV3UIUY5xNStMJXcqtoPBuevMiggz41yh
         NiSrwHgNxgaPds2y95r0qY4HDuEykEk4Hy/Z1ZX2ABQNMlLlm64v6w0Ua3OC7VQvejlk
         cb08c2QM+NSqGIy3D3EyPfvACVDnqG5cizkHDk3JWWDb3uSkYvnJinuEOjLKVIYe6jur
         EYLg==
X-Gm-Message-State: AN3rC/4vbMCyywWPf84djZS1S3r7PK4X9WLMBlIXrCPlN9ooBRVQ666i
        CKdbepSuS7fPkW5PDCig66pfF2TXqA==
X-Received: by 10.28.143.135 with SMTP id r129mr9186wmd.54.1492798679118; Fri,
 21 Apr 2017 11:17:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.166.80 with HTTP; Fri, 21 Apr 2017 11:17:38 -0700 (PDT)
In-Reply-To: <20170417192942.32219-2-hauke@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de> <20170417192942.32219-2-hauke@hauke-m.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 21 Apr 2017 20:17:38 +0200
Message-ID: <CAFBinCBjnDz3oSUVOLKR0ku-TvrCHDNEgGX6NzGnkSQCk_yPLA@mail.gmail.com>
Subject: Re: [PATCH 01/13] MIPS: lantiq: Use of_platform_populate instead of __dt_register_buses
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <martin.blumenstingl@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.blumenstingl@googlemail.com
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

On Mon, Apr 17, 2017 at 9:29 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> This allows populating syscon devices which are using "simple-mfd"
> instead of "simple-bus".
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  arch/mips/lantiq/prom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
> index 96773bed8a8a..72cc12f1b6a5 100644
> --- a/arch/mips/lantiq/prom.c
> +++ b/arch/mips/lantiq/prom.c
> @@ -117,7 +117,8 @@ void __init prom_init(void)
>
>  int __init plat_of_setup(void)
>  {
> -       return __dt_register_buses(soc_info.compatible, "simple-bus");
> +       return of_platform_populate(NULL, of_default_bus_match_table, NULL,
> +                                   NULL);
>  }
>
>  arch_initcall(plat_of_setup);
> --
> 2.11.0
>
