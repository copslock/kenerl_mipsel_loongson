Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 07:29:29 +0100 (CET)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33193 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007231AbbCWG32BwYb8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Mar 2015 07:29:28 +0100
Received: by ignm3 with SMTP id m3so27178670ign.0;
        Sun, 22 Mar 2015 23:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=52NtNb41P06jTmPKAKYmXQbdTYcc4SgzIRVVr2lLGoA=;
        b=0rvcmUxUkKaGsUKfbCdcb3TiUnsxqh+iGCo8rocyUvZTxTbjXEEvi5If6ezR2uCPLz
         sRMyEGJobb5dKOWonJ9G1S3I6BMXYfvEkZS+PxIufhYwwn4ZtOCQMiaBzejr9olb7WrV
         NXYYoHGA57MbrtLL1g3BAV3mEFm/sFe1bZ6n3fAbl8/QaH2ffpr9oSm+qbK9mfK4zSpQ
         oUShKCz6FTvW9mjhUhMjljyVuOLkRnrTrewaasR/2asGdtSktyJ1MjfLZbnT8l2KvNq1
         JVpQARo61HIMrm8tL13aeqM0H68EAi7CC9F/6HnNm9YZfkKBbItaTWOCExDpU4jTZMtD
         APDg==
X-Received: by 10.107.132.158 with SMTP id o30mr129480015ioi.9.1427092162877;
 Sun, 22 Mar 2015 23:29:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.252.202 with HTTP; Sun, 22 Mar 2015 23:29:02 -0700 (PDT)
In-Reply-To: <1426213595-28454-1-git-send-email-chenhc@lemote.com>
References: <1426213595-28454-1-git-send-email-chenhc@lemote.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Mon, 23 Mar 2015 15:29:02 +0900
Message-ID: <CAAVeFuLytDZwo-=Q3DSxS7jLWbr4Jgf8BsBr9VGptBBu4SzZZg@mail.gmail.com>
Subject: Re: [PATCH V8 3/8] MIPS: Cleanup Loongson-2F's gpio driver
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gnurou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnurou@gmail.com
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

On Fri, Mar 13, 2015 at 11:26 AM, Huacai Chen <chenhc@lemote.com> wrote:
> This cleanup is prepare to move the driver to drivers/gpio. Custom
> definitions of gpio_get_value()/gpio_set_value() are dropped.

I suppose this is starting to look ok, at least patches 3, 4 and 5
which are of interest for GPIO. I wonder which tree they should be
merged through, MIPS or GPIO? Not seeing the rest of the series, I
cannot make a suggestion.
