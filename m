Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 16:09:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36220 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992160AbcJMOJAx0fY2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2016 16:09:00 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 37CD441F8E0D;
        Thu, 13 Oct 2016 15:08:37 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 13 Oct 2016 15:08:37 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 13 Oct 2016 15:08:37 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 58117CA1BD177;
        Thu, 13 Oct 2016 15:08:50 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 13 Oct 2016
 15:08:53 +0100
Received: from np-p-burton.localnet (10.100.200.229) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 13 Oct
 2016 15:08:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] MIPS: Enable hardened usercopy
Date:   Thu, 13 Oct 2016 15:08:46 +0100
Message-ID: <33584114.GQq7GNxjzm@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.1 (Linux/4.7.6-1-ARCH; KDE/5.26.0; x86_64; ; )
In-Reply-To: <CAGXu5jLZjFu_Mg93bzu0WBPwNVLuqmiNQ7O4Gpo4NaDn=yO_PQ@mail.gmail.com>
References: <20161008214714.5375-1-paul.burton@imgtec.com> <20161010132642.GA8229@linux-mips.org> <CAGXu5jLZjFu_Mg93bzu0WBPwNVLuqmiNQ7O4Gpo4NaDn=yO_PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1476398034.8NkuqA0XUW";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.229]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55421
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

--nextPart1476398034.8NkuqA0XUW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 12 October 2016 23:36:28 BST Kees Cook wrote:
> On Mon, Oct 10, 2016 at 6:26 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Sat, Oct 08, 2016 at 10:47:14PM +0100, Paul Burton wrote:
> >> Enable CONFIG_HARDENED_USERCOPY checks for MIPS, calling check_object
> >> size in all of copy_{to,from}_user(), __copy_{to,from}_user() &
> >> __copy_{to,from}_user_inatomic().
> 
> Awesome! Thanks for hooking this up. (Were you able to test with
> lkdtm's usercopy tests?)

Hi Kees,

Yes - they successfully failed with a v4.8-based kernel, except for the stack 
ones (because we don't yet have arch_within_stack_frames, which looks to be 
true of everyone but x86) and the heap flags ones, which I gather from your 
blog post[1] isn't expected to fail yet.

[1] https://outflux.net/blog/archives/2016/10/04/security-things-in-linux-v4-8/

Thanks,
    Paul
--nextPart1476398034.8NkuqA0XUW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJX/5VuAAoJEIIg2fppPBxlloEP/jqC23gvGqh1QEmoO4m8GCgr
4Ixh0EoWTzDIFfxVSUcPVfxKeUBBARSl0XJhI65OlpdJXlpaTi0cuRlaqOvUSwvj
RTi9Uy7NkpWtdgWrswI0NF5ej3TVG3GfSgdZTEfhxyQETLfJ7y/nNS1KlWna6aaN
G53GI86msq0IZ+3F9wBVdFfcIIUdHAjJqGI2+x/JvLL8krhNGAcRzHnBFlU4cBbP
QfKRAz4Wz24dpWyazMNNQ2thWfARa8Wkc68I+inRm1cz9PoOPjRCLKvQL7KlKDDs
Y4S+BRg2Yit+uol8PsCukUtUWsRHdv9bPBmbVox6Jz+q8II7nqvXhIRJszWpBHpY
G0gtWtVx4SRBdG4oZf0aNoqZpO1oTplQoI4Vl3fpc3MmX1PCyMBjVykm7U1Mc/Z2
NaZEynih1otWrH1UgW8fJNfBJUkAk6xZQrRcTMPoWfqbnGjAJOZnkOzrcmzAKpD0
FmF3fH2tO2j5+Ja3YUy9tisVsciqrve1tfdBuUH7LLU1c5BFV5pwnQhzCWJrElN9
u+PjnQAzogw74HMilkmBORXY58NlBHxPHz6j8egEc2CbQqpM9Y5/nMtMXgkd7nY4
SWqrYuPGdAK4IP3nc7/PfGbRWlhvk/giD0HILPXDUcGKNK6FbYrXyWSxb6S/ZpxT
i2p/ShlbNe2iiZGM3gWO
=Rnvz
-----END PGP SIGNATURE-----

--nextPart1476398034.8NkuqA0XUW--
