Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Dec 2016 16:37:17 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:46876 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992246AbcLKPhKc7mob (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Dec 2016 16:37:10 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 26888726
        for <linux-mips@linux-mips.org>;
        Sun, 11 Dec 2016 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=oUw6RO0UX7HRhuUEyScRuJoi9YI=; b=z8v+15
        S5JTFpeIMKhWcdq85WSo7F+AoSQXHMk+XMSp+KVfOoQJtdREHqvqiCvMQmyj7w/6
        jxjE95kM+0ZS2wieQhVkr3hCuUkU1lLgR1YZTYuHhiP4fIlTltmNhMUYfHlXExEl
        +iZxsJWTzQFuYrSmrDejQ25BTaQrMa8wiap1tw0ElO/RJB2VfaYL1h3vrBP3R/P3
        fvq6Jzv6aTlW1kggga6iAVPYXZUjUHY9Ypf4BB8BJxZMQlgLAiy5Bdx4NhEk7VCw
        yuD0iYJyVy5CekIU1bJ09soEE9p2/0HzYYFazoxcKNKeg657GwTdk3elHp4WXDYb
        t8L5cIEijb7KYV/g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1c583ea5 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Sun, 11 Dec 2016 15:31:07 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id g23so29254058wme.1
        for <linux-mips@linux-mips.org>; Sun, 11 Dec 2016 07:37:02 -0800 (PST)
X-Gm-Message-State: AKaTC02m4fjYbd7PuUSK96rs7+P5hIRwr9HtZbDXiYRy9BM7wrIwemKeLfKFW2LhOY6X1RB3MyxHZKSH0cVhPg==
X-Received: by 10.25.195.195 with SMTP id t186mr24334069lff.96.1481470620973;
 Sun, 11 Dec 2016 07:37:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.31.140 with HTTP; Sun, 11 Dec 2016 07:37:00 -0800 (PST)
In-Reply-To: <20161211153027.GD29761@lunn.ch>
References: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
 <095cac5b-b757-6f4a-e699-8eedf9ed7221@stressinduktion.org>
 <87vauvhwdu.fsf@alice.fifthhorseman.net> <CE942916-BF45-44CC-A5F5-3838CF9C93BC@danrl.com>
 <20161211071501.GA32621@kroah.com> <CAHmME9q5ifwwishXjXYE3J=sVeR4jYY9fLUgs_FHCP594EZr6g@mail.gmail.com>
 <20161211153027.GD29761@lunn.ch>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 11 Dec 2016 16:37:00 +0100
X-Gmail-Original-Message-ID: <CAHmME9qKiAb3s98=-5PRuBWyQYECq_U56jTODSyiU_A=cuwYHQ@mail.gmail.com>
Message-ID: <CAHmME9qKiAb3s98=-5PRuBWyQYECq_U56jTODSyiU_A=cuwYHQ@mail.gmail.com>
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-mips@linux-mips.org, Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Dan_L=C3=BCdtke?= <mail@danrl.com>,
        Willy Tarreau <w@1wt.eu>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Felix Fietkau <nbd@nbd.name>, Jiri Benc <jbenc@redhat.com>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jason@zx2c4.com
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

On Sun, Dec 11, 2016 at 4:30 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> I'm not a crypto expert, but does this not give you a helping hand in
> breaking the crypto? You know the plain text value of these bytes, and
> where they are in the encrypted text.

You also know with some probability that there's going to be an IP
header and a TCP header, each with predictable fields. Maybe you're
reasonably certain there's an HTTP header in there too. Gasp! But fear
not...

Symmetric ciphers are generally not considered secure if they fall to
what's called a "known plaintext attack". Fortunately, modern ciphers
like AES and ChaCha20 and most others that you're aware of are
generally believed to be secure against KPA.
