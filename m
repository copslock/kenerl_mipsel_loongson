Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jul 2014 05:05:37 +0200 (CEST)
Received: from mail-vc0-f179.google.com ([209.85.220.179]:53869 "EHLO
        mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861121AbaGGDFaoVGRW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Jul 2014 05:05:30 +0200
Received: by mail-vc0-f179.google.com with SMTP id id10so3402420vcb.10
        for <multiple recipients>; Sun, 06 Jul 2014 20:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BBZhBI2J+SUw5S+YAf1EOQ99L5eb4YKEchHatZrC46k=;
        b=ebznXQcPDtW0YupxNHzGGUXcjZnDmUh4J2NzZXe3G2Z/9KnCdGGHelcg36nLFuo6zK
         evus7qpjyE0GlxBN2SUD2JyiPHU4Lzzj/GJA4zDwJNSsNRJq78kf53MDhm1mo4+5Uuwp
         zYVJ0aMkKS1LYifzrRLHqxRxaVzFNCHobOaUeZLe8ifsCpzPDF6wD5UvptX9Cm52RWQM
         aFMT2xVS9137sN2vFXDaBvelVP/lakjNIEbw/GRJBPn96CUDV9Kq1l0QN7ACiv/qShby
         xoqdOJ8+r+OK4r2FvrL8JMH3Uuz3oXQqjsycfu9wmiMgfssadkkV4La2faT6mLCys/Ue
         AeSA==
MIME-Version: 1.0
X-Received: by 10.52.240.238 with SMTP id wd14mr300786vdc.56.1404702324428;
 Sun, 06 Jul 2014 20:05:24 -0700 (PDT)
Received: by 10.221.53.5 with HTTP; Sun, 6 Jul 2014 20:05:24 -0700 (PDT)
In-Reply-To: <20140706070814.GA8511@jayachandranc.netlogicmicro.com>
References: <1404528619-3715-1-git-send-email-xerofoify@gmail.com>
        <53B80EFC.6020504@infradead.org>
        <CAPDOMVid83VWT4n93MjvxoWdcq2KPYren0o5ubGi+9HHY6a7EQ@mail.gmail.com>
        <20140706070814.GA8511@jayachandranc.netlogicmicro.com>
Date:   Sun, 6 Jul 2014 23:05:24 -0400
Message-ID: <CAPDOMVi7Bj75GQ1zr7AoYHHz5-tDWMSvLnEGVHr7bNP5iZ-kFQ@mail.gmail.com>
Subject: Re: [PATCH] mips: Add #ifdef in file bridge.h
From:   Nick Krause <xerofoify@gmail.com>
To:     "Jayachandran C." <jchandra@broadcom.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, ralf@linux-mips.org,
        blogic@openwrt.org, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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

Would you like me to send a new patch fixing this issue? I misread the comment.
Cheers Nick


On Sun, Jul 6, 2014 at 3:08 AM, Jayachandran C. <jchandra@broadcom.com> wrote:
> On Sun, Jul 06, 2014 at 01:58:43AM -0400, Nick Krause wrote:
>> No I didn't I finally learned how to cross compile the kernel it's not
>> hard just have to find the docs for it :).
>> Cheers Nick
>
> There is already an ifdef in the right place in the file. There is not need
> to move it here as these macros are safe for assembly.
>
> The FIXME comment was a note to verfiy the Flash BAR address taken from the
> manual. Ideally, this has to be removed after checking it on hardware. Thanks
> for pointing this out.
>
> But the patch is incorrect and can be dropped.
>
>> On Sat, Jul 5, 2014 at 10:43 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> > On 07/04/2014 07:50 PM, Nicholas Krause wrote:
>> >> This patch addes a #ifdef __ASSEMBLY__ in order to check if this part
>> >> of the file is configured to fix this #ifdef block in bridge.h for mips.
>> >>
>> >> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
>> >> ---
>> >>  arch/mips/include/asm/netlogic/xlp-hal/bridge.h | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
>> >> index 3067f98..4f315c3 100644
>> >> --- a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
>> >> +++ b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
>> >> @@ -143,7 +143,7 @@
>> >>  #define BRIDGE_GIO_WEIGHT            0x2cb
>> >>  #define BRIDGE_FLASH_WEIGHT          0x2cc
>> >>
>> >> -/* FIXME verify */
>> >> +#ifdef __ASSEMBLY__
>> >>  #define BRIDGE_9XX_FLASH_BAR(i)              (0x11 + (i))
>> >>  #define BRIDGE_9XX_FLASH_BAR_LIMIT(i)        (0x15 + (i))
>> >>
>> >>
>> >
>> > Hi,
>> >
>> > Where is the corresponding #endif ?
>> > The #endif at line 185 goes with the #ifndef __ASSEMBLY__ at line 176.
>> >
>> > I think that this patch will cause a build error (or at least a warning).
>> > Did you test it?
>> >
>
> JC.
