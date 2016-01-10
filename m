Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2016 22:53:58 +0100 (CET)
Received: from dub004-omc3s14.hotmail.com ([157.55.2.23]:54135 "EHLO
        DUB004-OMC3S14.hotmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006823AbcAJVx4cOwxG convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 10 Jan 2016 22:53:56 +0100
Received: from DUB128-W48 ([157.55.2.8]) by DUB004-OMC3S14.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
         Sun, 10 Jan 2016 13:53:51 -0800
X-TMN:  [Xq+JEUwQTbrCfGf1Jy73T9naD3G0aZh8]
X-Originating-Email: [dcb314@hotmail.com]
Message-ID: <DUB128-W482D8922008A1EB108523C9CC80@phx.gbl>
From:   David Binderman <dcb314@hotmail.com>
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: linux-4.4-rc8/arch/mips/include/asm/netlogic/xlr/fmn.h:304: bad
 test ?
Date:   Sun, 10 Jan 2016 21:53:50 +0000
Importance: Normal
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 10 Jan 2016 21:53:51.0141 (UTC) FILETIME=[643D8550:01D14BF1]
Return-Path: <dcb314@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dcb314@hotmail.com
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

Hello there,

[linux-4.4-rc8/arch/mips/include/asm/netlogic/xlr/fmn.h:304]: (style) Expression '(X & 0x2) == 0x1' is always false.

Source code is

    if ((status & 0x2) == 1)
            pr_info("Send pending fail!\n");

Maybe better code

    if ((status & 0x2) != 0)
            pr_info("Send pending fail!\n");

Regards

David Binderman

 		 	   		  
From julian.calaby@gmail.com Sun Jan 10 23:14:04 2016
Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2016 23:14:06 +0100 (CET)
Received: from mail-io0-f193.google.com ([209.85.223.193]:36378 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006823AbcAJWOE2pseG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Jan 2016 23:14:04 +0100
Received: by mail-io0-f193.google.com with SMTP id q21so24678174iod.3
        for <linux-mips@linux-mips.org>; Sun, 10 Jan 2016 14:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OH8bez7XmCnem729IgSvT5jpoWsMQTomdnpVes7+j2E=;
        b=x6gIXXE0Hh2kMuui2Sd/Jd5KZCRQCQhmNPZfkD+CtB23yOcNbIBQm5Gp9RQuSjYVJk
         yw4y/6PjYVgntsuPKXKdiU1sOyQ4O9Xc1axGg5ajcSAuzVXWkn4x6yDZRQLvRzUfnCeh
         xxD3sgl2RaAruY1945Taw+/Bvfkm5802aVfiYWu2cfSU/KvGQ+MHpfJDAcOYky9Q82Tf
         UzuU2HjgrYAEHaI+yvjnLPDz8TIJu0OVlyfC5piuY5hmLpJZZuIlZIfn44VMDOM1MqD9
         nGbPz+IpDyidTnf0dv4F5UAWlbiZvS/1SeTwqi0Cj3OyzOag3FTJdmBKtsuWthpfcIu7
         A25w==
X-Received: by 10.107.159.7 with SMTP id i7mr86780578ioe.29.1452464038417;
 Sun, 10 Jan 2016 14:13:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.111.1 with HTTP; Sun, 10 Jan 2016 14:13:39 -0800 (PST)
In-Reply-To: <1452454200-8844-4-git-send-email-mst@redhat.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com> <1452454200-8844-4-git-send-email-mst@redhat.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Mon, 11 Jan 2016 09:13:39 +1100
Message-ID: <CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] checkpatch: add virt barriers
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux <sparclinux@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Return-Path: <julian.calaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julian.calaby@gmail.com
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

Hi Michael,

On Mon, Jan 11, 2016 at 6:31 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Add virt_ barriers to list of barriers to check for
> presence of a comment.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 15cfca4..4466579 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5133,7 +5133,8 @@ sub process {
>                 }x;
>                 my $all_barriers = qr{
>                         $barriers|
> -                       smp_(?:$smp_barrier_stems)
> +                       smp_(?:$smp_barrier_stems)|
> +                       virt_(?:$smp_barrier_stems)

Sorry I'm late to the party here, but would it make sense to write this as:

(?:smp|virt)_(?:$smp_barrier_stems)

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
