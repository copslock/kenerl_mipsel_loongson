Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 03:42:05 +0200 (CEST)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37789 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006537AbaHZBmEB0Ewo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 03:42:04 +0200
Received: by mail-ig0-f171.google.com with SMTP id l13so3766329iga.16
        for <multiple recipients>; Mon, 25 Aug 2014 18:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LgEzLnOm96sTC70u03gbRitahTbtIvGvYYSa5z+5eDw=;
        b=ZY+dnKeSo+eVZ3en7lzr4Aw2Q8rmqXU7Qh/KlMzmePYhR8gZXeDSwu3AYG5aQFgjj7
         TM8RIE7bD4ghgOmJTwEz8Fz61YfOPLnbSETMQE9ZI5PzSu6/Kv+iKTr757z1mMLFXYXb
         +NGxf3/z5490mk4dhV1WiMpkMqKIeS9vNA9mfZehnNF7zczkO+JzwGJ08UdgnnE7cGGn
         mM2x4gI46ZAsknr5kDZmvXDudQE5HZb3/8x+osBdYR2/PaNH/SE7hlT+zB46zuM170Ej
         Sz52Lm47G55xPb4lYdUWE7w5xyYrkUlbK5bk0IwpMLyA0lgVg9/o4hcyq9NIRedhgmU3
         i6Rw==
X-Received: by 10.50.13.106 with SMTP id g10mr19318893igc.45.1409017317665;
 Mon, 25 Aug 2014 18:41:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.201 with HTTP; Mon, 25 Aug 2014 18:41:37 -0700 (PDT)
In-Reply-To: <CAGXxSxXGpRBJm+8sYfYXN4-20OYdmJ4FgBDnPknv9uMBN9zBsQ@mail.gmail.com>
References: <CAGXxSxXGpRBJm+8sYfYXN4-20OYdmJ4FgBDnPknv9uMBN9zBsQ@mail.gmail.com>
From:   cee1 <fykcee1@gmail.com>
Date:   Tue, 26 Aug 2014 09:41:37 +0800
Message-ID: <CAGXxSxXXvv5b-DY4ss1ozPPB9fwZ+qws7XBbhz3Gcf9U7=n2Dg@mail.gmail.com>
Subject: Re: Status about csum_partial optimization patches.
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        huacai chen <chenhuacai@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        markos.chandras@imgtec.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fykcee1@gmail.com
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

2014-07-31 10:55 GMT+08:00 cee1 <fykcee1@gmail.com>:
> Hi all,
>
> The csum_partial optimization patches have resided at patch-work for
> quite a while:
> 1. http://patchwork.linux-mips.org/patch/6988/
> 2. http://patchwork.linux-mips.org/patch/7176/
Patch 2 has already been merged, "commit
e309a3850f2e0fd9decd1be4ee778fa0b995202e -- MIPS: Use WSBH/DSBH/DSHD
on Loongson 3A"


>
> Any comments about patch 1, can it be merged?
In patch 1, the typical adjustment is as following:

""" /* original */
ADDC(sum, t0)
ADDC(sum, t1)
"""

Is replaced with
"""
ADDC(t0, t1)
ADDC(sum, t0)
"""

Hence, it needs to prove "sum ADDC t0 ADDC t1" is equal to "sum ADDC
(t0 ADDC t1)", I've added the explanation in
http://www.linux-mips.org/archives/linux-mips/2014-08/msg00124.html.



-- 
Regards,

- cee1
