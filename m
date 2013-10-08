Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 14:21:06 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:20637 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832655Ab3JHMU6LYxgZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 14:20:58 +0200
Message-ID: <5253F8B3.3070700@imgtec.com>
Date:   Tue, 8 Oct 2013 13:21:07 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     <thomas.langer@lantiq.com>, <linux-mips@linux-mips.org>
CC:     <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH] MIPS: Print correct PC in trace dump after NMI exception
References: <1381232371-25017-1-git-send-email-markos.chandras@imgtec.com> <593AEF6C47F46446852B067021A273D6D990182F@MUCSE039.lantiq.com>
In-Reply-To: <593AEF6C47F46446852B067021A273D6D990182F@MUCSE039.lantiq.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_08_13_20_49
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38266
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

On 10/08/13 12:48, thomas.langer@lantiq.com wrote:
> Hello Markos,
>
> If this is a YAMON specific fix, why is it done in a common file?
>
Hi Thomas,

I can see how the commit message can be a bit misleading. However, it's 
not YAMON specific. The NMI was just delivered by YAMON because we patch 
the default NMI location in YAMON (see mti-malta/malta-init.c).
NMI, Reset and Cache Error exceptions use ErrorEPC instead of EPC so 
this patch is platform independent.
