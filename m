Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Dec 2016 17:44:28 +0100 (CET)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:26535 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990601AbcLKQoVxfarf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Dec 2016 17:44:21 +0100
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id uBBGiD6q005097;
        Sun, 11 Dec 2016 17:44:13 +0100
Date:   Sun, 11 Dec 2016 17:44:13 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-mips@linux-mips.org, Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan =?iso-8859-1?Q?L=FCdtke?= <mail@danrl.com>,
        =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Felix Fietkau <nbd@nbd.name>, Jiri Benc <jbenc@redhat.com>,
        David Miller <davem@davemloft.net>
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
Message-ID: <20161211164413.GA5090@1wt.eu>
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
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

On Sun, Dec 11, 2016 at 03:50:31PM +0100, Jason A. Donenfeld wrote:
> 3. Add 3 bytes of padding, set to zero, to the encrypted section just
> before the IP header, marked for future use.
> Pros: satisfies IETF mantras, can use those extra bits in the future
> for interesting protocol extensions for authenticated peers.
> Cons: lowers MTU, marginally more difficult to implement but still
> probably just one or two lines of code.
> 
> Of these, I'm leaning toward (3).

Or 4) add one byte to the cleartext header for future use (mostly flags
maybe) and 2 bytes of padding to the encrypted header. This way you get
the following benefits :
  1) your encrypted text is at least 16-bit aligned, maybe it matters
     in your checksum computations on during decryption
  2) your MTU remains even, this is better for both ends
  3) you're free to add some bits either to the encrypted or the clear
     parts.

Just a suggestion :-)

Willy
