Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 15:01:55 +0100 (CET)
Received: from mail-ig0-f169.google.com ([209.85.213.169]:39835 "EHLO
        mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013508AbaKMOBw72EAZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 15:01:52 +0100
Received: by mail-ig0-f169.google.com with SMTP id hn18so1230312igb.0
        for <multiple recipients>; Thu, 13 Nov 2014 06:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tCS1WBx4RpQzFQFn04IFzivLP/anSDC+ErNwuL37rs8=;
        b=z5I2CYdU+ta+1iv0fVltbZasyxgIHSzOwZ84l00D6Ii5obl4zyQiMA7sD3Xi/vPoZ4
         umZT5jQLiZVASKfFJ/weqxfC8gzkS+uU2+GTyVSGjxdUb9uaZwT4M4Rft5GJei8z1vLx
         XcMfssj9hqhv6vPIS9UrCKTYCSUIe3zKUntro7ARrxqg3oTYdAF2Alo1hOfhhAy1ayDO
         8VYYH2DB7axJXE4SfG/64sbMkQkPSUDzFSsGi0Q8yNk9FyGJG5j4mOnCCeI8vXfbxehW
         i0TJ43tZvwjZYcTKj97o5ITCP1Z1ngP8+u4gVdbu0//frYJg8XMCZFYP10779SRlpnLe
         X21w==
MIME-Version: 1.0
X-Received: by 10.107.17.77 with SMTP id z74mr1946123ioi.86.1415887307172;
 Thu, 13 Nov 2014 06:01:47 -0800 (PST)
Received: by 10.64.176.211 with HTTP; Thu, 13 Nov 2014 06:01:47 -0800 (PST)
In-Reply-To: <CAAVeFuJ1+y8wooVAHMST9zC4_Z8SE6x=VASsFkUwCVFcA8xuLg@mail.gmail.com>
References: <1415794700-7579-1-git-send-email-chenhc@lemote.com>
        <CAAVeFuJ1+y8wooVAHMST9zC4_Z8SE6x=VASsFkUwCVFcA8xuLg@mail.gmail.com>
Date:   Thu, 13 Nov 2014 22:01:47 +0800
X-Google-Sender-Auth: jR4wBtEPHD8NE7ZWmEnUZs0ZR1o
Message-ID: <CAAhV-H5ePQ8m5U_UvpDjMb2wS3cAK3ua+jLA_2A8XE=JfVyE7A@mail.gmail.com>
Subject: Re: [PATCH V3 2/5] MIPS: Loongson: Add Loongson-3A/3B GPIO support
From:   Huacai Chen <chenhc@lemote.com>
To:     Alexandre Courbot <gnurou@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Hongbing Hu <huhb@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

OK, I'll split.

Huacai

On Thu, Nov 13, 2014 at 2:26 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Wed, Nov 12, 2014 at 9:18 PM, Huacai Chen <chenhc@lemote.com> wrote:
>> Improve Loongson-2's GPIO driver to support Loongson-3A/3B, and move it
>> to drivers/gpio directory.
>
> Could you split this in two patches:
> 1/2: move GPIO driver to drivers/gpio
> 2/2: support new devices in GPIO driver
>
> and add the "-C" option to git format-patch so that file renaming gets
> detected. This will make the changes easier to evaluate.
>
> Thanks,
> Alex.
>
