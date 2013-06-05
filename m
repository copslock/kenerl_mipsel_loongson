Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 23:36:42 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:39422 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835054Ab3FEVghLsyml (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Jun 2013 23:36:37 +0200
Message-ID: <51AFAF5C.3020109@imgtec.com>
Date:   Wed, 5 Jun 2013 16:36:28 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Jonas Gorski <jogo@openwrt.org>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v6] MIPS: micromips: Fix improper definition of ISA exception
 bit.
References: <1370461798-20296-1-git-send-email-Steven.Hill@imgtec.com> <51AFA540.5010207@gmail.com> <51AFAA8C.6080002@imgtec.com> <CAOiHx=mFqC=GN0jmb9PXpt+JapfWoP3Pu5NM0sp=F_uAZuwUEA@mail.gmail.com>
In-Reply-To: <CAOiHx=mFqC=GN0jmb9PXpt+JapfWoP3Pu5NM0sp=F_uAZuwUEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.150.82]
X-SEF-Processed: 7_3_0_01192__2013_06_05_22_36_31
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 06/05/2013 04:23 PM, Jonas Gorski wrote:
>
> 	if (cpu_has_mmips) {
> 		unsigned int config3 = read_c0_config3();
>
> 		if (IS_ENABLED(CONFIG_CPU_MICROMIPS))
> 			write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
> 		else
> 			write_c0_config3(config3 & ~MIPS_CONF3_ISA_OE);
> 	}
>
>
I like this being in 'trap_init' instead. Any objections?
