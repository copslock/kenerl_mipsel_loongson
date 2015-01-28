Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 01:17:29 +0100 (CET)
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43984 "EHLO
        mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012194AbbA2AR1xCckb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 01:17:27 +0100
Received: by mail-wi0-f172.google.com with SMTP id h11so17514233wiw.5
        for <linux-mips@linux-mips.org>; Wed, 28 Jan 2015 16:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :organization:user-agent:in-reply-to:references:mime-version
         :content-type;
        bh=bo1FAJUzPZAo+ZNP/zpHNUYCEs9wvOKk/UnU+Wk9KYQ=;
        b=mLrWHv/dr/T9r5CPJQ1A9GdPVjlpXUXacj5Lzv1kFEt7E6vLQbavWv/MefsbeTaIov
         1rzis3x+2Y7rKu/sdaLRJzW9fyYFATCaNliblvzbcYGSK1H2LieKQQzOZ/p/mHYytb6k
         aJoSn63RrL/OHhmp5xKQHCK0FbKtoSJEqPsT9T9YJPebPfmZpK7MWhZNlo23D2WQPyig
         vuOydnhRBkHtwkvqOEpqJ/C6T3AVxHkNu5uyImHq4jWTep4/P/t5q7fBRvoOtiy6JMJX
         vi9oLIV5fQj3j5ENznJUl+0JYy//pWmdPAHQc/KhXJBZlOtJv2CGXlTnKQr9vXg9Dd8n
         Y6Nw==
X-Gm-Message-State: ALoCoQmA9YvKIRMNa3skx9WdDqe/F4ZWLiUTUt5ht7DU5ZdoN4jcXcVFZyBCYUWtL5NZOJcdSPLX
X-Received: by 10.180.98.228 with SMTP id el4mr12166775wib.77.1422490642644;
        Wed, 28 Jan 2015 16:17:22 -0800 (PST)
Received: from radagast.localnet (jahogan.plus.com. [212.159.75.221])
        by mx.google.com with ESMTPSA id x18sm183883wia.12.2015.01.28.16.17.20
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 28 Jan 2015 16:17:21 -0800 (PST)
From:   James Hogan <james.hogan@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] MIPS: Add arch CDMM definitions and probing
Date:   Thu, 29 Jan 2015 00:16:38 +0100
Message-ID: <5668659.y0L0n9UuOk@radagast>
Organization: Imagination Technologies
User-Agent: KMail/4.14.3 (Linux/3.18.4+; KDE/4.14.3; x86_64; ; )
In-Reply-To: <alpine.LFD.2.11.1501280253280.28301@eddie.linux-mips.org>
References: <1422393401-13543-1-git-send-email-james.hogan@imgtec.com> <1422393401-13543-2-git-send-email-james.hogan@imgtec.com> <alpine.LFD.2.11.1501280253280.28301@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1552609.32XrLGTaGl"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45518
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


--nextPart1552609.32XrLGTaGl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Maciej,

On Wednesday 28 January 2015 23:09:17 Maciej W. Rozycki wrote:
> On Tue, 27 Jan 2015, James Hogan wrote:
> 
> > diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> > index 33866fce4d63..2086372fa72a 100644
> > --- a/arch/mips/include/asm/cpu.h
> > +++ b/arch/mips/include/asm/cpu.h
> > @@ -370,6 +370,7 @@ enum cpu_type_enum {
> >  #define MIPS_CPU_RIXIEX		0x200000000ull /* CPU has unique exception codes for {Read, Execute}-Inhibit exceptions */
> >  #define MIPS_CPU_MAAR		0x400000000ull /* MAAR(I) registers are present */
> >  #define MIPS_CPU_FRE		0x800000000ull /* FRE & UFE bits implemented */
> > +#define MIPS_CPU_CDMM		0x10000000000ll /* CPU has Common Device Memory Map */
> 
>  Is it a typo here: 0x10000000000ll vs 0x1000000000ull?

Yes, it would appear so. Well spotted!

Thanks
James

> 
>   Maciej
> 

--nextPart1552609.32XrLGTaGl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJUyXvtAAoJEGwLaZPeOHZ6G84P/2pUYfaem5Swny14MEfdn/26
dRSXnSCsbbryWQ+FEtZqe2BMPxLNVMlGniLxE4dWjqAWkgY0Wfo/2gOShBs+iN1e
QtRz+iCU/DNxnp4nBVsD/RaEYE/AjzLqh+zQD9FqkK6UonsGmAmU78BQ4lNe2gTk
IrgAMBKnokIhVmliup8nAqz4pjiOTwjNzGUYMDeQXMHTI1bXTlo/6gokWRjCMKmb
nYekCBwwU8tnzCY0+F8R7bN9+m6FP2S1KP8QRn53gnKg0zB+IrQ0H7lRpBak9fpm
/zg7oZrLTu12Pyhm2WOEYN7jBRbpp3n9xc6qYE8vjKJ0jnj7dvVI13j3+DCmDlvo
a6GZSovbelq9pe7ySzLvAFqjPPLCUHJrHsTUCf+oEnzCU+3COl32hlSCTb7ii61K
abdXkx1mbdiTNqEcpmhty0moX8DisYGC+hY+UIpz+7NCYyXFRhc4VMFkJsyCcDPk
XbVrVqUiwpYZBWuMbfqVdRlWKWiN4NPuUprSstZ1U7R7EQrWaNPgrZZdq+ykwQ3X
U45rZA87u8llW4qsLJE8qLWACFAjwfTWsbySpGuoAJm4aGZoSuDu/JLTXRv+ps3k
HQPoKZUrH6YJk6zcgpI4ikoAe68dHeu17/rjDEw/eNED8XMEyDpr8tnqgQCrWVdV
YZ6auhprKGqNShUQ6RdT
=7Txp
-----END PGP SIGNATURE-----

--nextPart1552609.32XrLGTaGl--
