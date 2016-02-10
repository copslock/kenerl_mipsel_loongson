Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 10:20:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40164 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011045AbcBJJUfqC4q6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Feb 2016 10:20:35 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u1A9KXwQ010969;
        Wed, 10 Feb 2016 10:20:33 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u1A9KXhF010968;
        Wed, 10 Feb 2016 10:20:33 +0100
Date:   Wed, 10 Feb 2016 10:20:33 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, pgynther@google.com,
        paul.burton@imgtec.com, ddaney.cavm@gmail.com
Subject: Re: [PATCH 1/6] MIPS: BMIPS: Disable pref 30 for buggy CPUs
Message-ID: <20160210092033.GB10352@linux-mips.org>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
 <1455051354-6225-2-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455051354-6225-2-git-send-email-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51964
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

On Tue, Feb 09, 2016 at 12:55:49PM -0800, Florian Fainelli wrote:

> +static void bmips5000_pref30_quirk(void)
> +{
> +	__asm__ __volatile__(
> +	"	.word	0x4008b008\n"	/* mfc0 $8, $22, 8 */
> +	"	lui	$9, 0x0100\n"
> +	"	or	$8, $9\n"
> +	/* disable "pref 30" on buggy CPUs */
> +	"	lui	$9, 0x0800\n"
> +	"	or	$8, $9\n"
> +	"	.word	0x4088b008\n"	/* mtc0 $8, $22, 8 */
> +	: : : "$8", "$9");
> +}

Simpler:

#define read_c0_horse_with_no_name(val)  __read_32bit_c0_register($22, 8, val)
#define write_c0_horse_with_no_name(val) __write_32bit_c0_register($22, 8)

...

write_c0_horse_with_no_name(read_c0_horse_with_no_name() | 0x123);

And why do both MFC0 and MTC0 instructions above have the same opcode?
Also the selector number used above for both instructions is 8 - but the
architecture only allows for 8 selectors 0..7.

  Ralf
