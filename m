Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Feb 2017 12:05:20 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:131:30e2::2]:38193 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990511AbdBLLFNDX0HD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Feb 2017 12:05:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name; s=20160729;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=LlfJnjyl9qGaq5+81a5VIXx3QkEr9D9n8NMXrJ+Ctvw=;
        b=DqJXcsrghmimooQ+K3RWVLUdqPLGWQRV/mu07XwTZkbay05MKMvsc+3bnBHlYODmVmqb8Y2ozweIjLQcxCBmpdbRMjBQmTiMuH/yBViwpAOVSze9dSlrVHdzvh1g8N2MMkg/zf5aTJ1tsh8H1x2W1oi33mvfH3lV01+Hp0gw9Bk=;
Subject: Re: [PATCH] MIPS: Lantiq: Fix cascaded IRQ setup
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        James Hogan <james.hogan@imgtec.com>
References: <20170119112822.59445-1-nbd@nbd.name>
 <20170211231906.GI24226@jhogan-linux.le.imgtec.org>
 <073628a4-9c45-b3c3-6caa-c88bea138aa9@hauke-m.de>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, john@phrozen.org
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <54159608-3adb-071b-9555-f48e2fb3dd22@nbd.name>
Date:   Sun, 12 Feb 2017 12:05:08 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <073628a4-9c45-b3c3-6caa-c88bea138aa9@hauke-m.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@nbd.name
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

On 2017-02-12 00:50, Hauke Mehrtens wrote:
> On 02/12/2017 12:19 AM, James Hogan wrote:
>> Hi Felix,
>> 
>> On Thu, Jan 19, 2017 at 12:28:22PM +0100, Felix Fietkau wrote:
>>> With the IRQ stack changes integrated, the XRX200 devices started
>>> emitting a constant stream of kernel messages like this:
>>>
>>> [  565.415310] Spurious IRQ: CAUSE=0x1100c300
>>>
>>> This appears to be caused by IP0 firing for some reason without being
>>> handled. Fix this by setting up IP2-6 as a proper chained IRQ handler and
>>> calling do_IRQ for all MIPS CPU interrupts.
>>>
>>> Cc: john@phrozen.org
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> 
>> Is this still applicable after Matt's fix is applied?
>> https://patchwork.linux-mips.org/patch/15110/
> 
> Hi,
> 
> I just tried it without Matt's and Felix's fix and I saw the problem,
> then I applied Matt's fix and the problem was gone.
I still think it should be applied, since it replaces some hacks with
cleaner code.

- Felix
