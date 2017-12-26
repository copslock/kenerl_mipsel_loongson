Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 19:10:57 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:56532 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990427AbdLZSKuTaZT0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Dec 2017 19:10:50 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 26 Dec 2017 18:10:32 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Tue, 26 Dec 2017 10:10:31 -0800
From:   Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To:     Mathieu Malaterre <malat@debian.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        James Hogan <jhogan@kernel.org>,
        Douglas Leung <douglas.leung@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] MIPS: math-emu: Do not export function `srl128`
Thread-Topic: [PATCH 1/2] MIPS: math-emu: Do not export function `srl128`
Thread-Index: AQHTfjbDDkW3mp2YQEe0MOnepteVLqNVu/WCgAAwRaY=
Date:   Tue, 26 Dec 2017 18:10:30 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEEC28277@MIPSMAIL01.mipstec.com>
References: <20171226104554.19612-1-malat@debian.org>,<BD3A5F1946F2E540A31AF2CE969BAEEEC2826A@MIPSMAIL01.mipstec.com>
In-Reply-To: <BD3A5F1946F2E540A31AF2CE969BAEEEC2826A@MIPSMAIL01.mipstec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1514311832-298554-11437-132503-1
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188373
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Aleksandar.Markovic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@mips.com
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

> > Fix non-fatal warning:
> >
> > arch/mips/math-emu/dp_maddf.c:19:6: warning: no previous prototype for ‘srl128’ [-Wmissing-prototypes]
> >  void srl128(u64 *hptr, u64 *lptr, int count)
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> >  arch/mips/math-emu/dp_maddf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
> > index 7ad79ed411f5..0e2278a47f43 100644
> > --- a/arch/mips/math-emu/dp_maddf.c
> > +++ b/arch/mips/math-emu/dp_maddf.c
> > @@ -16,7 +16,7 @@
> >
> >
> >  /* 128 bits shift right logical with rounding. */
> > -void srl128(u64 *hptr, u64 *lptr, int count)
> > +static void srl128(u64 *hptr, u64 *lptr, int count)
> >  {
> >          u64 low;
> >
> > --
> > 2.11.0
> 
> Acked-by: Aleksandar Markovic <aleksandar.markovic@mips.com>

However, there is an already submitted patch: (the code change is identical)

https://www.linux-mips.org/archives/linux-mips/2017-11/msg00044.html

Status of that patch on patchwork is "Accepted".

Regards,
Aleksandar
From robherring2@gmail.com Tue Dec 26 22:48:19 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 22:48:30 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35994 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbdLZVsTdzgZL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 22:48:19 +0100
Received: by mail-pf0-f193.google.com with SMTP id p84so19107776pfd.3
        for <linux-mips@linux-mips.org>; Tue, 26 Dec 2017 13:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zqsnwzEJfOQHQDA9LmqwMITDToqOnUFhyAaJKem0xT0=;
        b=ElLRk2lkh+OcaIpyK3aLKg6OGhlSd4zIWhmSuea3VVqhnF9KydnmIC0buzmVklrffq
         yjgrfdLqOeSYVgx9Vt13WI+odJlooQx1OYY/hW8J+wpj3t+c5pRSoMXAQoDVztME1OYh
         XXjjciiwabZyyI+/BpG9zT49ZPHNGD0AZor/TYV9V2RUsMxCJMr2ay38qqxiGXckrF7n
         b0nc0P5afh57GXN8/ykKx0glVDNcXlnZzwUwHliNYzfQ6Fr7hJQeKfpBAtGTcnOltj1b
         uVU/6KwetyCaXFDt9bjo28qD9lOtMcd8cPT5jCt0mxyEh8fGM35G4I6xScsPtlu6n8wz
         eT2g==
X-Gm-Message-State: AKGB3mKxWj73gkP3SVqo17cS9jrxNREVF+FsVUajs87QiOFXFJVY0Bec
        FhXFpLNrPID437zHekTeZA==
X-Google-Smtp-Source: ACJfBosZozXWMRLmNj8SL/V18HgGhqoCabL7cvtDNk7pAyrKXl3RqGdmTY+t7fKmW0mDKEUC8FDfjg==
X-Received: by 10.98.86.70 with SMTP id k67mr26352872pfb.214.1514324893265;
        Tue, 26 Dec 2017 13:48:13 -0800 (PST)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id g19sm58457018pfb.65.2017.12.26.13.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Dec 2017 13:48:12 -0800 (PST)
Date:   Tue, 26 Dec 2017 15:48:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        devicetree@vger.kernel.org, Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: Document mti,mips-cpc binding
Message-ID: <20171226214810.su23px4ue7q5t3xg@rob-hp-laptop>
References: <1513869627-15391-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1513869627-15391-2-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513869627-15391-2-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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
Content-Length: 1223
Lines: 34

On Thu, Dec 21, 2017 at 04:20:23PM +0100, Aleksandar Markovic wrote:
> From: Paul Burton <paul.burton@mips.com>
> 
> Document a binding for the MIPS Cluster Power Controller (CPC) which
> simply allows the device tree to specify where the CPC registers are
> located.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>  Documentation/devicetree/bindings/misc/mti,mips-cpc.txt | 8 ++++++++

power controllers are usually documented under bindings/power/

>  1 file changed, 8 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/mti,mips-cpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/mti,mips-cpc.txt b/Documentation/devicetree/bindings/misc/mti,mips-cpc.txt
> new file mode 100644
> index 0000000..c6b8251
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/mti,mips-cpc.txt
> @@ -0,0 +1,8 @@
> +Binding for MIPS Cluster Power Controller (CPC).
> +
> +This binding allows a system to specify where the CPC registers are
> +located.
> +
> +Required properties:
> +compatible : Should be "mti,mips-cpc".
> +regs: Should describe the address & size of the CPC register region.
> -- 
> 2.7.4
> 
