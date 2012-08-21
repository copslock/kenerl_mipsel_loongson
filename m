Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 14:08:28 +0200 (CEST)
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53440 "EHLO
        na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903526Ab2HUMIU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 14:08:20 +0200
Received: from mail-lb0-f177.google.com ([209.85.217.177]) (using TLSv1) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
        ID DSNKUDN6Mdbqi8CRw4Z77a3MLumPh5PQD5Yb@postini.com; Tue, 21 Aug 2012 05:08:19 PDT
Received: by lbbgf7 with SMTP id gf7so4833936lbb.22
        for <linux-mips@linux-mips.org>; Tue, 21 Aug 2012 05:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=eCfMxlg5rqHhyd6bTPEikUahtGrRRQTZAiz63jJTZfM=;
        b=YPgmYDXzq4uGdJ5D2JUZM0XFhzR2IhG4s+ih7G/wS1cLq3jz8RGE3/EdAAP/qrA+fU
         bZha4ltVkFkLrEybH/K/ERdMT3TacDohmqZSQ7egoD+zMs/G5XyOeIiHXebkknRPvOZW
         Bpu0PANmpjl/kwvuD08i76IZZEfQJekNcOkneqAV5cEGLxTaj7agI3bMdEoyvudXrw/I
         8FdHbZgCEDZrVUSd57Q5Y7ByWOdrIQDJzznV2pAmWX23ff2PpT9+BpEwG27z/6jCqBhi
         phA3dc9DEEHvM6gXBtCx+JDhlRQbSIFHCyRFu4WZ6O98ez3fjFwon11vh3erCF96wYBo
         mz7g==
Received: by 10.152.104.44 with SMTP id gb12mr17592991lab.29.1345550895924;
        Tue, 21 Aug 2012 05:08:15 -0700 (PDT)
Received: from localhost (cs78217178.pp.htv.fi. [62.78.217.178])
        by mx.google.com with ESMTPS id d1sm346941lbk.16.2012.08.21.05.08.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 05:08:14 -0700 (PDT)
Date:   Tue, 21 Aug 2012 15:04:19 +0300
From:   Felipe Balbi <balbi@ti.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     balbi@ti.com, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: bcm63xx UDC driver
Message-ID: <20120821120418.GE10347@arwen.pp.htv.fi>
Reply-To: balbi@ti.com
References: <97cb21b8063a02a9664baf8b749ae200@localhost>
 <20120820074041.GH17455@arwen.pp.htv.fi>
 <CAJiQ=7CB2w=aNwtU4f3di6c31tD-EWO9YLejESY5HsUaHY6s1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WeoCK3UN7lwjrlbw"
Content-Disposition: inline
In-Reply-To: <CAJiQ=7CB2w=aNwtU4f3di6c31tD-EWO9YLejESY5HsUaHY6s1A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQn7RiGhcB17ll+4hOA+chEEelUctZee++VBy2G2GOj04BM/+jqfj2a2wbAPg7X8kz1Hg87T
X-archive-position: 34300
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


--WeoCK3UN7lwjrlbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2012 at 08:48:11PM -0700, Kevin Cernekee wrote:
> On Mon, Aug 20, 2012 at 12:40 AM, Felipe Balbi <balbi@ti.com> wrote:
> > no workqueues, please either handle the IRQ here or use threaded_irqs.
> >
> > again, no workqueues.
>=20
> Felipe,
>=20
> I am seeing all sorts of deadlocks now, after removing the workqueue
> (patch V2).  Some have easy fixes, but for others it is not as
> obvious.  The code was much simpler when I could just trigger a
> deferred worker function.
>=20
> Workqueues are used in at91_udc, lpc32xx_udc, mv_udc_core, and
> pch_udc.  Could you please clarify why it is not OK to use one in
> bcm63xx_udc?

Because threaded_irqs were added in order to drop such workqueues.
threaded_irqs also have the highest priority possible (only lower than
hardirq handlers), so you'll get scheduled much sooner.

Could it be that most of your deadlocks is because you're not setting
IRQF_ONESHOT ?

--=20
balbi

--WeoCK3UN7lwjrlbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM3lCAAoJEIaOsuA1yqRE9/sP/jylW+NGj8OW+Xd7tvCQrmrg
FCq361fOmVO7VttgZ4YWbvSL+PBHwRR4gQLpl8FrD+Peh1KdQ6ePw0wmKQ+4UZ1i
BPVd7A7uerLVqMLydNQr1OtUar54fTX3r4G3Jn/U+fq8wYVKJWIf0GGN6idQqMWo
a6JQKmBs0uxFjEW7/6dXALK+2UZgcw0853hie5ZRrWzEQLx1bS4MNm9nTTajY+9i
9q/3tV+qqio1DZZR2jhGSZBX73pRd+zUQFIEI7LeapdoJOwLi8hBvfYfkRO/pmRL
jL1qHN/10ym6MI8THt9LbvoNN/ea4xOP7qDg143zT+f/5nZjxd+ho1GN184U3WcO
hhoaKyu9F7kP+9xXzv/xIW2QKU+oJbdmTspjJUvtWIUCld+ljxizFLBTik4Z6vwA
t3LvGytOfaz23tKA0h/+GhL0KXue4PUbPYGQ+Wx5NBlu5EwXFJC8xfF5gCISXF8H
nNoYNGB/WPDpNvuw8dT/DqOHL4k+Na3aL6XuB5CCfo5NBYpsQ1WAPa7PjZ4UG7Uh
uFsM++dmdZsu17TnbwmynXmNlWBQ1ftE7knYtZPEPynKpgypKaw/seKC9vKgt3mz
APooEjqbROtaY+od7gkSkZi6E8O2OeKTPoemjJyKrMdK0xvv96TZc+9ZQkLFwJt0
izkU6ghHBC6sYQjJa9k1
=LwUT
-----END PGP SIGNATURE-----

--WeoCK3UN7lwjrlbw--
