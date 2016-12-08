Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2016 06:00:41 +0100 (CET)
Received: from che.mayfirst.org ([162.247.75.118]:53971 "EHLO che.mayfirst.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991976AbcLHFAehFkz2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Dec 2016 06:00:34 +0100
Received: from fifthhorseman.net (pool-98-117-85-199.rcmdva.fios.verizon.net [98.117.85.199])
        by che.mayfirst.org (Postfix) with ESMTPSA id 03B14F99A;
        Thu,  8 Dec 2016 00:00:31 -0500 (EST)
Received: by fifthhorseman.net (Postfix, from userid 1000)
        id CC6AF237EB; Wed,  7 Dec 2016 23:34:21 -0500 (EST)
From:   Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To:     Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Netdev <netdev@vger.kernel.org>, linux-mips@linux-mips.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
In-Reply-To: <095cac5b-b757-6f4a-e699-8eedf9ed7221@stressinduktion.org>
References: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com> <095cac5b-b757-6f4a-e699-8eedf9ed7221@stressinduktion.org>
Date:   Wed, 07 Dec 2016 23:34:21 -0500
Message-ID: <87vauvhwdu.fsf@alice.fifthhorseman.net>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <dkg@fifthhorseman.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkg@fifthhorseman.net
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

On Wed 2016-12-07 19:30:34 -0500, Hannes Frederic Sowa wrote:
> Your custom protocol should be designed in a way you get an aligned ip
> header. Most protocols of the IETF follow this mantra and it is always
> possible to e.g. pad options so you end up on aligned boundaries for the
> next header.

fwiw, i'm not convinced that "most protocols of the IETF follow this
mantra".  we've had multiple discussions in different protocol groups
about shaving or bloating by a few bytes here or there in different
protocols, and i don't think anyone has brought up memory alignment as
an argument in any of the discussions i've followed.

that said, it sure does sound like it would make things simpler to
construct the protocol that way :)

          --dkg
