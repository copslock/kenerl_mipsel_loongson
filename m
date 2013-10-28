Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Oct 2013 15:37:30 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:35037 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823034Ab3J1Oh1IIZ2X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Oct 2013 15:37:27 +0100
Message-ID: <526E7673.6050308@imgtec.com>
Date:   Mon, 28 Oct 2013 14:36:35 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     Florian Fainelli <f.fainelli@gmail.com>,
        <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, <blogic@openwrt.org>,
        <Leonid.Yegoshin@imgtec.com>, <jim2101024@gmail.com>
Subject: Re: [PATCH mips-for-linux-next] MIPS: fix genex.S build for non MIPS32r2
 class processors
References: <1382725617-32561-1-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1382725617-32561-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_28_14_37_20
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38393
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

On 25/10/2013 07:26 μμ, Florian Fainelli wrote:
> Commit d712357d ("MIPS: Print correct PC in trace dump after NMI
> exception") introduced assembly code which uses the "ehb" instruction,
> which is only available in MIPS32r2 class processors and causes such
> build errors on MIPS32r1 processors:
>
>    AS      arch/mips/kernel/genex.o
> arch/mips/kernel/genex.S: Assembler messages:
> arch/mips/kernel/genex.S:386: Error: opcode not supported on this
> processor: mips32 (mips32) `ehb'
> make[2]: *** [arch/mips/kernel/genex.o] Error 1
> make[1]: *** [arch/mips/kernel] Error 2
> make[1]: *** Waiting for unfinished jobs....
>
> Use _ehb which properly substitutes to a nop or a real ehb depending on
> the processor we are building for.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Yep that looks good to me. Thanks for fixing it

Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>

-- 
markos
