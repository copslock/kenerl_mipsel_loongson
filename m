Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2017 14:02:03 +0200 (CEST)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:37934
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992196AbdIFMBxKmTM2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Sep 2017 14:01:53 +0200
Received: by mail-wr0-x241.google.com with SMTP id p37so838201wrb.5;
        Wed, 06 Sep 2017 05:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aStrOtNmQG7a5rtihOeMxPhyD/oyLQIZr9AOoDZh8sU=;
        b=E+rDdydmiq94ZNp0ILuXasyBtIgXK0wOj+oPODdgECfxVI9hh98wYNcmbsZ0f1brsK
         hXeyAjTR8MvDPRqcelcfg+gvjTiMlWDyqKZ2BYzgmDCwo4DTKbxKIDg1PWZB7OBdRvAJ
         4xeBvYd4uD2wXgO8ajL84AN/sJNhKQV9ZSF8CT4mQFnwY4EZ6FXrmnfod3HFwYtZQgOO
         8xrPgDtUt7i+uMaLE0QcLh21fRDHbfCgTMt3uPDEQ11mkM70yDPpP6mHAyqpNB8KvE1c
         CYSUeETsFlb5jTq+DcGYTQIEN+1pxKeecwTIzEDIDdG0N3UysKM51GkWSK/Z9/KmJ1a0
         pgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=aStrOtNmQG7a5rtihOeMxPhyD/oyLQIZr9AOoDZh8sU=;
        b=YOoKVRH5/rqiJMxWHJ53MgKFzaHtTaZLKikauKraFDaOIrVlxyEMadNAkAx5zo/+EM
         Dx4708KNnbzIOibQw21+2Vd0sbVD87HpdvirNUOg2gz7ICul+wWBQmCL9iIwHa/fl9m2
         Poe8QCmoyW/2sR1CwMSRNU6vhxu37O/gCZZ6+9puWoVGuiPh54ywjYaE3gLsxoYfXE8K
         KILG7ZkPVGq1NC98saWQxAmM1X00NWHa2vKLGrPHqa5GGD9dJnQs1ExGhO3uvzKG5fk5
         4rnuWujrOKU21QSq+VHWNWvdQe/R5eeGWQIxiLeHDx7tqkY9wqG1kSLPA+2SOL/pnqD9
         dmmg==
X-Gm-Message-State: AHPjjUhIkaHmVHaoS/TBEGbgU5Hv4/4fQ/GugPahoIzMTRa3vwvTP5bc
        7UMTO7qTdjXRMSI3e3oneQ==
X-Google-Smtp-Source: ADKCNb6jdqqkSyf8xTAcXPIdiX5BVUlX4UIxsIcTV/8EDvIM4NTxhQcabYzbogWFg7Nm8ILmebEppQ==
X-Received: by 10.223.160.46 with SMTP id k43mr1751073wrk.113.1504699307161;
        Wed, 06 Sep 2017 05:01:47 -0700 (PDT)
Received: from localhost (net-188-152-76-252.cust.dsl.teletu.it. [188.152.76.252])
        by smtp.gmail.com with ESMTPSA id p1sm1968701wra.29.2017.09.06.05.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Sep 2017 05:01:46 -0700 (PDT)
Date:   Wed, 6 Sep 2017 14:01:44 +0200
From:   Rocco Folino <rocco.folino@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH] MIPS: ath79: support devicetree selection
Message-ID: <20170906120144.GA20147@void>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, John Crispin <john@phrozen.org>
References: <b78cb3ef8df8531efdb7b011743ad3f38978015d.1503070362.git.rocco.folino@gmail.com>
 <20170906111435.GA1856@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906111435.GA1856@linux-mips.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <rocco.folino@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rocco.folino@gmail.com
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

On Wed, Sep 06, 2017 at 01:14:35PM +0200, Ralf Baechle wrote:
> On Fri, Aug 18, 2017 at 05:32:42PM +0200, Rocco Folino wrote:
> 
> > Allow to choose devicetrees from Kconfig.
> > 
> > Signed-off-by: Rocco Folino <rocco.folino@gmail.com>
> > ---
> >  arch/mips/ath79/Kconfig         | 44 +++++++++++++++++++++++++++++++++++++++++
> >  arch/mips/boot/dts/qca/Makefile | 10 +++++-----
> >  2 files changed, 49 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
> > index dfc60209dc63..b43d116187af 100644
> > --- a/arch/mips/ath79/Kconfig
> > +++ b/arch/mips/ath79/Kconfig
> > @@ -1,5 +1,49 @@
> >  if ATH79
> >  
> > +menu "Atheros AR71XX/AR724X/AR913X devicetree selection"
> > +
> > +config DTB_ATH_DPT_MODULE
> > +	bool "DPTechnics DPT-Module"
> > +	select SOC_933X
> 
> There is no symbol SOC_933X.  Did you mean SOC_AR933X?

Yes, right

> 
> Anyway, your patch does more than the changelog ("Allow to choose
> devicetrees from Kconfig") says, so please either fix the changelog
> or split that into multiple patches with proper changelogs.

Ok, I'll fix everything in the v2

thanks for the comments.

Rocco
