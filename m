Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Dec 2016 16:30:45 +0100 (CET)
Received: from vps0.lunn.ch ([178.209.37.122]:42525 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990601AbcLKPajPK4ub (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Dec 2016 16:30:39 +0100
Received: from andrew by vps0.lunn.ch with local (Exim 4.80)
        (envelope-from <andrew@lunn.ch>)
        id 1cG655-0004QY-TV; Sun, 11 Dec 2016 16:30:27 +0100
Date:   Sun, 11 Dec 2016 16:30:27 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-mips@linux-mips.org, Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan =?iso-8859-1?Q?L=FCdtke?= <mail@danrl.com>,
        Willy Tarreau <w@1wt.eu>,
        =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Felix Fietkau <nbd@nbd.name>, Jiri Benc <jbenc@redhat.com>,
        David Miller <davem@davemloft.net>
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
Message-ID: <20161211153027.GD29761@lunn.ch>
References: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
 <095cac5b-b757-6f4a-e699-8eedf9ed7221@stressinduktion.org>
 <87vauvhwdu.fsf@alice.fifthhorseman.net>
 <CE942916-BF45-44CC-A5F5-3838CF9C93BC@danrl.com>
 <20161211071501.GA32621@kroah.com>
 <CAHmME9q5ifwwishXjXYE3J=sVeR4jYY9fLUgs_FHCP594EZr6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9q5ifwwishXjXYE3J=sVeR4jYY9fLUgs_FHCP594EZr6g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56002
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

> 3. Add 3 bytes of padding, set to zero, to the encrypted section just
> before the IP header, marked for future use.
> Pros: satisfies IETF mantras, can use those extra bits in the future
> for interesting protocol extensions for authenticated peers.
> Cons: lowers MTU, marginally more difficult to implement but still
> probably just one or two lines of code.

I'm not a crypto expert, but does this not give you a helping hand in
breaking the crypto? You know the plain text value of these bytes, and
where they are in the encrypted text.

      Andrew
