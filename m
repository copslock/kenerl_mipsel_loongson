Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2015 16:15:36 +0200 (CEST)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35786 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013579AbbESOPcCP-8J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2015 16:15:32 +0200
Received: by pacwv17 with SMTP id wv17so26617472pac.2
        for <linux-mips@linux-mips.org>; Tue, 19 May 2015 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MGXBYKpwlmLpIef7AxmQ6kmqOuOOMdx+yZaLXazTWRw=;
        b=awZhKYgL6duASkTngfQyCnGtuAbvUSEfS9OeQHH87hnKWSupdMExrfkBV1GDBZ7IUO
         89rVPh1+2gRvVS6YaEKWF40hvHSkMHtmk2KAx5k8aLVFUhaY4z4+ECeGY1FwFRQy6AT3
         50BrKITcujAfjjvKsBaYhMgthvV+DnGoC2mX38xLW++QCUNldjqqEmKQnXsQsBaOoRwR
         RhCpEIJsxV8hMBAm5PmNSLOBWTnW7mWhjt7s6fZUUNptjh80Rtv83hmBvWXE8swJHS7/
         Tvop71C6vC664dFPs1QpSo4Idpdw9ZjTFIJ6Iw2Ge0WyGikWwvZYb63X+gvotDJMveOV
         D85w==
X-Received: by 10.66.162.165 with SMTP id yb5mr55317953pab.32.1432044928425;
        Tue, 19 May 2015 07:15:28 -0700 (PDT)
Received: from localhost ([216.228.120.20])
        by mx.google.com with ESMTPSA id c8sm13283506pdj.65.2015.05.19.07.15.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2015 07:15:27 -0700 (PDT)
Date:   Tue, 19 May 2015 16:15:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     linux-pwm@vger.kernel.org,
        Naidu Tellapati <naidu.tellapati@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        linux-mips@linux-mips.org, sai.masarapu@imgtec.com,
        arul.ramasamy@imgtec.com
Subject: Re: [PATCH v2] pwm: img: Impose upper and lower timebase steps value
Message-ID: <20150519141522.GA26748@ulmo.nvidia.com>
References: <1431035961-2008-1-git-send-email-ezequiel.garcia@imgtec.com>
 <1431121651-6787-1-git-send-email-ezequiel.garcia@imgtec.com>
 <555778D3.4030607@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <555778D3.4030607@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2015 at 02:05:23PM -0300, Ezequiel Garcia wrote:
> Thierry,
>=20
> On 05/08/2015 06:47 PM, Ezequiel Garcia wrote:
> > From: Naidu Tellapati <naidu.tellapati@imgtec.com>
> >=20
> > The PWM hardware on Pistachio platform has a maximum timebase steps
> > value to 255. To fix it, let's introduce a compatible-specific
> > data structure to contain the SoC-specific details and use it to
> > specify a maximum timebase.
> >=20
> > Also, let's limit the minimum timebase to 16 steps, to allow a sane
> > range of duty cycle steps.
> >=20
> > Fixes: 277bb6a29e00 ("pwm: Imagination Technologies PWM DAC driver")
> > Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> > ---
> > This patch is needed for the pwm-img to work properly, so it should be
> > pushed as a v4.1-rc fix.
> >=20
>=20
> Any chance you push this patch as a fix for v4.1?

Pull request sent now. In the future it'd be nice to make fix patches
smaller than this and leave the refactoring to a subsequent patch for
inclusion in the next release.

Thierry

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVW0V6AAoJEN0jrNd/PrOhQGgQAJGYD2A22jeo0k75oqqRX+1t
mjjroNeQMGZ40qto3h9WWz7EdtZzCKmPwERUNq40JHcfkoix4eq2nkHm55+WD1F0
/eGsnZo3et+Qi+HAB5Myo0IInL1YQZwioxhOjCdAoL5cZkIgtjindIN1LvElhOMi
dukWUiQTVffgkc7MLIUZpEeYIIgwjpYEbLBbO3uew0V/+JE5S2umKveZ5y+HfiCM
Gwp/cN2f795A3W3t8xBvPFkbhFjpHenlk2AnVqtSoaBMqf9gX78qLUKFwB2Gg72T
5utd4TqDYhZYHyU6EkuABehysdPqZawImh/CZ+d8XnfXfpwcUeMXIBDhLQINHQf9
xyL2rlvRr5X4NYK9grBUk/VV3dEUnNY4CQ2A/1cAitymZzrjq+77AiMwTXzSu/GZ
a1GXBRM4CNbRP6G/YkJYgHq0G3BpzccmxpxMOWxbd6nncDNaFbdp3X/Q3TPve6Sr
K4cs2s/ANUzfba81Xfdlr+HP6T2tsTCp1UZXioyB2ozbUF4XutBysb8sYMhHtkJc
oc0TLFjT3PBMo0OyQZh1K6R5kH4wFb+JVatLui89pOAC3qJv9BXxtA11wiq61F72
/gP+5kDmW0x+NiQguxGniJYk7zZ+B60EEmjdizxbrdJTpDUYJthrZlKO/0qIqFob
lI6nrrXABFMgrTAl+xPk
=4kM+
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
