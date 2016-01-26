Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 15:36:31 +0100 (CET)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33929 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011595AbcAZOgX1xpvA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 15:36:23 +0100
Received: by mail-pa0-f51.google.com with SMTP id uo6so100461001pac.1;
        Tue, 26 Jan 2016 06:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pkRiLBfI1oW5E69AtVihXygCnI+d9RsshSDPEoYtZ84=;
        b=u2mvezApAjq6x7EBtjYT9t0AITkAsVXucgIpyXCMkAczNiDSf6b5z3LT6Tv9QRotr9
         1b8W5l0h6v2Hd16doBqaGzgEBZKQ8ym0RlGJUlXzPRWe2AqnQFWn7XW+U7hc8dWEGNX8
         bhYU5SKoxOvokH2Cw0hMFJ+yO9IBbVZJA+lVJCC/0SH2i1U9F9vY9UVas9LcjFBat2Xo
         Mi9uFP3//q7WCldSY6wJf7D838itYpAdPO501cEjRJIjkPhG5XTcXzRHynI07LFKcQD3
         H/y8cwrYcwvzdN67f2nDjOaxmrLIH3yQ17/F5WPoaTlqyskYAGhitzpBQ5GnYnhhINyC
         9Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pkRiLBfI1oW5E69AtVihXygCnI+d9RsshSDPEoYtZ84=;
        b=hc/wv3FCBUsuvrOe3YUw3oHXWcRyYBPWA2wX7dKgiQ2dsbBV7ZM1WC29Q/ZfcgJL6x
         xkLe9jKPMnFxtSUnbpL2K8bkSiZHLeBxgsXGDSCDmJmFHqJCtTnadtFgvUkCT6ue5ooV
         YpoJO/tTzp0mkT4F7lLvoSQ3HrBOdEByt2BFnjtFvxYYZ9Ml94+Rr51rfut06iKEl5qt
         Okb4DkUx57/4KF6q+t0cawgnZbmgCq5HgG1gdValRVFMn6U6o0CUrO2/r4I/YS+9zsEN
         /XiiBPnNRtebrvb7WH07XJNaie3BIcpP3WGbnEbULyVTt1zPTBby7t8YNNOcngyXK/fr
         y87A==
X-Gm-Message-State: AG10YOQX1GWhOv0pDyAhh9hJ4O31goDmLGrlXaFbps/CvPF+DYVFPeC2IP84yLyUDjFWrw==
X-Received: by 10.66.141.109 with SMTP id rn13mr33686657pab.83.1453818977293;
        Tue, 26 Jan 2016 06:36:17 -0800 (PST)
Received: from localhost ([45.32.128.109])
        by smtp.gmail.com with ESMTPSA id xr8sm2344819pab.26.2016.01.26.06.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 06:36:15 -0800 (PST)
Date:   Tue, 26 Jan 2016 22:35:33 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com,
        james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160126143533.GA6029@fixme-laptop.cn.ibm.com>
References: <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <20160115085554.GF3421@worktop>
 <20160115091348.GA27936@worktop>
 <20160115174612.GV3818@linux.vnet.ibm.com>
 <20160115212714.GM3421@worktop>
 <20160115215853.GC3818@linux.vnet.ibm.com>
 <20160125164242.GF22927@arm.com>
 <20160126060322.GJ4503@linux.vnet.ibm.com>
 <20160126121608.GE21553@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20160126121608.GE21553@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <boqun.feng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boqun.feng@gmail.com
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


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Tue, Jan 26, 2016 at 12:16:09PM +0000, Will Deacon wrote:
> On Mon, Jan 25, 2016 at 10:03:22PM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 25, 2016 at 04:42:43PM +0000, Will Deacon wrote:
> > > On Fri, Jan 15, 2016 at 01:58:53PM -0800, Paul E. McKenney wrote:
> > > > PPC Overlapping Group-B sets version 4
> > > > ""
> > > > (* When the Group-B sets from two different barriers involve instru=
ctions in
> > > >    the same thread, within that thread one set must contain the oth=
er.
> > > >=20
> > > > 	P0	P1	P2
> > > > 	Rx=3D1	Wy=3D1	Wz=3D2
> > > > 	dep.	lwsync	lwsync
> > > > 	Ry=3D0	Wz=3D1	Wx=3D1
> > > > 	Rz=3D1
> > > >=20
> > > > 	assert(!(z=3D2))
> > > >=20
> > > >    Forbidden by ppcmem, allowed by herd.
> > > > *)
> > > > {
> > > > 0:r1=3Dx; 0:r2=3Dy; 0:r3=3Dz;
> > > > 1:r1=3Dx; 1:r2=3Dy; 1:r3=3Dz; 1:r4=3D1;
> > > > 2:r1=3Dx; 2:r2=3Dy; 2:r3=3Dz; 2:r4=3D1; 2:r5=3D2;
> > > > }
> > > >  P0		| P1		| P2		;
> > > >  lwz r6,0(r1)	| stw r4,0(r2)	| stw r5,0(r3)	;
> > > >  xor r7,r6,r6	| lwsync	| lwsync	;
> > > >  lwzx r7,r7,r2	| stw r4,0(r3)	| stw r4,0(r1)	;
> > > >  lwz r8,0(r3)	|		|		;
> > > >=20
> > > > exists
> > > > (z=3D2 /\ 0:r6=3D1 /\ 0:r7=3D0 /\ 0:r8=3D1)
> > >=20
> > > That really hurts. Assuming that the "assert(!(z=3D2))" is actually t=
here
> > > to constrain the coherence order of z to be {0->1->2}, then I think t=
hat
> > > this test is forbidden on arm using dmb instead of lwsync. That said,=
 I
> > > also don't think the Rz=3D1 in P0 changes anything.
> >=20
> > What about the smp_wmb() variant of dmb that orders only stores?
>=20
> Tricky, but I think it still works out if the coherence order of z is as
> I described above. The line of reasoning is weird though -- I ended up
> considering the two cases where P0 reads z before and after it reads x
                                             ^^^^^^^^^^^^^^^
Because of the fact that two reads on the same processors can't be
executed simultaneously? I feel like this is exactly something herd
missed.

> and what that means for the read of y.
>=20

And the reasoning on PPC is similar, so looks like the read of z on P0
is a necessary condition for the exists clause to be forbidden.

Regards,
Boqun

> Will

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWp4QwAAoJEEl56MO1B/q4Mm4H/0dwzlkmQS4v9KE2bwXuATC4
SH2oyc2VGgjaT9rdPY3B52Kbcqteftm7Zej4rmBFJWSh4qMKBPI+AiT00VxEecPq
FgZgZIyoQMLFeF7t8aogtY4rwkN/zhRt0vC7WdbBGP5ZC9HNxlwILuR9PwRrQysl
NjhdpzH1ufk/vRvDGYF5ILw5KllvPWGOoStBn+j8AYDCDHj0xIy2BBbNWQraBas5
jUlo1Qdm3BDCcZ6Yq52Gl/DICkIp6Qe/snmxPlASwoLTbozz1T7nhCQaN0GlWKeM
WioHqMWD7L1RxbdNp8z0wsTOLCIeNY/+weP2r+mKCnsBivVSvocqmcQP+s4W4k4=
=AQzQ
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
