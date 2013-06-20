Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 18:29:12 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:1827 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823001Ab3FTQ3LGUvJ0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Jun 2013 18:29:11 +0200
Message-ID: <51C32DCC.5020100@imgtec.com>
Date:   Thu, 20 Jun 2013 11:29:00 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Tony Wu <tung7970@gmail.com>
CC:     <macro@linux-mips.org>, <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v5 2/2] MIPS: microMIPS: Refactor get_frame_info support
References: <20130620133230.GA84495@hades> <20130620133504.GB84495@hades>
In-Reply-To: <20130620133504.GB84495@hades>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.150.172]
X-SEF-Processed: 7_3_0_01192__2013_06_20_17_29_04
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37067
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

On 06/20/2013 08:35 AM, Tony Wu wrote:
> Current get_frame_info implementation works on word boundary, this
> can lead to alignment and endian issues in microMIPS mode,
> due to:
>
[...]
>
> Signed-off-by: Tony Wu <tung7970@gmail.com>
> Cc: Maciej W. Rozycki <macro@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Steven J. Hill <Steven.Hill@imgtec.com>
>
Acked-by: Steven J. Hill <Steven.Hill@imgte.com>
