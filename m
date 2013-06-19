Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 23:57:49 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:50512 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835045Ab3FSV5sGCx5T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jun 2013 23:57:48 +0200
Message-ID: <51C22901.7050709@imgtec.com>
Date:   Wed, 19 Jun 2013 16:56:17 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     Tony Wu <tung7970@gmail.com>, <ralf@linux-mips.org>,
        <macro@linux-mips.org>, <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v4 2/3] MIPS: microMIPS: Add kernel_uses_mmips in cpu-features.h
References: <20130527124421.GA32322@hades> <20130527124557.GB32322@hades> <51A36EE6.3040901@cogentembedded.com>
In-Reply-To: <51A36EE6.3040901@cogentembedded.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.150.195]
X-SEF-Processed: 7_3_0_01192__2013_06_19_22_57_42
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37029
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

On 05/27/2013 09:34 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 27-05-2013 16:45, Tony Wu wrote:
>
>> Add kernel_uses_mmips to denote whether CONFIG_CPU_MICROMIPS
>> is set or not. This variable can help cut down #ifdef usage.
>
>     You can avoid #ifdef usage with using IS_BUILTIN() macro, not
> defining extra macros.
>
>> Signed-off-by: Tony Wu <tung7970@gmail.com>
>> Cc: David Daney <david.daney@cavium.com>
>> Cc: Steven J. Hill <Steven.Hill@imgtec.com>
>
> WBR, Sergei
>
>
I think this patch is not needed with 
<http://patchwork.linux-mips.org/patch/5327/> being used instead?

-Steve
