Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2017 15:23:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47365 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993894AbdGFNXVP1DRx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Jul 2017 15:23:21 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 7342E13C5E272;
        Thu,  6 Jul 2017 14:23:11 +0100 (IST)
Received: from BADAG04.ba.imgtec.org (10.20.40.112) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 6 Jul
 2017 14:23:14 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 BADAG04.ba.imgtec.org ([fe80::b930:4082:95b0:e446%15]) with mapi id
 14.03.0266.001; Thu, 6 Jul 2017 06:23:11 -0700
From:   Miodrag Dinic <Miodrag.Dinic@imgtec.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        "jinqian@google.com" <jinqian@google.com>,
        "lfy@google.com" <lfy@google.com>, Bo Hu <bohu@google.com>,
        "arve@android.com" <arve@android.com>
Subject: RE: [PATCH v2 06/10] Documentation: Add device tree binding for
 Goldfish FB driver
Thread-Topic: [PATCH v2 06/10] Documentation: Add device tree binding for
 Goldfish FB driver
Thread-Index: AQHS8CaWT/npMCJNDUyBQ7ycfQt1mqI873QAgAC3epg=
Date:   Thu, 6 Jul 2017 13:23:10 +0000
Message-ID: <232DDC0A2B605E4F9E85F6904417885F015D929D32@BADAG02.ba.imgtec.org>
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1498664922-28493-7-git-send-email-aleksandar.markovic@rt-rk.com>,<CAL_Jsq+m-g__T34W2-7ddAF9ehH1woT3WfuxuDnHQMfzrg86Hg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+m-g__T34W2-7ddAF9ehH1woT3WfuxuDnHQMfzrg86Hg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Miodrag.Dinic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Miodrag.Dinic@imgtec.com
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

cc-ing Arve Hjønnevåg who originally upstreamed Goldfish FB driver
cc-ing Jin Quian, Bo Hu & Lingfeng Yang from Google

Hi Rob,

Thanks for taking the time to review the patches

> I don't know that this should even go upstream. There's no upstream
> qemu support for goldfish-fb. Maybe this is a minor driver change, but
> FB drivers are being replaced with DRM drivers. And the time for AOSP
> supporting framebuffer drivers is limited I think with HWC2 and
> explicit fence support in DRM.

Goldfish FB is actively used by all supported architectures in Android (Intel/ARM/MIPS)
and is part of Android emulator project and so far, there have been no limitations in
AOSP for using it.

We have already tested this particular version of the driver for MIPS
Ranchu virtual platform (introduced in this series) which is DT based and
therefore we needed to integrate device tree support for this driver.

> bindings/display/

Did you mean to use this location instead of "bindings/goldfish/"?

Kind regards,
Miodrag
________________________________________
From: Rob Herring [robh+dt@kernel.org]
Sent: Friday, June 30, 2017 1:12 AM
To: Aleksandar Markovic
Cc: Linux-MIPS; Aleksandar Markovic; Miodrag Dinic; Goran Ferenc; devicetree@vger.kernel.org; Douglas Leung; James Hogan; linux-kernel@vger.kernel.org; Mark Rutland; Paul Burton; Petar Jovanovic; Raghu Gandham
Subject: Re: [PATCH v2 06/10] Documentation: Add device tree binding for Goldfish FB driver

On Wed, Jun 28, 2017 at 10:46 AM, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
>
> Add documentation for DT binding of Goldfish FB driver. The compatible
> string used by OS for binding the driver is "google,goldfish-fb".
>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> ---
>  .../bindings/goldfish/google,goldfish-fb.txt           | 18 ++++++++++++++++++

bindings/display/

I don't know that this should even go upstream. There's no upstream
qemu support for goldfish-fb. Maybe this is a minor driver change, but
FB drivers are being replaced with DRM drivers. And the time for AOSP
supporting framebuffer drivers is limited I think with HWC2 and
explicit fence support in DRM.

Rob
