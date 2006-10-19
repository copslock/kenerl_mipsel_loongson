Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 07:37:36 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:55174 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20027692AbWJSGhd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 07:37:33 +0100
Received: by nf-out-0910.google.com with SMTP id l23so948605nfc
        for <linux-mips@linux-mips.org>; Wed, 18 Oct 2006 23:37:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c+x98QAy0UVixFvd4PI5AjXLu+eIpEbJWbPBq60jt2MS6fM6r+V9siX094gK3Hesn4TeS1YZpwssW9sMagS1nd6SGckaEDtCzFu582BZSQP63F0rRpus5N9S9iFBTpGGUbsu1if7581Ja6+NIQbevm5W+XzwgdLlWRhFOXdsNPU=
Received: by 10.78.193.19 with SMTP id q19mr11267268huf;
        Wed, 18 Oct 2006 23:37:32 -0700 (PDT)
Received: by 10.78.124.19 with HTTP; Wed, 18 Oct 2006 23:37:32 -0700 (PDT)
Message-ID: <cda58cb80610182337h611f1cf0vd489b5828dfd269f@mail.gmail.com>
Date:	Thu, 19 Oct 2006 08:37:32 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org
In-Reply-To: <20061019.131352.41630930.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11607431461469-git-send-email-fbuihuu@gmail.com>
	 <1160743146503-git-send-email-fbuihuu@gmail.com>
	 <20061019.131352.41630930.nemoto@toshiba-tops.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 10/19/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Fri, 13 Oct 2006 14:39:05 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > +             end = __pa(initrd_end);
> > +             initrd_end = (unsigned long)__va(end);
> > +             initrd_start = (unsigned long)__va(__pa(initrd_start));
>
> At last I tested whole patchset on 64-bit and see this is not enough.

Thanks for testing. You're right this is not enough since CPHYSADDR()
is not used anymore by __pa(). That shows that usage of __va(__pa(x))
construction to sanitize sign extension was weak since it relied on
__pa() implementation. My own fault...

>
> If I passed 0x000000008XXXXXXX instead of 0xffffffff8XXXXXXX to
> initrd_start and initrd_end, the result of __pa() is not what I
> wanted.  This is a proposal fix.
>

I would rather move this fix into initrd start setup function as it
was done by old code. We know that some bootloaders forget sign
extension on 64 bits kernel. But if for example the sign extension is
forgotten by a board specific code, we shouldn't automatically fix the
mistake, but rather fix the board specific code. So I would do instead
of your fix:

> --- arch/mips/kernel/setup.c.orig       2006-10-19 11:31:12.000000000 +0900
> +++ arch/mips/kernel/setup.c    2006-10-19 13:06:39.000000000 +0900
> @@ -199,6 +199,14 @@
>                  * 32-bit. We need also to switch from KSEG0 to XKPHYS
>                  * addresses now, so the code can now safely use __pa().
>                  */
> +#ifdef CONFIG_64BIT
> +               if (initrd_start < XKPHYS)
> +                       panic("initrd start (%08lx) < XKPHYS", initrd_start);
> +#endif

-- 
               Franck
