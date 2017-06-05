Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 20:55:38 +0200 (CEST)
Received: from vps0.lunn.ch ([178.209.37.122]:55956 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992213AbdFESzYdvV07 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Jun 2017 20:55:24 +0200
Received: from andrew by vps0.lunn.ch with local (Exim 4.80)
        (envelope-from <andrew@lunn.ch>)
        id 1dHx9p-00025h-Nn; Mon, 05 Jun 2017 20:55:17 +0200
Date:   Mon, 5 Jun 2017 20:55:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        linux-mips@linux-mips.org, Eric Dumazet <edumazet@google.com>,
        Jarod Wilson <jarod@redhat.com>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v4 2/7] net: pch_gbe: Pull PHY GPIO handling out of
 Minnow code
Message-ID: <20170605185517.GF5235@lunn.ch>
References: <20170602234042.22782-1-paul.burton@imgtec.com>
 <20170605173136.10795-1-paul.burton@imgtec.com>
 <20170605173136.10795-3-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605173136.10795-3-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew@lunn.ch
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

On Mon, Jun 05, 2017 at 10:31:31AM -0700, Paul Burton wrote:
> The MIPS Boston development board uses the Intel EG20T Platform
> Controller Hub, including its gigabit ethernet controller, and requires
> that its RTL8211E PHY be reset much like the Minnow platform. Pull the
> PHY reset GPIO handling out of Minnow-specific code such that it can be
> shared by later patches.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
