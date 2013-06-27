Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 12:41:00 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52031 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824769Ab3F0Kk7AT1yF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 12:40:59 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5RAeqpH003726;
        Thu, 27 Jun 2013 12:40:52 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5RAemHF003725;
        Thu, 27 Jun 2013 12:40:48 +0200
Date:   Thu, 27 Jun 2013 12:40:48 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     David Daney <ddaney.cavm@gmail.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] netdev: octeon_mgmt: Fix structure layout for
 little-endian.
Message-ID: <20130627104048.GR7171@linux-mips.org>
References: <1371688820-4585-1-git-send-email-ddaney.cavm@gmail.com>
 <1371688820-4585-3-git-send-email-ddaney.cavm@gmail.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B729B@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B729B@saturn3.aculab.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37165
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

On Thu, Jun 20, 2013 at 10:47:57AM +0100, David Laight wrote:

> > The C ABI reverses the bitfield fill order when compiled as
> > little-endian.
> 
> No - it is completely implementation defined.
> The general concensus is not to use bitfields if you
> care at all about the bit assignments.

FWIW, bitfields often alow things to be expressed more nicely.  Just the
endian-dependent definition suck, so I came up with this little hack
for arch/mips/include/uapi/asm/inst.h:

#ifdef __MIPSEB__
#define BITFIELD_FIELD(field, more)                                     \
        field;                                                          \
        more

#elif defined(__MIPSEL__)

#define BITFIELD_FIELD(field, more)                                     \
        more                                                            \
        field;
#endif

struct i_format {                       /* signed immediate format */
        BITFIELD_FIELD(unsigned int opcode : 6,
        BITFIELD_FIELD(unsigned int rs : 5,
        BITFIELD_FIELD(unsigned int rt : 5,
        BITFIELD_FIELD(signed int simmediate : 16,
        ;))))
};

  Ralf
