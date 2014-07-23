Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 17:19:31 +0200 (CEST)
Received: from mail-vc0-f177.google.com ([209.85.220.177]:61534 "EHLO
        mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822058AbaGWPT30mqLd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 17:19:29 +0200
Received: by mail-vc0-f177.google.com with SMTP id hy4so2385516vcb.22
        for <multiple recipients>; Wed, 23 Jul 2014 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pEl/4Esc0EJVYYyhEWr2Wc9iywDcIRiIrzwP/vnFZdA=;
        b=W7WAeZ0VdvHc/E2GZH2Vcu51baKPpozuoo7xP0sXHBvsjxI0U1lUvFUecDebB22cyO
         bBkWw7pC3lfWp4gr54nF53zs1RWvi3hzs30RPhLG748LjmKMGuNaXh4pWJ62UWf70Z77
         hHGSKGBhRHVtIWyOloG1rBZ9CVkn5HOzRrnhX0Ys2SdNeaJuvkOBVpx8fPJxPt3f8Neo
         WHOCd1rHoZQaI+mdbHEKdj/96+8vaF2gQcD+5xMp/qif9EYmZuH8CsoonCGFdcg5eVZU
         6Te3l/jOCHKhNn1NtbveVbJgrfSpFaC7X3NJcvK2X71XDRTVNjbSxgxWR6fkuvsV8vo+
         CqXQ==
MIME-Version: 1.0
X-Received: by 10.53.9.234 with SMTP id dv10mr2711839vdd.56.1406128763157;
 Wed, 23 Jul 2014 08:19:23 -0700 (PDT)
Received: by 10.220.187.133 with HTTP; Wed, 23 Jul 2014 08:19:23 -0700 (PDT)
In-Reply-To: <20140723064657.GK30558@pburton-laptop>
References: <CAPDOMVjNyAwo53Coz8MFuUs70M7j1e3QWprus5vGpTfAw=hspg@mail.gmail.com>
        <20140723064657.GK30558@pburton-laptop>
Date:   Wed, 23 Jul 2014 11:19:23 -0400
Message-ID: <CAPDOMVg6qMBBaT5t8Cqu7NH7FZxs=-y2SZ9uBgYGv2tgBr3yvw@mail.gmail.com>
Subject: Re: smp-cmp.c: CDFIXMES
From:   Nick Krause <xerofoify@gmail.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>, markos.chandras@imgtec.com,
        Steven.Hill@imgtec.com, Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41548
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

On Wed, Jul 23, 2014 at 2:46 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> On Wed, Jul 23, 2014 at 12:40:59AM -0400, Nick Krause wrote:
>> Are the lines with  CDFIXME still needed? If not please tell me as I
>> will send in a patch removing these
>> two from this file in order to help you guys out :).
>> Cheers Nick
>
> Hi Nick,
>
> I imagine the only answer any of us can give you is "we don't know". If
> we did then we'd have removed the code or the comments already.
>
> Please do note that the smp-cmp.c file lives behind a Kconfig option
> that is now marked as deprecated, and that there is other work going on
> in areas related to clocksource & clock events on the applicable
> systems. So whilst someone could spend the time figuring out whether
> those lines are useful, I expect that cleaning up these old FIXMEs is
> not a particularly high priority for anyone right now.
>
> If you'll leave them alone for a while I expect they'll disappear one
> way or another in a few cycles time, along with the rest of the file.
>
> Thanks,
>     Paul


That's Ok Paul, just wanted to known when the file was going away as it seemed
old if you want help with this please let me known :).
Cheers Nick
