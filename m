Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 13:20:30 +0100 (CET)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:59739 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013422AbaKMMU3DBmWp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 13:20:29 +0100
Received: by mail-wg0-f45.google.com with SMTP id x12so16916793wgg.18
        for <multiple recipients>; Thu, 13 Nov 2014 04:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7N4sZafuI6xfI6KmrXWN5Ep6l1THiMoYa/vgX48+uRA=;
        b=v9B9lJpj0qXAwCmdkHTPcrEpeEXBXVaBjjmSvNFQ3waHN3LKO6DIUxS7VAjCWtC6jw
         /avqAs7TDajA6FvzQpNJYc8K1DBDaBT6Vkqoo5k5Bt0zPq9HWTGvyvAVwVPX7co0dqmP
         j5nu38/Rf7Tazxts6fFB8qNT6V6lgrRClwmSB+P3+P4sx7elyv2pWAz2xzPsniWY+hOJ
         aYbIbNO8etwgbL/K3KeASM04uK2ucUYBQHM898vfIELG2EEgeWGEfooTDAVBP03mYvI+
         bEeTJ73zSpq2IADwo1t8zQPglTpwr9JVds/gBOxpCMdr8MvnZoJaE3tLatX/LAy7Ga8N
         oxxA==
X-Received: by 10.194.250.105 with SMTP id zb9mr3313822wjc.123.1415881222542;
        Thu, 13 Nov 2014 04:20:22 -0800 (PST)
Received: from localhost (port-8254.pppoe.wtnet.de. [84.46.32.94])
        by mx.google.com with ESMTPSA id w5sm25511828wif.18.2014.11.13.04.20.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Nov 2014 04:20:21 -0800 (PST)
Date:   Thu, 13 Nov 2014 13:20:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] binfmt_elf: load interpreter program headers
 earlier
Message-ID: <20141113122011.GE23422@ulmo>
References: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
 <1410420623-11691-3-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bGR76rFJjkSxVeRa"
Content-Disposition: inline
In-Reply-To: <1410420623-11691-3-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44114
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


--bGR76rFJjkSxVeRa
Content-Type: multipart/mixed; boundary="3O1VwFp74L81IIeR"
Content-Disposition: inline


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2014 at 08:30:15AM +0100, Paul Burton wrote:
> Load the program headers of an ELF interpreter early enough in
> load_elf_binary that they can be examined before it's too late to return
> an error from an exec syscall. This patch does not perform any such
> checking, it merely lays the groundwork for a further patch to do so.
>=20
> No functional change is intended.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>  fs/binfmt_elf.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
[...]

kmemleak started complaining for me recently and the stacktrace (see
below) points to this function:

	unreferenced object 0xec0f77c0 (size 192):
	  comm "kworker/u8:0", pid 169, jiffies 4294939367 (age 86.360s)
	  hex dump (first 32 bytes):
	    01 00 00 70 1c ef 01 00 1c ef 01 00 1c ef 01 00  ...p............
	    a0 00 00 00 a0 00 00 00 04 00 00 00 04 00 00 00  ................
	  backtrace:
	    [<c00ec080>] __kmalloc+0x104/0x190
	    [<c01387d4>] load_elf_phdrs+0x60/0x8c
	    [<c0138cb4>] load_elf_binary+0x280/0x12d8
	    [<c00f8ef0>] search_binary_handler+0x80/0x1f0
	    [<c00fa370>] do_execveat_common+0x570/0x658
	    [<c00fa480>] do_execve+0x28/0x30
	    [<c0038eb4>] ____call_usermodehelper+0x144/0x19c
	    [<c000e638>] ret_from_fork+0x14/0x3c
	    [<ffffffff>] 0xffffffff

> @@ -605,7 +598,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	int load_addr_set =3D 0;
>  	char * elf_interpreter =3D NULL;
>  	unsigned long error;
> -	struct elf_phdr *elf_ppnt, *elf_phdata;
> +	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata =3D NULL;
>  	unsigned long elf_bss, elf_brk;
>  	int retval, i;
>  	unsigned long elf_entry;
> @@ -729,6 +722,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		/* Verify the interpreter has a valid arch */
>  		if (!elf_check_arch(&loc->interp_elf_ex))
>  			goto out_free_dentry;
> +
> +		/* Load the interpreter program headers */
> +		interp_elf_phdata =3D load_elf_phdrs(&loc->interp_elf_ex,
> +						   interpreter);
> +		if (!interp_elf_phdata)
> +			goto out_free_dentry;
>  	}
> =20
>  	/* Flush all traces of the currently running executable */
> @@ -912,7 +911,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		elf_entry =3D load_elf_interp(&loc->interp_elf_ex,
>  					    interpreter,
>  					    &interp_map_addr,
> -					    load_bias);
> +					    load_bias, interp_elf_phdata);
>  		if (!IS_ERR((void *)elf_entry)) {
>  			/*
>  			 * load_elf_interp() returns relocation
> @@ -1009,6 +1008,7 @@ out_ret:
> =20
>  	/* error cleanup */
>  out_free_dentry:
> +	kfree(interp_elf_phdata);

I think what happens is that the interp_elf_phdata memory is freed only
in the error cleanup path, but not when the function actually succeeds.

The attached patch plugs the leak for me.

Thierry

--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch
Content-Transfer-Encoding: quoted-printable

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f95da60e440e..8a9be83e88c2 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1029,6 +1029,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 	}
=20
+	kfree(interp_elf_phdata);
 	kfree(elf_phdata);
=20
 	set_binfmt(&elf_format);

--3O1VwFp74L81IIeR--

--bGR76rFJjkSxVeRa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUZKH7AAoJEN0jrNd/PrOhy/MQAJVjlbLVcaWEqO9GHVkk/yen
zwvbp8+vEipD9pWIZnbVb8HOW5szSw/M1QiKYW7nAD6v22dEtxHOAxRsCSeZch+T
/JusxauITCGbvouclcPw+HWoFduCGocHiuBgL6UeMdcYC6usnJecglt9HgNadKAQ
CtKCGY7uAeqJj+Fn91jjtlPmJEKL74Zy3uEdqjFJZL4VjJVteOzdKMTYcOpzuBF9
OoJWr3H4lS5UYyMyIcrLNRFmjkjo2xy8AhXXFDy/b79PMIFskV75xy/sADu/KXxv
V+ZMNhwnWHGo7lbmEZpvLKBZ3kFR5tj2AMXEpJ8tyBiYVZM8wtWvmU4cCkq+ACk1
h99sJv9WvipH51laj7Y1rmZ4/z31/WHQ5S9GViHFwrWFyojsBMxBZLRRUc4NUKBO
zQFyxqdNdpm+F2O5zGV4gVagwzT1i5feHkLHwbNae5BbyB4S5tOetL+TTXiOQ/5O
mNv15QzOkoNaxb2aTlmmpMgINxob2WEpkGbU7naPWPATHeN+QirWVMfrGMqC4hjx
RxZvF6ziTCN8oS2znbZ6vgkd8vmETYLaGRoFwkI0VwEEhKKvYPy3GR6Akduwzlf9
ZK3v/77shJlozPI+nShLYelkGg/tbxtvEEefvTsQToS0IbgHNg8Ss1sfIpjvHDQB
QMphqnv+9f+xMYFdJnhH
=RkI8
-----END PGP SIGNATURE-----

--bGR76rFJjkSxVeRa--
