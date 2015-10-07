Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2015 13:23:28 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.24]:50942 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009919AbbJGLX0qM9eF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Oct 2015 13:23:26 +0200
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPSA (Nemesis) id 0M2XRt-1aZQ3w2M21-00sNke; Wed, 07 Oct
 2015 13:23:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] drm/virtio: use %llu format string form atomic64_t
Date:   Wed, 07 Oct 2015 13:23:07 +0200
Message-ID: <5152101.mD2bWzUJ2V@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <6260324.3MlUEc3veg@wuerfel>
References: <5082760.FgB9zHNfte@wuerfel> <20151007104502.GH21513@n2100.arm.linux.org.uk> <6260324.3MlUEc3veg@wuerfel>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:AvyxDNPc1XGjgHit0OIRcVA+9jaWzKKYL5XY6a0ISzJCcgCBcIE
 QyJZLuQH56JNu4fO586WOQxclbW2cfNi47o47a2zOh7Za/u5F77MOwNKj6LcYFIkdfGqFGM
 XlsDV3ooawdvW4XQ8LoAQoZRy1dzrKC37oDqJw3qIiVkGj2FctN6fKebs8JaEZoV3J/w4rE
 2bVqZmLMdO/7sOdmiBP5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b2XksF2t8ag=:BpRm8eXRaKAvDr1BRm4cYg
 Li3pgWjddslKpXREs70RxAUY8jrgK83pp2UKs9fCuIVVCcDxoebUo6ovqOH+GBDwRTYDN6yVP
 xhVsBEwxBgxO3ihrgLn3vluKB6AtujwRAJwU73kC0YgT9mqD1TD8keLoIX49qkCk9R/XAJr7h
 Oh2zNNYaPRDKsqUwRq/vQi38dwmKZNN5N8WdcEXrYFe8S+LXih0WshYAw07az9gtrhQMuSV8+
 L/xRs42FOyqLbIcwVjuKDxyod2UuQb4GHzV965fB7I0CeG4Yc4EBqAhffkYiqCOvzYT/PdagP
 drFlRHI5fiYNhJgk4Xpch3iVe8ervkAcWpOEtBMBJlFCcDI0HM+xin/DRoJrMZORP0LvdX6oA
 mEkGpK3Dw7EJ+5aSO2wQQMm//igXV4KMu310WG/Umym2dfb42eWu4oCX/LYXn8TjrfMZF/g+o
 8RkbYQvbvAu+oBnhOJNm1xYeuqY5dMekYiECaPD1OiNg5co+7QFaYa07t7v2Qcd6OX/m0/O06
 GCBLxQnc3vf4bdHfANRNE9nY71h+RHoXuoI6Xm+zUNoxkDmSwXepSDwFGywvwBs8ivBfF0Tjg
 Ni7KbzDIyhAuUrAFbTNXu2U1qMauZwyLpd7BJo+/txKrjCWPgz/7xtEu2oAnBlaf9TsCYJ0Ms
 xkAOLqOpx6Epq+ff209ldQSHXbF2pvCS1WJ77Uf+rdr2zKM4ujWLS56qr0Sag3oPi7ERSVrua
 caqWLOytY3q39EvI
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49468
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

On Wednesday 07 October 2015 13:04:06 Arnd Bergmann wrote:
> On Wednesday 07 October 2015 11:45:02 Russell King - ARM Linux wrote:
> > On Wed, Oct 07, 2015 at 12:41:21PM +0200, Arnd Bergmann wrote:
> > > The virtgpu driver prints the last_seq variable using the %ld or
> > > %lu format string, which does not work correctly on all architectures
> > > and causes this compiler warning on ARM:
> > > 
> > > drivers/gpu/drm/virtio/virtgpu_fence.c: In function 'virtio_timeline_value_str':
> > > drivers/gpu/drm/virtio/virtgpu_fence.c:64:22: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat=]
> > >   snprintf(str, size, "%lu", atomic64_read(&fence->drv->last_seq));
> > >                       ^
> > > drivers/gpu/drm/virtio/virtgpu_debugfs.c: In function 'virtio_gpu_debugfs_irq_info':
> > > drivers/gpu/drm/virtio/virtgpu_debugfs.c:37:16: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'long long int' [-Wformat=]
> > >   seq_printf(m, "fence %ld %lld\n",
> > >                 ^
> > > 
> > > In order to avoid the warnings, this changes the format strings to %llu
> > > and adds a cast to u64, which makes it work the same way everywhere.
> > 
> > You have to wonder why atomic64_* functions do not use u64 types.
> > If they're not reliant on manipulating 64-bit quantities, then what's
> > the point of calling them atomic _64_.
> 
> I haven't checked all architectures, but I assume what happens is that
> 64-bit ones just #define atomic64_t atomic_long_t, so they don't have
> to provide three sets of functions.

scratch that, I just looked at all the architectures and found that it's
just completely arbitrary, even within one architecture you get a mix
of 'long' and 'long long', plus this gem from MIPS:

static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)

which truncates the result to 32 bit.

	Arnd
