Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Feb 2017 00:50:57 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:43896 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993201AbdBKXuuQiORh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Feb 2017 00:50:50 +0100
Received: from [IPv6:2003:86:281e:5300:5498:ca6c:c620:70d5] (p20030086281E53005498CA6CC62070D5.dip0.t-ipconnect.de [IPv6:2003:86:281e:5300:5498:ca6c:c620:70d5])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 864CC10001D;
        Sun, 12 Feb 2017 00:50:48 +0100 (CET)
Subject: Re: [PATCH] MIPS: Lantiq: Fix cascaded IRQ setup
To:     James Hogan <james.hogan@imgtec.com>, Felix Fietkau <nbd@nbd.name>
References: <20170119112822.59445-1-nbd@nbd.name>
 <20170211231906.GI24226@jhogan-linux.le.imgtec.org>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, john@phrozen.org
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <073628a4-9c45-b3c3-6caa-c88bea138aa9@hauke-m.de>
Date:   Sun, 12 Feb 2017 00:50:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170211231906.GI24226@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 02/12/2017 12:19 AM, James Hogan wrote:
> Hi Felix,
> 
> On Thu, Jan 19, 2017 at 12:28:22PM +0100, Felix Fietkau wrote:
>> With the IRQ stack changes integrated, the XRX200 devices started
>> emitting a constant stream of kernel messages like this:
>>
>> [  565.415310] Spurious IRQ: CAUSE=0x1100c300
>>
>> This appears to be caused by IP0 firing for some reason without being
>> handled. Fix this by setting up IP2-6 as a proper chained IRQ handler and
>> calling do_IRQ for all MIPS CPU interrupts.
>>
>> Cc: john@phrozen.org
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> Is this still applicable after Matt's fix is applied?
> https://patchwork.linux-mips.org/patch/15110/

Hi,

I just tried it without Matt's and Felix's fix and I saw the problem,
then I applied Matt's fix and the problem was gone.

Hauke
