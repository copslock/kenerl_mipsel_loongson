Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2015 11:07:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9206 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011855AbbH0JHPoCr85 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Aug 2015 11:07:15 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 78C5C40DEF748;
        Thu, 27 Aug 2015 10:07:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 27 Aug 2015 10:07:09 +0100
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 27 Aug
 2015 10:07:08 +0100
Subject: Re: [PATCH 00/10] Add support for img AXD audio hardware decoder
To:     Mark Brown <broonie@kernel.org>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <20150826180436.GC28760@sirena.org.uk>
CC:     <alsa-devel@alsa-project.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jason Cooper" <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
From:   Qais Yousef <qais.yousef@imgtec.com>
Message-ID: <55DED33C.50007@imgtec.com>
Date:   Thu, 27 Aug 2015 10:07:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20150826180436.GC28760@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

On 08/26/2015 07:04 PM, Mark Brown wrote:
> On Mon, Aug 24, 2015 at 01:39:09PM +0100, Qais Yousef wrote:
>
>> Qais Yousef (10):
>>    irqchip: irq-mips-gic: export gic_send_ipi
>>    dt: add img,axd.txt device tree binding document
>>    ALSA: add AXD Audio Processing IP alsa driver
>>    ALSA: axd: add fw binary header manipulation files
>>    ALSA: axd: add buffers manipulation files
>>    ALSA: axd: add basic files for sending/receiving axd cmds
>>    ALSA: axd: add cmd interface helper functions
>>    ALSA: axd: add low level AXD platform setup files
>>    ALSA: axd: add alsa compress offload operations
>>    ALSA: axd: add Makefile
> Please try to use subject lines matching the style for the subsystem, I
> very nearly deleted this unread because it looks like an ALSA patch
> series, not an ASoC one.

OK sorry about that. I'll fix this in the next series.

Thanks,
Qais
