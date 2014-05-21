Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 15:35:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51558 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6843069AbaEUNfiz-2eR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 May 2014 15:35:38 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4LDYMXB024846;
        Wed, 21 May 2014 15:34:22 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4LDY7g4024845;
        Wed, 21 May 2014 15:34:07 +0200
Date:   Wed, 21 May 2014 15:34:07 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, David Daney <ddaney.cavm@gmail.com>,
        James Hogan <james.hogan@imgtec.com>, kvm@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 11/15] MIPS: paravirt: Add pci controller for virtio
Message-ID: <20140521133407.GS10287@linux-mips.org>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-12-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400597236-11352-12-git-send-email-andreas.herrmann@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40219
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

On Tue, May 20, 2014 at 04:47:12PM +0200, Andreas Herrmann wrote:

> +
> +union pci_config_address {
> +	struct {
> +#ifdef __LITTLE_ENDIAN
> +		unsigned	register_number	: 8;		/* 7  .. 0  */
> +		unsigned	devfn_number	: 8;		/* 15 .. 8  */
> +		unsigned	bus_number	: 8;		/* 23 .. 16 */
> +		unsigned	reserved	: 7;		/* 30 .. 24 */
> +		unsigned	enable_bit	: 1;		/* 31       */
> +#else
> +		unsigned	enable_bit	: 1;		/* 31       */
> +		unsigned	reserved	: 7;		/* 30 .. 24 */
> +		unsigned	bus_number	: 8;		/* 23 .. 16 */
> +		unsigned	devfn_number	: 8;		/* 15 .. 8  */
> +		unsigned	register_number	: 8;		/* 7  .. 0  */
> +#endif

For this kind of endianess dependency there is a more elegant way of
defining things in linux-next's <uapi/asm/bitfield.h> like:

#include <uapi/asm/bitfield.h>
...

struct {
	__BITFIELD_FIELD(unsigned	enable_bit	: 1,		/* 31       */
	__BITFIELD_FIELD(unsigned	reserved	: 7,		/* 30 .. 24 */
	__BITFIELD_FIELD(unsigned	bus_number	: 8,		/* 23 .. 16 */
	__BITFIELD_FIELD(unsigned	devfn_number	: 8,		/* 15 .. 8  */
	__BITFIELD_FIELD(unsigned	register_number	: 8,		/* 7  .. 0  */
	)))));
};

No ifdef, no duplication!

  Ralf
