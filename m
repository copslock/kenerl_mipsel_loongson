Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Oct 2015 12:07:45 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.13]:54638 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009878AbbJSKHnkwTr9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Oct 2015 12:07:43 +0200
Received: from wuerfel.localnet ([134.3.118.24]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0MSa4i-1Zvmq134tQ-00RchU; Mon, 19 Oct
 2015 12:07:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>, Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH] drm/virtio: use %llu format string form atomic64_t
Date:   Mon, 19 Oct 2015 12:06:56 +0200
Message-ID: <7382069.z44JKC1I1I@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <20151019093700.GC2092@linux-mips.org>
References: <5082760.FgB9zHNfte@wuerfel> <5152101.mD2bWzUJ2V@wuerfel> <20151019093700.GC2092@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:RE4Y9XTFHw+iAt0lV17iTd+UIwVgaE39cbmbC+/IoK/Jl47DKLw
 7IIz5jBHk3zG5B4tUeELvQ1a0wdR2SBM8qH6j6Q4oSZoL99ml2XHoaltB7cja2wCh0+24r5
 KKpwzZDyb7piknKjGsKXSbu4Qx1mRrCMwS+zNXp0yMWmIHbMvhoh3NhUip9bg0VgYNIwbdM
 FLnXlUVgjGUXoNFKaPV1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OvjuPdydvm8=:8QGGJu1mdyJIty68yCYP/P
 bz1PsdatjyrVj1l7IaGSEYVDxj8JEKef4UmsQSYbuvsfsj5Cj+l4NLNv2k6gnuRQ0KqlTcQxv
 BBrtlNqIMRSPXAcUlwtsnS9vuk1ZBK2WIW/LP/Worps6YNpZMBD9jzVPGk1rUbfzWqXwwpFeN
 02x8NJ012dJR1MPJcLLtYpJN5X2TEn0+JMJKdLZq69K6l73v2awg3QAtQc7XBwXiD0lA2WrLh
 i+AeGjXwm3Z4b59ZeLfwg9ZAmJHXxM1TroaRUpjucBXo31sR6qMOf+wRabBWzZP0mMwDt2uY+
 NMw9sOGI6Qid1plxgLEfV/CcZgvXbuJm6O1K01jkUvEmGhLGQKP4nKb7cezLjq/8E04h2IYWf
 tyHfY9nTfbYKxbucJxofT0qHiwJyalVUlgvCra32YW5474dLw7syeeBWDe62VfUGADOfrLKG7
 yh+7cZx+dA3vk4BKKtX9qIs6+MF4m0Q8xnej1fJ/MyP/kTqFZJhpzKcf9YtCdwXiE8IVjL8Z7
 u+MFDv2+Uc82RwUKBLz4ScvYC37SplROq6sLmE04JGrkNwhEMZ2viZfXDBcja4is3FU09pvNf
 vIF6BQuExVhGYPzXmQ1diZ4Yv9NOeL/S3ircwO57Y3g8vGCNeYRo/P4aYPTLfx1qy/dMUAlZj
 MzGgGQUo6mOrOoXk4SPVVlUnvYsSliWK9FuAOab5CESPbiVw5MPWJjr841X5inkvBYeUiemJx
 f7W3p3OftxTuAsQw
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Monday 19 October 2015 11:37:00 Ralf Baechle wrote:
> On Wed, Oct 07, 2015 at 01:23:07PM +0200, Arnd Bergmann wrote:
> 
> > > I haven't checked all architectures, but I assume what happens is that
> > > 64-bit ones just #define atomic64_t atomic_long_t, so they don't have
> > > to provide three sets of functions.
> > 
> > scratch that, I just looked at all the architectures and found that it's
> > just completely arbitrary, even within one architecture you get a mix
> > of 'long' and 'long long', plus this gem from MIPS:
> > 
> > static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> > 
> > which truncates the result to 32 bit.
> 
> Eh...  The result is 0/1 so nothing is truncated.  Alpha, MIPS,
> PARISC and PowerPC are using the same prototype and x86 only differs
> in the use of inline instead __inline__.  And anyway, that function on
> MIPS is only built for CONFIG_64BIT.

Ah, got it. Sorry about that.

> What's wrong on MIPS is the comment describing the function's return value
> which was changed by f24219b4e90cf70ec4a211b17fbabc725a0ddf3c (atomic: move
> atomic_add_unless to generic code) and I've queued up a patch to fix that
> since a few days.  I guess that was a cut and paste error from
> __atomic_add_unless which indeed does return the old value.

Thanks!

	Arnd
