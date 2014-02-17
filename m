Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2014 14:22:04 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:19760 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6869247AbaBQNWC2ee5L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Feb 2014 14:22:02 +0100
Message-ID: <53020D12.6060000@imgtec.com>
Date:   Mon, 17 Feb 2014 13:22:26 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        David Daney <ddaney.cavm@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: [PATCH] samples/seccomp/Makefile: Do not build tests if cross-compiling
 for MIPS
References: <1392312460-24902-1-git-send-email-markos.chandras@imgtec.com> <52FD0F46.6040503@gmail.com> <CAP=VYLr1D-DQz8U4naa5aEL_AFa_JkO5e+TgFSxpsd_2t3dahQ@mail.gmail.com>
In-Reply-To: <CAP=VYLr1D-DQz8U4naa5aEL_AFa_JkO5e+TgFSxpsd_2t3dahQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_02_17_13_21_55
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 02/14/2014 01:33 AM, Paul Gortmaker wrote:
> On Thu, Feb 13, 2014 at 1:30 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>> Really I think we should add a Kconfig item for this and disable the whole
>> directory for targets that do not support it.
>
> Can we do something based on  CONFIG_CROSS_COMPILE vs. adding more Kconfig?
>
> Paul.
> --

Hi Paul,

I am not sure how this would solve anything. CONFIG_CROSS_COMPILE could 
be empty, but you can still use 'make CROSS_COMPILE=mips-linux-foobar-' 
or whatever to cross-compile for MIPS. So using this symbol to disable 
tests does not seem right to me.

Another Kconfig symbol should be more appropriate but as far as I can 
see MIPS is the only architecture which has this problem (or I may have 
missed all{yes,mod}config failures from other architectures).

I still think that an "ifndef CONFIG_MIPS" is good enough for now until 
more architectures suffer from this problem in the future. So far (and 
looking at the git history of that file) other architectures managed to 
workaround this.

-- 
markos
