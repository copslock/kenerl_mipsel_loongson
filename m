Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Apr 2014 00:34:36 +0200 (CEST)
Received: from mail-we0-f175.google.com ([74.125.82.175]:56771 "EHLO
        mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815989AbaDYWeeW6OCi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Apr 2014 00:34:34 +0200
Received: by mail-we0-f175.google.com with SMTP id q58so4141733wes.20
        for <linux-mips@linux-mips.org>; Fri, 25 Apr 2014 15:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :organization:user-agent:in-reply-to:references:mime-version
         :content-type;
        bh=0ZwIIIkC1FivtYYJ8eiLsslSNgcPMDfCF2jyo63Bqcs=;
        b=Kr07PCKjucyBE9ycge7wSOwuQWy6z/1IFlT3g2+sud56kPkKeg0G1PGiGaOy9vjrF0
         KgWDlgbmxFdFbj56av0qfQIyiNOPYfUHz3VTgCI4PzihZpC0b8UQCxsoU8i0xlCCxVSm
         W6WYXYkYG7/FsxHE6Wz21L1KyOTTITlcNAAOQfgUjd+fBcM9d3AUS00Ow1SHa3lbsJ2U
         QXGeY9mWGlIfCpMJGkgw6mDaNeuOJdvT1x8CYn+Cfr2TM2ykK5UKpiVgF+m6HxgAsCAP
         kG7ZYg8k9Di7qynFr0vfGImUmb4qUI+FLEp3PJrGE1x8ATLKLopbcaSUMYI6lHp/vEws
         P0WA==
X-Gm-Message-State: ALoCoQlbQqNG0j71vpjMkZbSpeLA6yJKh19gNxjO4pVUGLvmy+pYv151lXGZOHbOdVC+X7+dpJxz
X-Received: by 10.194.109.6 with SMTP id ho6mr8763317wjb.21.1398465268405;
        Fri, 25 Apr 2014 15:34:28 -0700 (PDT)
Received: from radagast.localnet (jahogan.plus.com. [212.159.75.221])
        by mx.google.com with ESMTPSA id q9sm3563851wjo.3.2014.04.25.15.34.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 15:34:27 -0700 (PDT)
From:   James Hogan <james.hogan@imgtec.com>
To:     David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 14/21] MIPS: KVM: Add nanosecond count bias KVM register
Date:   Fri, 25 Apr 2014 23:34:19 +0100
Message-ID: <2197488.6tnytXFBJm@radagast>
Organization: Imagination Technologies
User-Agent: KMail/4.11.5 (Linux/3.14.0+; KDE/4.11.5; x86_64; ; )
In-Reply-To: <535A9AF5.30105@gmail.com>
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com> <1398439204-26171-15-git-send-email-james.hogan@imgtec.com> <535A9AF5.30105@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2636900.1DA1dIIsSg"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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


--nextPart2636900.1DA1dIIsSg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi David,

On Friday 25 April 2014 10:27:17 David Daney wrote:
> On 04/25/2014 08:19 AM, James Hogan wrote:
> > Expose the KVM guest CP0_Count bias (from the monotonic kernel time) to
> > userland in nanosecond units via a new KVM_REG_MIPS_COUNT_BIAS register
> > accessible with the KVM_{GET,SET}_ONE_REG ioctls. This gives userland
> > control of the bias so that it can exactly match its own monotonic time.
> > 
> > The nanosecond bias is stored separately from the raw bias used
> > internally (since nanoseconds isn't a convenient or efficient unit for
> > various timer calculations), and is recalculated each time the raw count
> > bias is altered. The raw count bias used in CP0_Count determination is
> > recalculated when the nanosecond bias is altered via the KVM_SET_ONE_REG
> > ioctl.
> 
> Is this really necessary?

That's a good question...

> 
> The architecture has CP0_COUNT.  How does the concept of this noew
> synthetic bias value interact with the architecture's CP0_COUNT?

It's a single bias state under the hood for a running timer.

Setting the user_bias effectively results in a guest count of:
CP0_Count = (ktime_to_ns(ktime_get()) + user_bias) * count_hz / 1e9

Under the hood it's actually converted user_bias to a 32-bit bias that 
simplifies the calculations since it wraps more conveniently in places:
CP0_Count = bias + ktime_to_ns(ktime_get()) * count_hz / 1e9

Similarly setting the guest CP0_Count to count results in the bias (and 
user_bias) being recalculated such that CP0_Count at that moment = count:
CP0_Count = count
(substitute CP0_Count)
bias + ktime_to_ns(ktime_get()) * count_hz / 1e9 = count
(rearrange)
bias = count - ktime_to_ns(ktime_get()) * count_hz / 1e9

> 
> It seems like by adding this you new have two ways to access and
> manipulate the same thing.
> 
> 1) The architecturally specified CP0_COUNT.
> 2) This new bias thing.

Almost, but not quite. Full control of the timer value without the new bias is 
a bit more complicated than just writing CP0_COUNT...

> 
> What if we just let userspace directly manipulate the CP0_COUNT, and if
> necessary only maintain a bias as an internal implementation detail?

The difference is in the ability for userland to recalculate the CP0_Count at 
any moment for a running timer (e.g. taking advantage of the fact that I 
believe qemu's qemu_get_clock_ns(rt_clock) = ktime_to_ns(ktime_get()).

Setting the Count directly while the timer is running, the ktime_get() part 
cannot be precisely known to userland.

Since I added the COUNT_CTL.DC & COUNT_RESUME registers it can be partly 
controlled, but only because the timer can be frozen/snapshotted. Userland 
could set COUNT_CTL.DC=1, read COUNT_RESUME to get the time when the timer was 
frozen, then set the Count to the desired value at COUNT_RESUME (which would 
take effect as if the write happened at COUNT_RESUME nanoseconds) and set 
COUNT_CTL.DC=0 to unfreeze the timer. It could then calculate/know the bias 
itself, knowing the CP0_Count at a particular time (COUNT_RESUME) with a 
particular frequency (COUNT_HZ).
Arguably it's simpler (and probably faster) to just write the COUNT_BIAS 
register with a newly calculated or altered bias.

These are I believe the strengths of each related interface:
(1) The master DC provides atomic access to both CP0_Count and CP0_Cause (both 
CP0_Cause.DC and CP0_Cause.TI) which isn't provided by other interfaces.
(2) The COUNT_RESUME in combination with the master DC provides atomic access 
to the current monotonic time and CP0_Count (provided implicitly by (4)), but 
also atomic control of the CP0_Cause at the same time (not provided by other 
interfaces).
(3) Access to the plain CP0_Count provides straightforward access to the 
CP0_Count of a running or more importantly stopped timer.
(4) Access to the bias provides exact control of the value of the timer 
relative to monotonic time while the timer is running (provided implicitly by 
(2)), without having to freeze it (not provided elsewhere).

So yes, you could technically manage without (4) by using (2) ((4) was 
implemented first), but I think it probably still has some value since you can 
do it with a single ioctl rather than 4 ioctls (freeze timer, read 
resume_time, read or write count, unfreeze timer).

Enough value to be worthwhile? I haven't really made up my mind yet but I'm 
leaning towards yes.

Do you have any further thoughts on that?

Thanks
James
--nextPart2636900.1DA1dIIsSg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTWuLxAAoJEGwLaZPeOHZ6JDIP/2/zt4gLFtMebrt9HPxFxP6/
0bwGVGwWAVzoLjVLdcpjL0dwk7LPpEk1Jq2nFfmyn/rDuMS9DF4rk9LPFbHSBU8M
qKcPDZA5ad/9h1l/P/dFPlUE69ZFDjXO/PEOq4rut/TD5N6L2sDHcdTGyRx8625r
xU/CvFZmB8CkcDrxEXadxtAMkyyKvCP8Tp3caqjfvr3yceKEIsEOFIjjFVsNhNBr
PsewVnT3IDpdVDIJsnfkbqqqKIoyYUKSowCn15Q5q2ZQ3QfxpX71EoHPGDyX3Wyw
9XOPCZ9xCY3HmENIrS2P0pwp7wXJHpHFb7xZqA7LCQDKliSRAhSORvED/CKHeYSs
ijcsI9+iJ6YD0VWGbqbtqFEDX+vTwg4zs/Ex0/WNmfh3mPJ26O2I4tFe+kWl4Ni2
SCBeNF3cFRUquMmi8W0biWjFTFp5OmTGQA55QJHo27aJ2lkZDXCWWUADDNYZuiM1
RUWPpIx1NwvlmTv7yt4vV4FofRKXKRtd5xV/Xpt5SEENdun8hJ0eDu0avy4zehYo
7jVD1aA4OnUnkkyNpThFbL16whzjjloNj8/T18iH1Nge6Y4Sck0lctrfARU6iMjT
qkwn9PwfOA1CJ/sHIjv4DujhVAC6QuHgtdBgML2UToDmjVPbG01Icto8wollDYjm
fPIoaBoQC7Zy5jzdnQHu
=y3ja
-----END PGP SIGNATURE-----

--nextPart2636900.1DA1dIIsSg--
