Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2016 15:09:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47578 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991986AbcIUNIyVZAwA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Sep 2016 15:08:54 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8LD8rVB015238;
        Wed, 21 Sep 2016 15:08:53 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8LD8qee015237;
        Wed, 21 Sep 2016 15:08:52 +0200
Date:   Wed, 21 Sep 2016 15:08:52 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/9] MIPS: traps: 64bit kernels should read CP0_EBase
 64bit
Message-ID: <20160921130852.GA10899@linux-mips.org>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
 <e826225b15736539cd96a1b6b2a99e2bb2b4eb87.1472747205.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e826225b15736539cd96a1b6b2a99e2bb2b4eb87.1472747205.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Sep 01, 2016 at 05:30:07PM +0100, James Hogan wrote:

> When reading the CP0_EBase register containing the WG (write gate) bit,
> the ebase variable should be set to the full value of the register, i.e.
> on a 64-bit kernel the full 64-bit width of the register via
> read_cp0_ebase_64(), and on a 32-bit kernel the full 32-bit width
> including bits 31:30 which may be writeable.

How about changing the definition of read/write_c0_ebase to

#define read_c0_ebase()         __read_ulong_c0_register($15, 1)
#define write_c0_ebase(val)     __write_ulong_c0_register($15, 1, val)

or using a new variant like

#define read_c0_ebase_ulong()         __read_ulong_c0_register($15, 1)
#define write_c0_ebase_ulong(val)     __write_ulong_c0_register($15, 1, val)

to avoid the ifdefery?  This could also make this bit

                ebase = cpu_has_mips64r6 ? read_c0_ebase_64()
                                         : (s32)read_c0_ebase();

in cpu-probe.c prettier.

  Ralf
