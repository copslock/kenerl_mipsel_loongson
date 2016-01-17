Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jan 2016 15:48:40 +0100 (CET)
Received: from mout.gmx.net ([212.227.15.18]:52344 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009313AbcAQOsixg-WT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 17 Jan 2016 15:48:38 +0100
Received: from [192.168.123.49] ([37.24.8.189]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MWTfu-1ae6qt2tuU-00XdVO; Sun, 17 Jan 2016 15:48:29
 +0100
Subject: =?UTF-8?Q?Re:_cannot_build_Linux_4.4:_arch/mips/kernel/signal.c:142?=
 =?UTF-8?Q?:12:_error:_=e2=80=98struct_ucontext=e2=80=99_has_no_member_named?=
 =?UTF-8?B?IOKAmHVjX2V4dGNvbnRleHTigJk=?=
To:     lkml <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
References: <569B9CFE.1090007@gmx.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Enigmail-Draft-Status: N1110
Message-ID: <569BA9BB.3080508@gmx.de>
Date:   Sun, 17 Jan 2016 15:48:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
MIME-Version: 1.0
In-Reply-To: <569B9CFE.1090007@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:AsbQCnI/VJwSFG/yBaaBiCsENOPUDpai7dh2M5iuaj5jrXmZGGf
 QcQ9AMJ6H4f8SeXjuQLNFELTKHJS1E9OalVCsGrBge00N9otoEHJk0pm7eTQSaNLgAhu3gW
 UR+wa9rW6QznAIEZP5WQvquHGzcDZ8ResNmXFGAPDxfMI/QJfOQKvWLV7yr6NIGSyWiVuvQ
 XslPKTXCIwcnPs0twm2zA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tlgXaf6Stkw=:96Q2EJ19X5xB/zEiHW3Rda
 jVgfvrlydYhMwpumVyOoMNxTpMOj15qbSzpPBz4y0oeCm9+OBu3TfzvFWeUxs6j7alKLXpMBD
 JJB2RfhzsoEF2w+OcCrl8i8igIUwkA68ch0NzExFCGfQCU/N90hwLZGg5rotLWXyJVVOzsyxi
 5YOCWhmME9Qiqnm7NeQMZzXSyu3rG4vIck7qTDVJ/+hvZE7oweUVOOSTCFQl41dPGWN8N3JJ8
 CBir1H2Kk7E7NVrTJCxvdCsbsl6erzG63fNLmZsjUFr0TUvLkZB5aQGmGvO2/QFIncvZPq2rg
 bNxjO3YlFXo4v7VV7fhMbkBfcuYOdg49rlQ4UA07Q61GvGxt1cDwKbLDJfKmSaZun4t3fyD53
 IBPA1bQLV1RGu9PUcaWe6jPYpOQymUPSeTlxGNjt9+APC6LtiXdfe15ykQkcOO8vb/pKdAMk2
 4XK8hNfsZt+Lk0fw2rheVif3NSDZOMilFWs60E88xpH+wRznt9ncaOCt28RykFZ+zgGzAuCx1
 Ht8nX8yB7afSiOTUqnjlCoqU11orZZ5+MoKRowibjt107jOQf+d4V2EZnmLtnmbELXEXQAS0g
 fBpkT8ooWst+jSZorCQDhx5XAYCwJqwv7P7WDfop6Fv7VITptH4A9d7R2L8vxghmqmIKhQiqC
 gLtz5lN7cNia+Ft8iz06YY3THUGMjPy4+/b8q7ZFPTHgK/kOP33431fnzSfFpnAgoCc7uBuLY
 lrqZYUaYuNaFcrNohXNkUEQs7RthkhIBTsFBMe8UI8GyGtnwuBB06myPT31KeXx4cj+/yMGeL
 btSjiVc
Return-Path: <xypron.glpk@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xypron.glpk@gmx.de
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

On 01/17/2016 02:54 PM, Heinrich Schuchardt wrote:
> 
> HEAD is now at afd2ff9... Linux 4.4
> arch/mips/kernel/signal.c: In function ‘sc_to_extcontext’:
> arch/mips/kernel/signal.c:142:12: error: ‘struct ucontext’ has no member
> named ‘uc_extcontext’
>   return &uc->uc_extcontext;
>             ^
> In file included from include/linux/poll.h:11:0,
>                  from include/linux/ring_buffer.h:7,
>                  from include/linux/trace_events.h:5,
>                  from include/trace/syscall.h:6,
>                  from include/linux/syscalls.h:81,
>                  from arch/mips/kernel/signal.c:26:
> arch/mips/kernel/signal.c: In function ‘save_msa_extcontext’:
> arch/mips/kernel/signal.c:170:40: error: dereferencing pointer to
> incomplete type
> 

The problem stemmed from make not recognizing that this file was outdated:

Oct 16  2014 arch/mips/include/generated/asm/ucontext.h

Shouldn't make automatically regenerate outdated files?

Best regards

Heinrich Schuchardt
