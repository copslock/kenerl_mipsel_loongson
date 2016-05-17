Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 10:09:49 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:60594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27029532AbcEQIJq6XDKB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 May 2016 10:09:46 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3749728;
        Tue, 17 May 2016 01:09:57 -0700 (PDT)
Received: from [10.1.209.129] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155CB3F21A;
        Tue, 17 May 2016 01:09:38 -0700 (PDT)
Subject: Re: [PATCH 04/11] irqchip: irq-pic32-evic: Fix bug with external
 interrupts.
To:     Purna Chandra Mandal <purna.mandal@microchip.com>,
        linux-kernel@vger.kernel.org
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
 <1463461560-9629-4-git-send-email-purna.mandal@microchip.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Joshua Henderson <digitalpeer@digitalpeer.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <573AD1C1.6050002@arm.com>
Date:   Tue, 17 May 2016 09:09:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
MIME-Version: 1.0
In-Reply-To: <1463461560-9629-4-git-send-email-purna.mandal@microchip.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On 17/05/16 06:05, Purna Chandra Mandal wrote:
> From: Joshua Henderson <digitalpeer@digitalpeer.com>
> 
> The wrong external interrupt bits are being set, offset by 1.
> 
> Signed-off-by: Joshua Henderson <digitalpeer@digitalpeer.com>
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

I'll queue that for post -rc1.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
