Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2012 17:29:52 +0100 (CET)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:56134 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825881Ab2KAQ3vWHrGk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2012 17:29:51 +0100
Received: by mail-ee0-f49.google.com with SMTP id c1so1397002eek.36
        for <linux-mips@linux-mips.org>; Thu, 01 Nov 2012 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:organization:references:user-agent
         :x-face:face:x-pgp:x-pgp-fp:date:message-id:mime-version
         :content-type;
        bh=v5hZuHQylme6iT5dN2UnoQJMwmVS0llr441iQV0Ycg4=;
        b=RBUr3g0Ujc1QkC8Etv2eRRaOjz7vsK8l2HULODHqsW+cVA/JgXPCINvQNlAAgAIu1L
         af+C2riHVsVnaUrohNuA1spNtfRtt7FlmmLbegGw9w30mSJfxFaCf3qrwsr3FvU2Hf4R
         9vfWDlwm2PyPKMcLP/LCmIYL7My13n0yKjWdILIiDrOFgdg8IogWp0tCassAg6s4bViq
         Y+ZjHsZLnNwAkL3ge71OQvXvKmSFiGpmb+5bHIvrWhLxAEawI+9GYtqES+ebC2soobLf
         lSbFnfJf5limMERiMJUpWKOaOX+hejjGlW8/SdJ0n/+U8gSxlAusQ+83nJGLpU9z+GBC
         j+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:organization:references:user-agent
         :x-face:face:x-pgp:x-pgp-fp:date:message-id:mime-version
         :content-type:x-gm-message-state;
        bh=v5hZuHQylme6iT5dN2UnoQJMwmVS0llr441iQV0Ycg4=;
        b=P9CGSBiqVuhY0D2yG4co/rpsaL27lnreJdDhGoaqVFTo6xUFwcMz9xsDAj9RsT+4o0
         wmxseJ11eDe/wD2lHf+ksRzjGdlZiciURu3zZfQO8azr6aId1Ah5x5MJKqX3Pn4FfnbN
         deyiRVMbkDJsPMgr9TSTfqgPhokKzfvL6ukyECGEURSSnWSAbLXcA8K+qjeVaGBCt9Zk
         i+WgDRaLTUqkN5GtTvkZM9cNa4ktV94PKezUtHXpZjEf9ElebmAqbvwfPZ4R06zu0emh
         WP6kUxe5tCHuQUnPwHsvmpy7DM63Yi9MES08mEeKnR9h1lgLy+tTbf8BnZQRwB8Xiiha
         +s6Q==
Received: by 10.14.220.71 with SMTP id n47mr99018294eep.26.1351787385779;
        Thu, 01 Nov 2012 09:29:45 -0700 (PDT)
Received: from mpn-glaptop ([2620:0:105f:5:7def:8108:f4e4:1aad])
        by mx.google.com with ESMTPS id d44sm15740028eeo.10.2012.11.01.09.29.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 09:29:45 -0700 (PDT)
From:   Michal Nazarewicz <mpn@google.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Mike Frysinger <vapier@gentoo.org>,
        uclinux-dist-devel@blackfin.uclinux.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH 1/6] arch: Change defconfigs to point to g_mass_storage.
In-Reply-To: <Pine.LNX.4.44L0.1211011033170.1762-100000@iolanthe.rowland.org>
Organization: Google Inc
References: <Pine.LNX.4.44L0.1211011033170.1762-100000@iolanthe.rowland.org>
User-Agent: Notmuch/ (http://notmuchmail.org) Emacs/24.2.50.1 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP:  50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
Date:   Thu, 01 Nov 2012 17:29:38 +0100
Message-ID: <xa1tobjhwakt.fsf@mina86.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Gm-Message-State: ALoCoQme6srMo8uA4GnSLImgk53MFxHHOUVe7fPVV0lkH6ws/gYte0I7UaveK1Z7OUo9vrqJrdqe/prLCPeEFg93xHWVdWRoOLckRXvgGcUwUDBKI4sTMCKRsbHKq/CsVL1sQglRXRJNol6B6sWxKjWbbRm8kj7305DzWyWzZ4gnCeFAIqi3lI2Xk+Zaq3T1X/2iiatQEOt2ztAkLOvQqww0ISD3AlV9MA==
X-archive-position: 34848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpn@google.com
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> On Wed, 31 Oct 2012, Michal Nazarewicz wrote:
>> --- a/arch/arm/configs/qil-a9260_defconfig
>> +++ b/arch/arm/configs/qil-a9260_defconfig
>> @@ -108,7 +108,6 @@ CONFIG_ROOT_NFS=3Dy
>>  CONFIG_NLS_CODEPAGE_437=3Dy
>>  CONFIG_NLS_CODEPAGE_850=3Dy
>>  CONFIG_NLS_ISO8859_1=3Dy
>> -CONFIG_DEBUG_KERNEL=3Dy
>>  CONFIG_DEBUG_USER=3Dy
>>  CONFIG_DEBUG_LL=3Dy
>>  # CONFIG_CRYPTO_HW is not set

On Thu, Nov 01 2012, Alan Stern wrote:
> This seems to have crept in by mistake.

Yes, obviously, thanks!

I have updated version prepared, will send it tomorrow in case someone
have some more comments.

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain


--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJQkqNyAAoJECBgQBJQdR/0YTEP/jnfvfot7qkoowcjQ5v+QRHg
Ixubb3k2W/hiSvgttLx2Wek3OLmEXVG/6EAZT/1I/m2ddilFri5HAUm9Hd7YoH8U
bkjhIyHJyRDQkGSN4znlxHglnwdqk0hxIemcei/FjBGCCqDysIgXDX3HWbYKkTwO
N6MI7zbEXK9nV+AkGXz1AUa7xTw88M5X6TK28DIt9AIDpXpD4cI+Dv2l39EZirom
D2gHZc18wcvdYrNEm36ePn2RHETe6HDijOWrxRmN0sf4S/sxHhpR/OwAlXuOSlir
gvu3P+nzCDCKNTpg2eGbrkJxwL2B36YQwIm8CZOaE6p/3QBi/mWKCDzqgLyUsy3I
peYosUiRPtzNJ8h5nSm1LX+xRU0B6oxKYYzBdJPeGIsmZn44Shn7UN+3PZw4r6fu
8rb+WyFr4U5abHzpEmOf0PMr5EexTf1HPayLcEKpapEiCzW6p3okJCSLCbMLmB1Y
qGOMO0rVB8gw2zuh2L+fuHwN8uZ0wxrvFWgWIDNwSVIy6xRvN5qKrJ0MtRYhDZ1D
szTEisr5qr9Frj1nAuZVwo2ZiCEwvDX6DLT294NP8On27BaNVhELT6716NMqozAv
LP84gnqJBA0T5UHxLp0zCTI3t/ctIz8n49BCuDP3dk3koNUwlT/8bpr5FJkxm9we
bPkmNPz32ukFI26OiI/R
=zLzH
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
