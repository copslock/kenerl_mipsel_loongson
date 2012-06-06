Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 04:36:50 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:59557 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903640Ab2FFCgq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2012 04:36:46 +0200
Received: by wibhm14 with SMTP id hm14so4028230wib.6
        for <linux-mips@linux-mips.org>; Tue, 05 Jun 2012 19:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=4xLRDYfoPJsrC0hp2IIA3x8X9sqxQ584pIXGycviNC8=;
        b=px1IoiKnAH8umOKj/LY1IC1AT0NgoP7kFMPR7MaCW8VYfkjQA3oETeWcVBfXEswwdg
         4A2bpvFTBslPe8YnJ5hq/1HVALpTfo30Sli0NloORjOyrK3i2gaLby7dw14i21NXJkjC
         bGphE+p2OpGhUSy/WcfNi9qYOYcMdj5OOEftSkAOVXcekTyBpfQRmriK81Tm+eM/VcRH
         FNGJYv7p+XOGyWO+v8HpOjSYHIikUKNHPZETCEjd/FLW8xhMCpOzPyCDIK/blFrvaVNj
         RyDkDwyF+nt6EQdv8FqAcH/PysdImQXQ9p9DBNiGXQtWCEDpDOuN/bmhKdbgEI1G/rdG
         AYPg==
MIME-Version: 1.0
Received: by 10.216.205.5 with SMTP id i5mr15340976weo.6.1338950201270; Tue,
 05 Jun 2012 19:36:41 -0700 (PDT)
Received: by 10.180.84.136 with HTTP; Tue, 5 Jun 2012 19:36:41 -0700 (PDT)
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B801146957D8@exchdb03.mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
        <1338931179-9611-35-git-send-email-sjhill@mips.com>
        <CACBHAezRk6T6xonHHM+mwBgOQ4qR0+pbZ0ok+kms8zOv3QGmHA@mail.gmail.com>
        <31E06A9FC96CEC488B43B19E2957C1B801146957D8@exchdb03.mips.com>
Date:   Wed, 6 Jun 2012 11:36:41 +0900
X-Google-Sender-Auth: kePwLLzUUcCOAPnQywpN9B0xPTs
Message-ID: <CACBHAewnV1_YQ=PV66eBWZ3SVjNZzJ3UKnj_oEtJ9FEuO2_yhg@mail.gmail.com>
Subject: Re: [PATCH 34/35] MIPS: vr41xx: Cleanup firmware support for vr41xx platforms.
From:   Yuasa Yoichi <yuasa@linux-mips.org>
To:     "Hill, Steven" <sjhill@mips.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 33557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
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

Hi,

2012/6/6 Hill, Steven <sjhill@mips.com>:
> Yoichi,
>
> I did remove it in the next patch 35/35.
>

Please include in the related change.

Thanks,

Yoichi
