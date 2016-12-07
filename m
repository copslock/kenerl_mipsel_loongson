Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2016 19:54:30 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:60997 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993400AbcLGSyXC16EI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Dec 2016 19:54:23 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id f7eda06e
        for <linux-mips@linux-mips.org>;
        Wed, 7 Dec 2016 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=0EDwr+QhJsgGD6W5/KrORbxnZXM=; b=ZnyerV
        sc7JagEQNDUcwuyswX7fv/wm8JCe6orP7nc0JdfQS3EX9JXXM6/7ygcQ9goKB4gY
        Whu6wJ+pujLlL7C/fe/OEa3a5A012Q9JQugEqHdmEVmbW66J9em3wQkVBfy9zdyK
        wf8ggaiRNUifwR5JTG2rLkoag3RevznZ5g+q5JFAYQ3jkljNfiKBU2Mg2a+oMqnn
        qBlXtkFkf9Vj0sShhCC0ZIRpYX2fsZZcIQ8OvShnhpvcAQKy3m5t0q6Fm9CmZfws
        zbAGTc2M45umP8Ez1dwPhK9GNsixDDHpxUTBKzp52kxG09vLWF3HQOCgrKbueILC
        +8oXqOLPS7rNp4vg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 442df302 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Wed, 7 Dec 2016 18:48:48 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id f82so181853460wmf.1
        for <linux-mips@linux-mips.org>; Wed, 07 Dec 2016 10:54:15 -0800 (PST)
X-Gm-Message-State: AKaTC00eoMVEHOYgxYbqomlDjbdlfaS28CdAj+/1AJ41/twwNcm+zbJZrbjKAfqsncqIIXcds9iRE4W6fFGRsg==
X-Received: by 10.25.141.15 with SMTP id p15mr4543294lfd.140.1481136854271;
 Wed, 07 Dec 2016 10:54:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.215.12 with HTTP; Wed, 7 Dec 2016 10:54:12 -0800 (PST)
In-Reply-To: <20161207.135127.789629809982860453.davem@davemloft.net>
References: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
 <CAA93jw7hcmkcyD=t4VRrQFfHk+n+EkSVgY6KFDq0_-DGpMADYw@mail.gmail.com> <20161207.135127.789629809982860453.davem@davemloft.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 7 Dec 2016 19:54:12 +0100
X-Gmail-Original-Message-ID: <CAHmME9oLgjDA2F0gkFzHU2Es8-XCxQHRABS18OKF0EnZgt1=LQ@mail.gmail.com>
Message-ID: <CAHmME9oLgjDA2F0gkFzHU2Es8-XCxQHRABS18OKF0EnZgt1=LQ@mail.gmail.com>
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
To:     David Miller <davem@davemloft.net>
Cc:     Dave Taht <dave.taht@gmail.com>, Netdev <netdev@vger.kernel.org>,
        linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55961
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

On Wed, Dec 7, 2016 at 7:51 PM, David Miller <davem@davemloft.net> wrote:
> It's so much better to analyze properly where the misalignment comes from
> and address it at the source, as we have for various cases that trip up
> Sparc too.

That's sort of my attitude too, hence starting this thread. Any
pointers you have about this would be most welcome, so as not to
perpetuate what already seems like an issue in other parts of the
stack.
