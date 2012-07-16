Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2012 13:15:21 +0200 (CEST)
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:53443 "EHLO
        na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903548Ab2GPLPR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jul 2012 13:15:17 +0200
Received: from mail-lb0-f174.google.com ([209.85.217.174]) (using TLSv1) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
        ID DSNKUAP3wsB6RbkrCEeJ6zWZedPpDvauIVCl@postini.com; Mon, 16 Jul 2012 04:15:16 PDT
Received: by lbbgm6 with SMTP id gm6so8554746lbb.19
        for <linux-mips@linux-mips.org>; Mon, 16 Jul 2012 04:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=4Nxc50hDjmlE0B9OFABYwNOKRjpH2v3yEdfjJQGgbeg=;
        b=DVTB146YjkmLTMxVrTSOLF3PGO/JJoM/dYKS1WkLDTDAQth1akHYKrPrrF+5qZp/FE
         OWbBtcVdij3RXCkHF+Ch7M32xk4ah++dtPq3KLaFOcsmMAW6f0vdZ8hb28Qf7oXBCiIx
         cNd8+gQM4di0qhslfEG0G7IgJVaSRgsBomAJlKRX79dcHaGiC7GUm6xY+/tyT3ikil0W
         EF812ztbaDJQXGwW4VNkFqAJUr7QP+GTZMMa5I719vk/C05b5QkPQfDvllKNmSL70Aj8
         b8j6/SluLVtWLB2QmfmPJtCNEhH6qe2yan085BkSR6mZJRExbMrpeHQEEUjI5NgUCFat
         pceg==
Received: by 10.112.49.100 with SMTP id t4mr5147527lbn.10.1342437313388;
        Mon, 16 Jul 2012 04:15:13 -0700 (PDT)
Received: from localhost (cs78217178.pp.htv.fi. [62.78.217.178])
        by mx.google.com with ESMTPS id k4sm3432692lbb.12.2012.07.16.04.15.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jul 2012 04:15:12 -0700 (PDT)
Date:   Mon, 16 Jul 2012 14:12:19 +0300
From:   Felipe Balbi <balbi@ti.com>
To:     David Miller <davem@davemloft.net>
Cc:     balbi@ti.com, joe@perches.com, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, wimax@linuxwimax.org,
        linux-wireless@vger.kernel.org, users@rt2x00.serialmonkey.com,
        linux-s390@vger.kernel.org, johannes@sipsolutions.net,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-kernel@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-mips@linux-mips.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        e1000-devel@lists.sourceforge.net
Subject: Re: [PATCH net-next 0/8] etherdevice: Rename random_ether_addr to
 eth_random_addr
Message-ID: <20120716111218.GA4913@arwen.pp.htv.fi>
Reply-To: balbi@ti.com
References: <1341968967.13724.23.camel@joe2Laptop>
 <cover.1342157022.git.joe@perches.com>
 <20120716101437.GC22638@arwen.pp.htv.fi>
 <20120716.032901.1657058688119342783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20120716.032901.1657058688119342783.davem@davemloft.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnMJ33PKAEcNd0WYHeSC+yllUkh+96DZC7WFKCCIw/39uWbsz+bbMSloN/xFw/MMEV2/syb
X-archive-position: 33933
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


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 16, 2012 at 03:29:01AM -0700, David Miller wrote:
> From: Felipe Balbi <balbi@ti.com>
> Date: Mon, 16 Jul 2012 13:14:38 +0300
>=20
> > if you're really renaming the function, then this patch alone will break
> > all of the below users. That should all be a single patch, I'm afraid.
>=20
> It would help if you actually read his patches before saying what they
> might or might not do.
>=20
> He provides a macro in the first patch that provides the old name,
> and this will get removed at the end.

that's why I put an "if" there. The subject was misleading and I really
couldn't bother going search for the patch on the mail archives.

Anyway, if nothing will be broken then for drivers/usb/gadget/:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQA/cSAAoJEIaOsuA1yqRECgMP/11LX6hhvLwodK9V12dXWUI8
n4rD9q+ipGtPf/S551hE9jkkp4yCPUromRhx5hgbmaDJ23ZbqHpRR3fNNHSGpH1W
xSdS7vdtqWxpt7LUqczpgbjstrFqDYEt5idkuUsQ3QRZEZ5NgeTigWYEiIpf6uPQ
qy1YgtmJZlPJKskiH+8YdDGHgL3vI8iypfk7GBVwBYp7ozl7LyqM62mpbSMPxQGr
uAx/FEFC2o31p/B81WkGzFiq2vc7oy+c+IvfWre+mI7X6+AyiAGR719CI0V7umQD
iMK/yrncbbuBCEsCdLN446kkRocFYX/IDiykTYHc2/V4WDxJO8wYH0gTSdMJOxDG
fsxrUS9RUAb0vyGRaUvTMHKhQdo5ijBhkWHvoL7jjyqaCEvYqarRDhqZq6uW6t9E
AVNxmUriH7Iflw1BiRJk03IO3/dFOY2b5yCTmSwklNdXuuL52biuRe3PIK1mDli9
F2sr5xj/VuT66HNTbOI4tFH53yhakkYjSffVK8xs2GuBvsTr1RiLBQT2YK3yU77Z
Pk798mAkIhUhlZh998YRlJHtqs9JkyeHIHTuSt7Zj/FJmWaDLfjMAa18knsuFAFg
tYnpnP3mtGE12FeXQ0rGcnqrsqWjIy8NKnNjf9DqNc/DwmjnyL/UMsN0J+m9/uaF
kyn8nJ4loji/LHjMvX2g
=BzOs
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
