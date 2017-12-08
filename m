Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 09:12:46 +0100 (CET)
Received: from mail-wm0-x22b.google.com ([IPv6:2a00:1450:400c:c09::22b]:33409
        "EHLO mail-wm0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990436AbdLHIMi4vpip (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 09:12:38 +0100
Received: by mail-wm0-x22b.google.com with SMTP id g130so3626976wme.0
        for <linux-mips@linux-mips.org>; Fri, 08 Dec 2017 00:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hbTjtLXMyGdHASw+frL8Eh9NUkCyqyWmqExHSARzwyM=;
        b=PCQBjGdkqVvZ4gEki7lfcsixmbH6FU1ZPnIXQkhBJ0qHjefvyOmDDBCxA4HoCbbEa0
         HI5uKzoeuL8KmUfXMUeZIywqrkRdg/CEiDaSlfXj+ThJcLjlyclhy/lowAZcE8FdMjvS
         MLhwCwWDQ3MQY4v4GcV9Qa9W0dv9SmRpMEg/jzldxPOeM+W5LgOMKu+VXYkGTvy/so30
         DLy0hyfkHHHAX8+y/eym3nhhco02JWt5/9rqp5QNMozdWdTlkzrT+Fsxlsce65vOjgSn
         iZp4eCVyXvcdpdxrOk5TIjtzWbmL43n+S0/WHHQEysuEyNzbV27khG2y+tqiqjnp7qY1
         JbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hbTjtLXMyGdHASw+frL8Eh9NUkCyqyWmqExHSARzwyM=;
        b=WUrn+K3mWpPJrwuePSsYtBz/LMpvTRA36C48UDPBE8VzYjRzE/mTgmfHBz19RL8zJI
         HATwu6R4xgoDpoPBCDsCMJXIkN/PeRWe8Npf7PqXEd9ZYfTBBih6uo2DNt3ek9rTNB6Y
         7lqXzYcbY3xeVahrcb7OuTg0PTLrYvAKVab+yvexvdVoR4cTb/L4W8hEFlW2GygrNY1w
         Q64b9fxaob0W8GYpmtvmhtJYWshv1ogMwIB80BCFlxrQCf2UHzwN6bRJJ/Co80WbIySV
         CHJ85yJWRG/d5Oi9YOXMact8BwzTNLACeaawGDo8eccV4DsAaC+95xEQZD336WAFjOHp
         Hn4g==
X-Gm-Message-State: AKGB3mIkIDbRP/VHr8aNK5OV7tnKw/3h2HyMxkJ5SF200MMBb9dpyAMZ
        wVeMNVG3h5t6ycw2QD6OI4sizt4JPpphtzIkvHoxTQ==
X-Google-Smtp-Source: AGs4zMZl6KNb77iaIjFH+qcJs2amKaLE4c4MRr5fG38Xbr/5si1LsvCf1r5+51NeO+3ik4L2DlOZhXnl3imWMWmI6jA=
X-Received: by 10.28.207.8 with SMTP id f8mr3065636wmg.30.1512720753373; Fri,
 08 Dec 2017 00:12:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.157.195 with HTTP; Fri, 8 Dec 2017 00:11:52 -0800 (PST)
In-Reply-To: <20171208000934.6554-1-david.daney@cavium.com>
References: <20171208000934.6554-1-david.daney@cavium.com>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Fri, 8 Dec 2017 09:11:52 +0100
Message-ID: <CAOFm3uFscCTLtgLym+STepZc9eWB3=jPjYu8+=1WcA3HoW08-A@mail.gmail.com>
Subject: Re: [PATCH v6 net-next,mips 0/7] Cavium OCTEON-III network driver.
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <pombredanne@nexb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pombredanne@nexb.com
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

David,

On Fri, Dec 8, 2017 at 1:09 AM, David Daney <david.daney@cavium.com> wrote:
[]
> Changes in v5:
[]
> o Removed redundant licensing text boilerplate.

Thank you very much!

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

-- 
Cordially
Philippe Ombredanne, the licensing scruffy
