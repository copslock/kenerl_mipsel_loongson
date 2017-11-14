Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 23:49:35 +0100 (CET)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:55172
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990901AbdKNWt1e7TM1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 23:49:27 +0100
Received: by mail-pf0-x241.google.com with SMTP id n89so15513542pfk.11
        for <linux-mips@linux-mips.org>; Tue, 14 Nov 2017 14:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=+Sm51rXotvFNcGdBCXa26PnG8Zi/t1k97C3RlBvZ4xc=;
        b=d388yoo62G4OtJlCn/e5o9qBDZ00CTUQvqZRvGdD6ZXLKRyjrBEs8iTDhSfrFGi55X
         5Ki+osUOEmVRCGAdiPoRRS9DkbL8c6pD7lzF+7MuLjU+rRpCCpWGqFk5XjbofE+shizJ
         Q5vP011M2fizLKG/QW6FMVza+a7tGM3M1dP8rnxVIRzHZG+Ph3rugbrNAJREBBxzxwU/
         xku9aA7WpjfYFqzRytEND2BvfwnfNiPEmuDMaRTVG71TTuRxLasHLGIPCFL+wUTyP8Hb
         OQqc/Q2Lyh50r7vlDR+YXLtKhjrVRaBYN3IFmgkUS8e15tT9jxgDxYIfDBw+fE/onhOB
         m3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=+Sm51rXotvFNcGdBCXa26PnG8Zi/t1k97C3RlBvZ4xc=;
        b=Qy0PvSnwI7WFC1z6AH5XTCjpGVkxC1HHIo8mRUU+FAOspE8XR6oFsZ3xpSYn/p+4EY
         uDPO37PSWpZc8OdzjJXdVL1Os03wC05VksoClfxKjAWj0ZCy3TwcwS0A85cASI/A5aQz
         iZmOQguTjbj0ykhvhxv14vLpWod0/8B9+0227azH4xEQMD95XNga4AI9yLLvpcs/Z/E0
         Vzls+CoTnqIT2E5zPS5eMulrDlEGNBP5J4ljPx1WW88OQvrRPhsL0jJBCrEt+G1IPBAy
         A7+eLnMLh47NTFNhnRytmkTIcKdpc1iKlnZBOU8ysP1r7Mp6NmOYkJSM7ucNQ3gtgqSH
         39kg==
X-Gm-Message-State: AJaThX7l4m6gWb1Yg4cwJX2vKtEj6wkoEqVuR+kMsVerYqoHh8Fl4XS5
        GU6fUyXvNNvdZbm9/5+F3hTing==
X-Google-Smtp-Source: AGs4zMa/IjvgTe5behsbJasGRFi9DfC783CxblfUL6Ls43nENByebH52JmH8WaQ+S84VoHicDb/log==
X-Received: by 10.159.206.198 with SMTP id x6mr13751960plo.35.1510699760767;
        Tue, 14 Nov 2017 14:49:20 -0800 (PST)
Received: from xeon-e3 (76-14-207-240.or.wavecable.com. [76.14.207.240])
        by smtp.gmail.com with ESMTPSA id r80sm41091149pfa.169.2017.11.14.14.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Nov 2017 14:49:20 -0800 (PST)
Date:   Tue, 14 Nov 2017 14:49:17 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     James Hogan <james.hogan@mips.com>
Cc:     Dave Taht <dave.taht@gmail.com>, <netdev@vger.kernel.org>,
        <linux-next@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [net-next,1/3] netem: convert to qdisc_watchdog_schedule_ns
Message-ID: <20171114144917.66f0047c@xeon-e3>
In-Reply-To: <20171114211112.GA28794@jhogan-linux.mipstec.com>
References: <1510088376-5527-2-git-send-email-dave.taht@gmail.com>
        <20171114211112.GA28794@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.mqhecnEQbKr_PrIAjZI4vC"; protocol="application/pgp-signature"
Return-Path: <stephen@networkplumber.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stephen@networkplumber.org
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

--Sig_/.mqhecnEQbKr_PrIAjZI4vC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Nov 2017 21:11:13 +0000
James Hogan <james.hogan@mips.com> wrote:

> On Tue, Nov 07, 2017 at 12:59:34PM -0800, Dave Taht wrote:
> > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > index db0228a..443a75d 100644
> > --- a/net/sched/sch_netem.c
> > +++ b/net/sched/sch_netem.c =20
>=20
> ...
>=20
> > @@ -305,11 +305,11 @@ static bool loss_event(struct netem_sched_data *q)
> >   * std deviation sigma.  Uses table lookup to approximate the desired
> >   * distribution, and a uniformly-distributed pseudo-random source.
> >   */
> > -static psched_tdiff_t tabledist(psched_tdiff_t mu, psched_tdiff_t sigm=
a,
> > -				struct crndstate *state,
> > -				const struct disttable *dist)
> > +static s64 tabledist(s64 mu, s64 sigma, =20
>=20
> sigma is used in a modulo operation in this function, which results in
> this error on a bunch of MIPS configs once it is made 64-bits wide:
>=20
> net/sched/sch_netem.o In function `tabledist':
> net/sched/sch_netem.c:330: undefined reference to `__moddi3'
>=20
> Should that code not be using <linux/math64.h>, i.e. div_s64_rem() now
> that it is 64bit?
>=20
> Thanks
> James

Not really since random is only 32 bit, the sigma value being 64 bit makes
no sense really.

--Sig_/.mqhecnEQbKr_PrIAjZI4vC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn2/DRbBb5+dmuDyPgKd/YJXN5H4FAloLcu0ACgkQgKd/YJXN
5H6Gew/6A/eZ8FnXQLRCZzlYMeJqz3Bl4b0C4HuUYsEZhSZMyu+TTIJyjhpk4tau
D+VkwNtaOc0J6GmKbvWkb20n08RjN1xAZuNWxL+ohjdLE9SrvMIPzrs+PFiqow8d
ApL8cOsZFnbuha/ncPyXELf5z8xbDPWIJLM0dh07esNy93ZVMKq6slqjAScinJwE
/3iW3Ad5XYuC0PxpeodwtswDVxnXhy5zZqZDz26kxQ93eWk1+8biO6vLOTEKuk3J
jZ0l2r2Lc3npDYO7V6uE/ZRRlyTHULuF28KnrWCKUDuv1FkH2ITNoFeu90BuTT3y
wzMbqp3e3Z9A0fN6etffh6qPN8gmV3KwiIhzeYd6t6CMwQLH6XVDOxp2W8mic4UK
UsItxhRDSTv2mRV/PnJmfF6V27MO47XpnD48X0H0iWyxaBmmwgewrpuOlkXlDHxa
IHxdRfGaglS2U/jxus34T24zFJpyvt6+fjohpMrwq+LW78OLZJm/Y8nzMQ/T1yem
Y7JD+E20evAjRiZB9hk5RgfqtLfwNf4vXgh8vK72e5CVZIKUCQpZV51bx7ZC9Ob4
teBfuyJ4s4iv+4uvXG/PeYYxHDgC0WPVuo7+Gxz+/76ghQvL7F4VY97YlhQCGiat
EEEfDHtrDrAJJQ/NMUUCsD9T8cSAHr41YdSGbBqKwpEzSEZunos=
=oJr8
-----END PGP SIGNATURE-----

--Sig_/.mqhecnEQbKr_PrIAjZI4vC--
