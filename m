Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 12:37:07 +0200 (CEST)
Received: from mail-qt0-x233.google.com ([IPv6:2607:f8b0:400d:c0d::233]:36117
        "EHLO mail-qt0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990394AbeDPKhBHyS0k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2018 12:37:01 +0200
Received: by mail-qt0-x233.google.com with SMTP id y23so5139045qto.3
        for <linux-mips@linux-mips.org>; Mon, 16 Apr 2018 03:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9BwX0z5m0+Me1PKCv8twAbHnwNKsnJ4TjQE6R/gHuOk=;
        b=NPLvbV6v4KxBmUuc0d1d2KMsm9WN/OjSuL5/PNc4dr/nFfAngf9BvID4FW1+SZ9+S7
         VWw+4JplznMlsKenDVrr9ZZHPMcND/n9ZBDYwLbRUIMf91gczGtnWeV6NRTBSJbXvEXM
         AIM8XLd8KGJrvvB96KucuX5lLKEWSHq9Hr2I1ccAtsusbNgzV9Xx/jUsPdez0GpwlJ5c
         JSe/BbeHjzYHb/0giIqoWYZe46RSoAumL1bVGwEe0nTECAdXyI3lWwqQoVjGZyaU15A8
         Z7XVYt393XDFCOc7az85kZzIisi6+Lev7qb+/EtnTs4AlL6ylv6+ioNMNBK6+ifXX04R
         1lVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9BwX0z5m0+Me1PKCv8twAbHnwNKsnJ4TjQE6R/gHuOk=;
        b=gQWtit1ELAm2DnJ7aujBHSktcd+y9Mg+dU7YrLnkEaFP4cWSqgp2mNAWmpYHTXQqww
         US/yGQ/COCBo/gyeDgXeNViGi4YDVleyD69lt5cmaLgU7S18mlSYUES3t3+5uoy1Z8IK
         /xbehCyEPY2ezPLtFwcLjgaMVRwW/Biu+C/3881lUC8x7gocrHU6ECET8PNjDgX8MytS
         5kWJ55j5CV49b3UXWCWhVEqNR0c7e8B09wercYiy4NxxUPjzEyihbXmapWOnqL+Ss6qG
         dr+3IdOlLRFITS+Ix0UhIzy7Jm2pm/FgIMojhkRKl0tR0xa8ifDHWd2FJs93JVRmhjef
         AA3g==
X-Gm-Message-State: ALQs6tAyJxF8oOkK19fOE3V9p4eDj77U+V0RYFdb1DdVHO1XbHoT+oVb
        nUrS5gOJuyJ53DYAUU4aK5r5vnUO5NSpns0+64A=
X-Google-Smtp-Source: AIpwx48DmZyWQMvOoaxdRIHnkJH8Nw5mJVFoYnlkx/Dt5fiSgoMWvWe61nye+YOOpyHAjyGNIEWoUoyqaPzjjMjtlvE=
X-Received: by 10.200.47.26 with SMTP id j26mr15353356qta.185.1523875014775;
 Mon, 16 Apr 2018 03:36:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.25 with HTTP; Mon, 16 Apr 2018 03:36:53 -0700 (PDT)
In-Reply-To: <1523873626182117@kroah.com>
References: <1523873626182117@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Apr 2018 12:36:53 +0200
X-Google-Sender-Auth: 7MwgKF6P84jNfyvv1asy_qocAH0
Message-ID: <CAK8P3a3F=peEwRJP6iFfynK4WNZJSmU-bkwq8o-dnFRBkqn5Cw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] earlycon: add reg-offset to physical
 address before mapping" failed to apply to 4.9-stable tree
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     Greentime <greentime@andestech.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Mon, Apr 16, 2018 at 12:13 PM,  <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 4.9-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

I think we can do without it: there are only three machines that have
dt files with a reg-offset property in their uart:

- nds32 ae3xx was added in 4.17 and requires it there
- powerpc (virtex) has its own early console support and doesn't
  rely on earlycon.c
- mips (nexys4ddr) could use it, but has never made use of the
  earlycon driver in its DT files. It should now work out of the box
  in 4.17

       Arnd
