Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 09:39:19 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:5351 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037662AbWJSIjQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 09:39:16 +0100
Received: by nf-out-0910.google.com with SMTP id l23so982677nfc
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2006 01:39:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=gAZ+D0sq2wL+l6YCz4rew3+6jhEQnsfpmQwrN7hnGdc4ye/yYffZ010ByHy062p2WzhcSlFC7CAvcy0LIG1gswd+BgXDV0+sppDPt+1ZUYUQmH8MkEryADuF+qF81Nx/CTC8ijnUbeKRWPF3E82q0W6c4H6jk+tty1gLjCVTvWw=
Received: by 10.49.94.20 with SMTP id w20mr5374626nfl;
        Thu, 19 Oct 2006 01:39:16 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id k9sm507077nfc.2006.10.19.01.39.15;
        Thu, 19 Oct 2006 01:39:16 -0700 (PDT)
Message-ID: <453739B2.1010705@innova-card.com>
Date:	Thu, 19 Oct 2006 10:39:14 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org, ths@networkno.de,
	linux-mips@linux-mips.org, fbuihuu@gmail.com
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
References: <11607431461469-git-send-email-fbuihuu@gmail.com>	<1160743146503-git-send-email-fbuihuu@gmail.com> <20061019.131352.41630930.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061019.131352.41630930.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 13 Oct 2006 14:39:05 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> +sanitize:
>> +		/*
>> +		 * Sanitize initrd addresses. For example firmware
>> +		 * can't guess if they need to pass them through
>> +		 * 64-bits values if the kernel has been built in pure
>> +		 * 32-bit. We need also to switch from KSEG0 to XKPHYS
>> +		 * addresses now, so the code can now safely use __pa().
>> +		 */
>> +		end = __pa(initrd_end);
>> +		initrd_end = (unsigned long)__va(end);
>> +		initrd_start = (unsigned long)__va(__pa(initrd_start));
> 
> At last I tested whole patchset on 64-bit and see this is not enough.
> 
> If I passed 0x000000008XXXXXXX instead of 0xffffffff8XXXXXXX to
> initrd_start and initrd_end, the result of __pa() is not what I
> wanted.  This is a proposal fix.
> 
> --- arch/mips/kernel/setup.c.orig	2006-10-19 11:31:12.000000000 +0900
> +++ arch/mips/kernel/setup.c	2006-10-19 13:06:39.000000000 +0900
> @@ -199,6 +199,14 @@
>  		 * 32-bit. We need also to switch from KSEG0 to XKPHYS
>  		 * addresses now, so the code can now safely use __pa().
>  		 */
> +#ifdef CONFIG_64BIT
> +		/* HACK: Guess if the sign extension was forgotten */
> +		if (initrd_start < XKPHYS) {
> +			initrd_end -= initrd_start;
> +			initrd_start = (int)initrd_start;
> +			initrd_end += initrd_start;
> +		}
> +#endif
 
BTW, what about this condition:

		if (initrd_start < PAGE_OFFSET) {
			...;
		}

that would work even on 32 bits kernel.

		Franck
