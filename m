Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2016 11:21:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59598 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992942AbcJRJVtrpiKd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Oct 2016 11:21:49 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 9DB2D41F8E5F;
        Tue, 18 Oct 2016 10:21:18 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 18 Oct 2016 10:21:18 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 18 Oct 2016 10:21:18 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id D74976DE9730;
        Tue, 18 Oct 2016 10:21:41 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 18 Oct 2016
 10:21:43 +0100
Received: from np-p-burton.localnet (10.100.200.61) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 18 Oct
 2016 10:21:43 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Tejun Heo <tj@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Jiri Slaby" <jslaby@suse.cz>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Ivan Delalande" <colona@arista.com>,
        Thierry Reding <treding@nvidia.com>,
        "Borislav Petkov" <bp@suse.de>, Jan Kara <jack@suse.com>,
        Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] console: Don't prefer first registered if DT specifies stdout-path
Date:   Tue, 18 Oct 2016 10:21:36 +0100
Message-ID: <2401691.yKn6kY81q4@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.2 (Linux/4.7.6-1-ARCH; KDE/5.27.0; x86_64; ; )
In-Reply-To: <87oa2ij2mq.fsf@linux-m68k.org>
References: <20160809125010.14150-1-paul.burton@imgtec.com> <4033254.tBrl4yKcsP@np-p-burton> <87oa2ij2mq.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1491817.ehho7IUxQd";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.61]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart1491817.ehho7IUxQd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 17 October 2016 19:39:57 BST Andreas Schwab wrote:
> On Okt 17 2016, Paul Burton <paul.burton@imgtec.com> wrote:
> > Could you share the device tree from your system?
> 
> This is the contents of chosen/linux,stdout-path on the systems I have:
> 
> chosen/linux,stdout-path
>                  "/pci@f0000000/ATY,SnowyParent@10/ATY,Snowy_A@0"
> 
> chosen/linux,stdout-path
>                  "/pci@0,f0000000/NVDA,Parent@10/NVDA,Display-B@1"
> 
> Is that what you need?  There is also chosen/stdout, but no
> aliases/stdout.
> 
> Andreas.

Hi Andreas,

I think I see the problem & I'm hoping this patch will fix it:

https://lkml.org/lkml/2016/10/18/142

Could you give it a try & let me know?

Thanks,
    Paul
--nextPart1491817.ehho7IUxQd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYBemgAAoJEIIg2fppPBxl/ocP/RsSGhUJsbbXOzHH0zhvW5/0
lmP447zgfYfSB63uNeLJ/uZwmyYVy5/6by9+88bPp+pnw5IvbH2oWOcClRXBopP2
a03Yn/sGYx1nybguqE0CIMql9keWdudPQB2W3008pg7jMRx7DeOnWLLJqgDK2eRH
/0dqLH8ISm7olbbfbJOmSZhKI/cip2mB3utR0/wln/f89bXbFKDkyf/S9m2p0+/o
agKLZNbxlT8ApQIgTdy2wYYJej3DIwNe7jofxKVlQ/hjvVBq4T80kbEuLeBYVn9L
7bUoIplFzLHidsNYCXUm+uuaC8ogtu0kV9akIHzx1yTtwsEiKP59I/N7IjvcvNDU
AygRucuIiYL6OzXFwktChzqLmG07deHNPSxBS+Tsx82Gt5IO984nFLuOZwYmQFSY
yWCsTZS/R74GQBth1vhH1hBtMViHPqW6UFvQ5xhUGV/dLsevO+azgSlcYnDFr2GE
TfZJ/laYn3mh2zSlGmJX5KU8eiqIUuF47eAx29twD3W/6XSMWDj/mJe4LnW9/zqb
G3WSOoLrv2gYvNaaCGGyAfJMshQqlod9QCCifsXPAnB3jge2VW3AJT47KeBeNzJV
WtQR5w5PK2iPE05lbcOoLICopg0Utlb005M6UYGzzVSaKD4xkNrDWaOAaTlCfkn8
SNxS0sVuI8lxwzZNdr3V
=dSrA
-----END PGP SIGNATURE-----

--nextPart1491817.ehho7IUxQd--
