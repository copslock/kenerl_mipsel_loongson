Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 16:52:43 +0100 (BST)
Received: from skl1.ukl.uni-freiburg.de ([IPv6:::ffff:193.196.199.1]:52904
	"EHLO relay1.uniklinik-freiburg.de") by linux-mips.org with ESMTP
	id <S8224929AbUHRPwi>; Wed, 18 Aug 2004 16:52:38 +0100
Received: from ktl77.ukl.uni-freiburg.de (ktl77.ukl.uni-freiburg.de [193.196.226.77])
	by relay1.uniklinik-freiburg.de (Email) with ESMTP
	id 3E3C12F291; Wed, 18 Aug 2004 17:52:30 +0200 (CEST)
From: Maxim Zaitsev <zaitsev@ukl.uni-freiburg.de>
Organization: University Hospital Freiburg
To: "Kaj-Michael Lang" <milang@tal.org>
Subject: Re: O2 arcboot 32-bit kernel boot fix
Date: Wed, 18 Aug 2004 17:52:35 +0200
User-Agent: KMail/1.6.2
Cc: <linux-mips@linux-mips.org>
References: <001401c483b8$51d289f0$54dc10c3@amos> <003901c48530$577b4f80$54dc10c3@amos> <200408181646.53698.maksik@gmx.co.uk>
In-Reply-To: <200408181646.53698.maksik@gmx.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408181752.35073.zaitsev@ukl.uni-freiburg.de>
Return-Path: <zaitsev@ukl.uni-freiburg.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zaitsev@ukl.uni-freiburg.de
Precedence: bulk
X-list: linux-mips

Ha!!! It works!!! Well, only 32-bit kernels work, but anyways, sorry for 
trouble. I must have tested it before bothering you with stupid questions... 

With regard to booting a 64-bit kernel it all looks OK, loading works and what 
I see in the end is:

Starting 64-bit kernel
--- Press <spacebar> to restart ---

No OOPs, no crash, nothing! Isn't that strange? Any ideas?

Regards,
Max

On Wednesday 18 August 2004 16:46, Max Zaitsev wrote:
> > Did you just use the small fix or did you use the whole patch ?
>
> No, I've just used the original 3.8.1 distribution and could not compile
> that I've tried it like a month ago and did not get anywhere neither with
> self-compilation nor with cross-compilation. I wrote Guido Guenther and he
> had said that he only tried to compile arcboot with gcc 2.95 and that gcc
> 3.x might have problems stripping some symbols that we want from the
> binary, while leaving the others, that we don't want... That would explain
> the factor 10 increase in the resulting file size and it's inability to do
> anything...
>
> So the thing is that the original arcboot 3.8.1 does not work for me if I
> compile (whereas the debian binary of the same version does), so it made no
> sense for me to try to apply your patch. I need to find a way to compile
> arcboot properly first. How do you do that yourself? Or do you think your
> fixes in makefiles make difference already? Actually, you've changed the
> LDFLAGS, which could be the problem... OK, I'll give it a try and let you
> know how it was.
>
> Regards,
> Max

-- 
Dr. Maxim Zaitsev
University Hospital Freiburg
Department of Diagnostic Radiology
Medical Physics
Hugstetterstr. 55
79106 Freiburg
Tel. (761) 270 3800
Fax. (761) 270 3831
