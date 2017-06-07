Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2017 15:16:50 +0200 (CEST)
Received: from mail-wm0-x232.google.com ([IPv6:2a00:1450:400c:c09::232]:37069
        "EHLO mail-wm0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993301AbdFGNQlWdbMf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2017 15:16:41 +0200
Received: by mail-wm0-x232.google.com with SMTP id d73so10997809wma.0;
        Wed, 07 Jun 2017 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=MBeCQ5UFHQqQZlcxJdjoSenYikBMRLfhLJE6mBfAHjA=;
        b=Tt1nCrhmqzuoJt3Gz6NTOxMEHz36ScRvCVTt0lmz84VcCp87CFvILgQ/EE9+QoQQ49
         IidKjXBByXfh0llVjG1mD4RAXvi3zVBzj0XdjguonDDrxusSlfLQ5XO3LhgNCzI8qcsF
         FoudCtjtJn2MDlr+84s60Pcq2lYfczpf/mkNrA0EH9Mg7u9lGRCI4VWdNfF449G5e8nB
         f2wAuq38VZ6hfDWWHwMw7dw5RQCKXmD7Kv3asMt5CYmI2upBttD8XqyCHQsXh1S+HPXg
         hW0iYe5JUVGN+yz9GcH9xhG3BB9jkemEWtxWN+4DLnIamHVJL0GehKLfiv+nykARNw+S
         /mHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=MBeCQ5UFHQqQZlcxJdjoSenYikBMRLfhLJE6mBfAHjA=;
        b=D3DUazdhOVIHXasBq7fkRjZYRlf+N1wW7P2XZGPbA6UM909F3VBnX6a0uq5H2ITUtv
         6edlrZv4mKjmbe8oWX64VMTrjmUkPa1WI5NKGFNCeuGMyoHT0gsPq/8Tog2OaykLKLpl
         zPDEB36HTxXyPsVpofKVzp2tnvjV6/1RrKHrENnFWVASkE6net4VVoAeueNNvJo7qbeY
         Uyo7w3jfGmnLerU4PKK+IZIyND2QmgfOAWEfsIb/FTvIWtU3+BpLY9ps7+pHzl29s3H0
         qfD2q625gfyA0ZQTkS98DzK6SHd+bckLM6uTOIJoHaP1pzdAKt3M84ClQ3yD4tSmxaRZ
         P5rA==
X-Gm-Message-State: AODbwcBAuW6Uo9aIoG0OhNVnmkqBTqOXUUL1o60uLqFkxXlnnZ3iv3mT
        O+EPee454IWEhQ==
X-Received: by 10.28.40.198 with SMTP id o189mr1596553wmo.102.1496841395446;
        Wed, 07 Jun 2017 06:16:35 -0700 (PDT)
Received: from ?IPv6:2003:5f:2c2c:8800:982a:cc57:23f6:b53b? (p2003005F2C2C8800982ACC5723F6B53B.dip0.t-ipconnect.de. [2003:5f:2c2c:8800:982a:cc57:23f6:b53b])
        by smtp.gmail.com with ESMTPSA id l190sm2697234wmb.18.2017.06.07.06.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jun 2017 06:16:34 -0700 (PDT)
Subject: Re: [PATCH] MIPS: fix boot with DT passed via UHI
To:     Andrea Merello <andrea.merello@gmail.com>, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Jonas Gorski <jogo@openwrt.org>
References: <1496776596-5045-1-git-send-email-andrea.merello@gmail.com>
From:   Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Openpgp: id=8C4E22B0E9754D7137265F81A90C48903C7DBE56
Message-ID: <fd8ad5f4-ab71-e8fc-a7ee-5177877cfb74@gmail.com>
Date:   Wed, 7 Jun 2017 15:16:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1496776596-5045-1-git-send-email-andrea.merello@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l84nkC2Rx1BxlLbhNmXxBMXb7sojcFAoo"
Return-Path: <daniel.schwierzeck@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.schwierzeck@gmail.com
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l84nkC2Rx1BxlLbhNmXxBMXb7sojcFAoo
Content-Type: multipart/mixed; boundary="qAuwI9XmmdtXVDOH3JwU8kpi7GIqnXvD9";
 protected-headers="v1"
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
To: Andrea Merello <andrea.merello@gmail.com>, ralf@linux-mips.org,
 linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org, Jonas Gorski <jogo@openwrt.org>
Message-ID: <fd8ad5f4-ab71-e8fc-a7ee-5177877cfb74@gmail.com>
Subject: Re: [PATCH] MIPS: fix boot with DT passed via UHI
References: <1496776596-5045-1-git-send-email-andrea.merello@gmail.com>
In-Reply-To: <1496776596-5045-1-git-send-email-andrea.merello@gmail.com>

--qAuwI9XmmdtXVDOH3JwU8kpi7GIqnXvD9
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable



Am 06.06.2017 um 21:16 schrieb Andrea Merello:
> commit 15f37e158892 ("MIPS: store the appended dtb address in a variabl=
e")
> seems to have introduced code that relies on delay slots after branch,
> however it seems that, since no directive ".set noreorder" is present, =
the
> AS already fills delay slots with NOPs.
>=20
> This caused failure in assigning proper DT blob address to fw_passed_dt=
b
> variable, causing failure when booting passing DT via UHI; this has bee=
n
> seen on a Lantiq VR9 SoC (Fritzbox 3370) and u-boot as bootloader.
>=20
> [    0.000000] Linux version 4.12.0-fritz+ (andrea@horizon) (gcc versio=
n 4.9.0 (GCC) ) #29 SMP Tue Jun 6 20:49:59 CEST 2017
> [    0.000000] SoC: xRX200 rev 1.2
> [    0.000000] bootconsole [early0] enabled
> [    0.000000] CPU0 revision is: 00019556 (MIPS 34Kc)
> [    0.000000] Determined physical RAM map:
> [    0.000000]  memory: 00696000 @ 00002000 (usable)
> [    0.000000]  memory: 00038000 @ 00698000 (usable after init)
> [    0.000000] Wasting 64 bytes for tracking 2 unused pages
> [    0.000000] Kernel panic - not syncing: No memory area to place a bo=
otmap bitmap
> [    0.000000] Rebooting in 1 seconds..
> [    0.000000] Reboot failed -- System halted
>=20
> This patch moves the instruction meant to be placed in the delay slot
> before the preceding BEQ instruction, while the delay slot will be
> filled with a NOP by the AS.
>=20
> After this patch the kernel fetches the DR correctly
>=20
> [    0.000000] Linux version 4.12.0-fritz+ (andrea@horizon) (gcc versio=
n 4.9.0 (GCC) ) #30 SMP
> Tue Jun 6 20:52:40 CEST 2017
> [    0.000000] SoC: xRX200 rev 1.2
> [    0.000000] bootconsole [early0] enabled
> [    0.000000] CPU0 revision is: 00019556 (MIPS 34Kc)
> [    0.000000] MIPS: machine is FRITZ3370 - Fritz!Box WLAN 3370
> [    0.000000] Determined physical RAM map:
> [    0.000000]  memory: 08000000 @ 00000000 (usable)
> [    0.000000] Detected 1 available secondary CPU(s)
> [    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32=
 bytes.
> [    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, lin=
esize 32 bytes
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000000000000-0x0000000007ffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000000=
7ffffff]
> [    0.000000] percpu: Embedded 15 pages/cpu @8110c000 s30176 r8192 d23=
072 u61440
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 32512
> [    0.000000] Kernel command line: rootwait root=3D/dev/sda1 console=3D=
ttyLTQ0
> ...
>=20
> Cc: linux-kernel@vger.kernel.org
> Cc: Jonas Gorski <jogo@openwrt.org>
> Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>=20
> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> index cf05220..d1bb506 100644
> --- a/arch/mips/kernel/head.S
> +++ b/arch/mips/kernel/head.S
> @@ -106,8 +106,8 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point=

>  	beq		t0, t1, dtb_found
>  #endif
>  	li		t1, -2
> -	beq		a0, t1, dtb_found
>  	move		t2, a1
> +	beq		a0, t1, dtb_found
> =20
>  	li		t2, 0
>  dtb_found:
>=20

The fix looks correct. Without ".set noreorder" one should not manually
put instructions in the delay slot. This should be left to the AS as an
option for optimization.

Acked-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

--=20
- Daniel


--qAuwI9XmmdtXVDOH3JwU8kpi7GIqnXvD9--

--l84nkC2Rx1BxlLbhNmXxBMXb7sojcFAoo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZN/yoAAoJECj5Tpck8lwYCicP/0VnnOJhTd/TYTEPqf7SrWmA
C6tImN3Vi03tE9FtHDym4+BG0XHCdUgU4k+p1cL1koTzL6Jwc831FyG/CyqDyeOp
taBp4SmRMjpDUMCjIFNtu0ogAh3oyCu5kzONDzDGog2UzDMU/GgO9j7Hr56+3H1M
4ZA7scusEyPJL36HsZNg/9kxIHMhdGQN/6Q4AHalCAPQsVEXUbY/AXgYMbNg7wGA
aMIfetIxw168kdAIQVLUadTcSe1YAJ4ck2JPFi4D4S5CaPFXqo/pNXCENqbVuAEz
5nKY95xtSpmQJmbIcpklRy4tZKINweIK9VvBbq2aVYdhAKqhh8GedAsjlPn3t7LC
7UYfQ43gqEYQx5OTlL4uz/ln9PXnJ4W+4HOxzkwGE5lDP2vion4mnVfJj3PjNaMF
cvLTdKedHhWNtSyXlHhRILiEEb/SE8HBlJabtmRxetJy0ZN8AgnOU6Jx5zL51NRF
zHJfo/H99DWSK4xe15dpb6sf5oGUgOlNUTPmsBNp7QyEvpVs7Hd6CNPUdO/6gXvy
eMah95omrWjXOVe6G2Uuk5Ljdq8LOEWJolAe/hvOiotiYy6JVeasu3vlowSd8vMO
6PDFKrBofcBFZot8kIGIRgQEwmJDIFK3NLWtxrBX4VkcENOWmFdLkyUBpy6bdl9I
MW2620jsCFVoJ8bBXdgz
=+HmA
-----END PGP SIGNATURE-----

--l84nkC2Rx1BxlLbhNmXxBMXb7sojcFAoo--
