Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 20:12:28 +0200 (CEST)
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45525 "EHLO
        na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903534Ab2HUSMU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 20:12:20 +0200
Received: from mail-lb0-f174.google.com ([209.85.217.174]) (using TLSv1) by na3sys009aob107.postini.com ([74.125.148.12]) with SMTP
        ID DSNKUDPPgU1uIf0BA/nQNGKqCbhIQoQUBqls@postini.com; Tue, 21 Aug 2012 11:12:19 PDT
Received: by lbbgj3 with SMTP id gj3so168643lbb.33
        for <linux-mips@linux-mips.org>; Tue, 21 Aug 2012 11:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=tpa++kbEBaBsIXnZomNnQ1CKR0WDJgVdNsOjMBV+Zrc=;
        b=NKtUKpyIowLwdvAZdNQnwC9SV07n6ucP/2w+aQHI+82e4S6YY67AJQ3raLsK+1tHQx
         xmLxuh/Fd5VtK4nrI49PgvI6cM5Jfyy+ghLaCyQi8L/Y/DSvtv0hwptJkVbib/465znE
         AZRfJ/39k/WsF0Xp4KYWkl6soihs/Ixxzo9BuWYV0cHdnPBLNrs/d9Vc+cHpIGRBROGI
         1g8JaaqGWHsLG8HnPCI4LP/LA5dckFAgPMmDEQF8/2c+nBJTbNwFQeMKQdyMbsPhiFKA
         S1uwrjKLA5IzC5hn1HfFDOKaLC8m6HeSjSkosDfH+uqliknLghJBDp17sZOC3TxBrerm
         IMSg==
Received: by 10.112.25.4 with SMTP id y4mr8118488lbf.61.1345572736310;
        Tue, 21 Aug 2012 11:12:16 -0700 (PDT)
Received: from localhost (cs78217178.pp.htv.fi. [62.78.217.178])
        by mx.google.com with ESMTPS id mq9sm2149314lab.0.2012.08.21.11.12.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 11:12:15 -0700 (PDT)
Date:   Tue, 21 Aug 2012 21:08:19 +0300
From:   Felipe Balbi <balbi@ti.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     balbi@ti.com, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: bcm63xx UDC driver
Message-ID: <20120821180818.GC20360@arwen.pp.htv.fi>
Reply-To: balbi@ti.com
References: <97cb21b8063a02a9664baf8b749ae200@localhost>
 <20120820074041.GH17455@arwen.pp.htv.fi>
 <CAJiQ=7CB2w=aNwtU4f3di6c31tD-EWO9YLejESY5HsUaHY6s1A@mail.gmail.com>
 <20120821120418.GE10347@arwen.pp.htv.fi>
 <CAJiQ=7BQz18s03du_Q33z45W+QrkVaPqgZSuUTU-x9v=48CGbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <CAJiQ=7BQz18s03du_Q33z45W+QrkVaPqgZSuUTU-x9v=48CGbA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnuT2wP+DzkDEukc8DC1ynQwErtZa3JWi2NvbzVVFCzU89FfErb8/8FCrB4csoD9SIaO+0z
X-archive-position: 34307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: balbi@ti.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2012 at 08:20:43AM -0700, Kevin Cernekee wrote:
> On Tue, Aug 21, 2012 at 5:04 AM, Felipe Balbi <balbi@ti.com> wrote:
> > On Mon, Aug 20, 2012 at 08:48:11PM -0700, Kevin Cernekee wrote:
> >> On Mon, Aug 20, 2012 at 12:40 AM, Felipe Balbi <balbi@ti.com> wrote:
> >> > no workqueues, please either handle the IRQ here or use threaded_irq=
s.
> >> >
> >> > again, no workqueues.
> >>
> >> Felipe,
> >>
> >> I am seeing all sorts of deadlocks now, after removing the workqueue
> >> (patch V2).  Some have easy fixes, but for others it is not as
> >> obvious.  The code was much simpler when I could just trigger a
> >> deferred worker function.
> >>
> >> Workqueues are used in at91_udc, lpc32xx_udc, mv_udc_core, and
> >> pch_udc.  Could you please clarify why it is not OK to use one in
> >> bcm63xx_udc?
> >
> > Because threaded_irqs were added in order to drop such workqueues.
> > threaded_irqs also have the highest priority possible (only lower than
> > hardirq handlers), so you'll get scheduled much sooner.
> >
> > Could it be that most of your deadlocks is because you're not setting
> > IRQF_ONESHOT ?
>=20
> The deadlocks involve ep0 processing that is triggered through
> bcm63xx_udc_queue().  e.g. gadget driver queues a new request, it's a
> reply to a spoofed SET_CONFIGURATION / SET_INTERFACE transaction, and
> the UDC driver calls the completion immediately.
>=20
> So, not all of the ep0 work is being done in response to an IRQ from
> the controller HW, and I think that is where this driver diverges from
> most of the others.
>=20
> Would it be OK to use a workqueue, or maybe a tasklet, given these
> circumstances?

Then stick to a workqueue... but could you let me know why exactly you
have to fake SET_CONFIGURATION/SET_INTERFACE requests ? Is this a
silicon bug or a silicon feature ? That's quite weird to me.

--=20
balbi

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM86SAAoJEIaOsuA1yqREvkYP/RYCdBoa2+q7rE679k9wTmOC
zRSoowWiiQAjmYL7tFlMNXskedsEYO5utl/yjuXu0LiDLp6nQdJ6KwMBwpayTrli
ZLmoTirV4i7slO7qfcWpb4Fkfn+mb9BBGeG6rFGX5PqGCK3EqpdIoLaqY3NMq6DG
AJAoIamI+3qmFXQ4zpAQF1J+p/ewcsioxMGMiHH/xjp+HRc2gunJvQtPMGlJ+gWI
rJmb1WRj0gHSMQBZctWxyr7LPrmmmwvXy7VtFEHdaG3GNvdAoQI5PhWEqK76N3Fr
YMPx/LFJKjiWUAB6NUnR7Tgt5a/lAQxW2Vytf7YPAiOiYs7BWLq/GlQqSFKE+BJo
5B6ZBkLgBQgWNiM3CYCTNRKcNRSZRMZNlN7iQtlNHU5+uo4IPyrkj55VlwfnkGG3
qIq11kXz6dgXf5qz1G97pf9JkHXeWF75Bv23ll0yhRx29n4J88VnWJt7HYsBlEHI
36y0yr0XPAZny0lUL98e/Ey4YJwoTA5bbYvo4PLB9VVLkW8ehGhCvRRBMCD+lQnB
05nC2KDRWL5zmRDnhhun3xTI2d1kBJBOBkox9QtSCJdm1mYEf+pR6O61vxK65KbN
Gns/Ov/ydP5GLHc/YD9ysIQOiY5/gWseAMtw73MNd8GbtFqd9pnYP0YB1SdtIR+R
8/9oR827jLWPiy5E8X2H
=V1Ht
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
