Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 17:54:04 +0200 (CEST)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:53065 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823043Ab3I3Px5xq6hO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Sep 2013 17:53:57 +0200
Received: by mail-ie0-f181.google.com with SMTP id tp5so10849970ieb.12
        for <multiple recipients>; Mon, 30 Sep 2013 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=mQtbQng35R0acurKjjeR5qcrWaJLnXPxZWNSAvgMByo=;
        b=GsvTEO4R2S/0RxTbQbF+ouZc90un3chpurR7HEVicKDfr189KURied8sPU6XYlbyoh
         LDKEbVkitgj9ArUTZxMzBo8ktXmbwLjDobzqPhZk2V/KFI2Tmrs7Dr+eTJ1RFGoQ50au
         xlfVFVuMfhq9XJrWwAI2kfQ2ZX0qP93hjEfOLgTWtMbkMKy3s3DuyrKT9ZchI9ebKZS0
         yVjaGi3i2k+ft+euTupap2/WZmHQq4oY3m3UO6nY0fnTEEzM4SOqVqikItCvewcMsdoU
         5TO8SxdRuFgLFM71BQnZ+GsXjhp4UJWicKMvJlbhfW5Gnbr35B+3k4SCwmqtMKS8qY4f
         5QLQ==
X-Received: by 10.50.127.197 with SMTP id ni5mr14205883igb.54.1380556430988;
        Mon, 30 Sep 2013 08:53:50 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id yt10sm17317890igb.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 30 Sep 2013 08:53:50 -0700 (PDT)
Message-ID: <52499E8B.6000702@gmail.com>
Date:   Mon, 30 Sep 2013 08:53:47 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        linux-mips@linux-mips.org,
        Andrew Pinski <Andrew.Pinski@caviumnetworks.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: Issue with BUG() in asm-gemeric/bug.h if CONFIG_BUG=n
References: <20130930145630.GA14672@linux-mips.org>
In-Reply-To: <20130930145630.GA14672@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 09/30/2013 07:56 AM, Ralf Baechle wrote:
> Lately I received several patches for build issues that only strike if
> CONFIG_BUG is disabled.  Here's a test case extracted from one of them:
>
> /*
>   * Definition of BUG taken from asm-generic/bug.h for the CONFIG_BUG=n case
>   */
> #define BUG() 	do {} while(0)
>
> int foo(int arg)
> {
> 	int res;
>
> 	if (arg == 1)
> 		res = 23;
> 	else if (arg == 2)
> 		res = 42;
> 	else
> 		BUG();
>
> 	return res;
> }
>
> [ralf@h7 ~]$ gcc -O2 -Wall -c bug.c
> bug.c: In function ‘foo’:
> bug.c:17:2: warning: ‘res’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>    return res;
>    ^
>
> It's fairly obvious to see what's happening here - GCC doesn't know that
> the else case can not be reached, thus razorsharply concludes that res
> may be used uninitialized.
>
> There several locations where MIPS - possibly other architectures as well -
> is affected by this.
>
> I think the definition of BUG should be changed to something like
>
> #define BUG()	unreachable()
> 16304
> unreachable() will depending on the compiler being used, expand either
> into a call to __builtin_unreachable() or where that function is
> unavailable, into do {} while (1).

The *only* reason we have CONFIG_BUG=n is to reduce code size.

Sticking in that empty loop, negates the entire point.

IMHO: We should do one of:
  o Make CONFIG_BUG=y mandatory
  o Ignore the warnings.
  o Fix the warning sites so they quit Warning.

So I don't think the patch is really an improvement over the status quo.

David Daney

>
> __builtin_unreachable() was introduce for GCC 4.5.0.
>
> This means there'd be minor bloat for antique compilers - but probably
> even better code generation for compilers supporting __builtin_unreachable().
>
>    Ralf
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>
>   include/asm-generic/bug.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index 7d10f96..6f78771 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -108,7 +108,7 @@ extern void warn_slowpath_null(const char *file, const int line);
>
>   #else /* !CONFIG_BUG */
>   #ifndef HAVE_ARCH_BUG
> -#define BUG() do {} while(0)
> +#define BUG() unreachable()
>   #endif
>
>   #ifndef HAVE_ARCH_BUG_ON
>
> ----- End forwarded message -----
>
>    Ralf
>
