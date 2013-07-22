Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jul 2013 16:50:58 +0200 (CEST)
Received: from comal.ext.ti.com ([198.47.26.152]:35984 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824768Ab3GVOuwhcE8Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Jul 2013 16:50:52 +0200
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id r6MEo4xM027754;
        Mon, 22 Jul 2013 09:50:04 -0500
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id r6MEo4Ft028910;
        Mon, 22 Jul 2013 09:50:04 -0500
Received: from dlelxv22.itg.ti.com (172.17.1.197) by DLEE71.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server id 14.2.342.3; Mon, 22 Jul 2013
 09:50:04 -0500
Received: from [158.218.103.117] (ula0393909.am.dhcp.ti.com [158.218.103.117])
        by dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id r6MEo2Ql022892;    Mon, 22
 Jul 2013 09:50:02 -0500
Message-ID: <51ED469A.9000801@ti.com>
Date:   Mon, 22 Jul 2013 10:50:02 -0400
From:   Santosh Shilimkar <santosh.shilimkar@ti.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Grant Likely <grant.likely@linaro.org>
CC:     Rob Herring <robherring2@gmail.com>,
        Rob Herring <rob.herring@calxeda.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, <x86@kernel.org>,
        <arm@kernel.org>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-c6x-dev@linux-c6x.org>, <linux-mips@linux-mips.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-xtensa@linux-xtensa.org>,
        <devicetree-discuss@lists.ozlabs.org>
Subject: Re: [PATCH v2] of: Specify initrd location using 64-bit
References: <1372702835-5333-1-git-send-email-santosh.shilimkar@ti.com> <51D1F5E2.6070609@gmail.com> <20130720053945.C7AC63E0C52@localhost>
In-Reply-To: <20130720053945.C7AC63E0C52@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <santosh.shilimkar@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: santosh.shilimkar@ti.com
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

On Saturday 20 July 2013 01:39 AM, Grant Likely wrote:
> On Mon, 01 Jul 2013 16:34:26 -0500, Rob Herring <robherring2@gmail.com> wrote:
>> On 07/01/2013 01:20 PM, Santosh Shilimkar wrote:
>>> On some PAE architectures, the entire range of physical memory could reside
>>> outside the 32-bit limit.  These systems need the ability to specify the
>>> initrd location using 64-bit numbers.
>>>
>>> This patch globally modifies the early_init_dt_setup_initrd_arch() function to
>>> use 64-bit numbers instead of the current unsigned long.
>>>
>>> There has been quite a bit of debate about whether to use u64 or phys_addr_t.
>>> It was concluded to stick to u64 to be consistent with rest of the device
>>> tree code. As summarized by Geert, "The address to load the initrd is decided
>>> by the bootloader/user and set at that point later in time. The dtb should not
>>> be tied to the kernel you are booting"
>>
>> That was quoting me. Otherwise:
>>
>> Acked-by: Rob Herring <rob.herring@calxeda.com>
>>
>> Unless Grant feels compelled to pick this up for 3.11, I think it has to
>> wait for 3.12.
> 
> Nope, 3.12 is fine. Applied.
> 
Thanks Grant.

Regards,
Santosh
