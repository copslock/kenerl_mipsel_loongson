Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 10:22:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40669 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011540AbaJ2JWCFe93B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 10:22:02 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 73E932C4511BF;
        Wed, 29 Oct 2014 09:21:52 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 29 Oct 2014 09:21:53 +0000
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 29 Oct
 2014 09:21:53 +0000
Message-ID: <5450B1B1.5070301@imgtec.com>
Date:   Wed, 29 Oct 2014 09:21:53 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.8.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>
CC:     John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        <linux-mips@linux-mips.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 2/4] of: Add binding document for MIPS GIC
References: <1414541562-10076-1-git-send-email-abrestic@chromium.org> <1414541562-10076-3-git-send-email-abrestic@chromium.org>
In-Reply-To: <1414541562-10076-3-git-send-email-abrestic@chromium.org>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi Andrew,

On 29/10/14 00:12, Andrew Bresticker wrote:
>  - changed compatible string to include CPU version

> +Required properties:
> +- compatible : Should be "mti,<cpu>-gic".  Supported variants:
> +  - "mti,interaptiv-gic"

> +Required properties for timer sub-node:
> +- compatible : Should be "mti,<cpu>-gic-timer".  Supported variants:
> +  - "mti,interaptiv-gic-timer"

Erm, I'm a bit confused...
Why do you include the core name in the compatible string?

You seem to be suggesting that:

1) The GIC/timer drivers need to know what core they're running on.

Is that really true?

2) It isn't possible to probe the core type.

But the kernel already knows this, so what's wrong with using
current_cpu_type() like everything else that needs to know?

3) Every new core should require a new compatible string to be added
before the GIC will work. You don't even have a generic compatible
string that DT can specify after the core specific one as a fallback.

Please lets not do this unless it's actually necessary (which AFAICT it
really isn't).

Thanks
James
