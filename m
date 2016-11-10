Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 18:37:32 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:41826 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993097AbcKJRhWwduNO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2016 18:37:22 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id dcc666eb
        for <linux-mips@linux-mips.org>;
        Thu, 10 Nov 2016 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=QR04pI6CHcVu50Tes2yTTAdzgi0=; b=iIjtdg
        uMh1aOInE+s8iY7c04Cb3ZMBqagnBF6V6BUzyf2c1nGoDATk/bvJ6KCTIYzkQWoI
        Zcx3hr2IkTCsSXXKmeNetVqsaB/is0OG5AnT7MCHCQ9+bPy/s9hI/Z5NefHzXyGQ
        3oeit49H/woDIHgAxx8N6PfRLzOj8ZXd5SqB5BjrodZBkHmV5/1r8uC8KQ3x2Hdd
        2NwEzALKqoU63dn+otKRM0D1kct72dNHObekxXGjPfNxK4ToAmyg4EwS4wudSbCE
        ffwRhFgFUYEUT/lQuCHfWmZRzPetKrcJn7kzi5CcvVV05dCPJNPJg8BwdpNbTxdS
        WVSCm8k+i8vceb0Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fb3cac1f (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Thu, 10 Nov 2016 17:35:06 +0000 (UTC)
Received: by mail-lf0-f51.google.com with SMTP id o141so123505429lff.1
        for <linux-mips@linux-mips.org>; Thu, 10 Nov 2016 09:37:13 -0800 (PST)
X-Gm-Message-State: ABUngvd/pu7ebWmhmICx13yftx9EwcCrOXU9qucuyeV48txVRsXsZfb2B5tG64v+6tUhO3XMORNiYSWdbGSuFA==
X-Received: by 10.25.92.74 with SMTP id q71mr3946479lfb.140.1478799431178;
 Thu, 10 Nov 2016 09:37:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.208.80 with HTTP; Thu, 10 Nov 2016 09:37:10 -0800 (PST)
In-Reply-To: <db056fb5-82b3-c17e-46ce-263872ef7334@imgtec.com>
References: <CAHmME9oSUcAXVMhpLt0bqa9DKHE8rd3u+3JDb_wgviZnOpP7JA@mail.gmail.com>
 <alpine.DEB.2.20.1611092227200.3501@nanos> <CAHmME9pGoRogjHSSy-G-sB4-cHMGcjCeW9PSrNw1h5FsKzfWAw@mail.gmail.com>
 <alpine.DEB.2.20.1611100959040.3501@nanos> <CAHmME9pHYA82M3iDNfDtDE96gFaZORSsEAn_KnePd3rhFioqHQ@mail.gmail.com>
 <db056fb5-82b3-c17e-46ce-263872ef7334@imgtec.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 10 Nov 2016 18:37:10 +0100
X-Gmail-Original-Message-ID: <CAHmME9ooeH2Qdu3zVS-_i_9_3AR0bDrEe_8+D3FS7E7NvMLG-Q@mail.gmail.com>
Message-ID: <CAHmME9ooeH2Qdu3zVS-_i_9_3AR0bDrEe_8+D3FS7E7NvMLG-Q@mail.gmail.com>
Subject: Re: Proposal: HAVE_SEPARATE_IRQ_STACK?
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org,
        WireGuard mailing list <wireguard@lists.zx2c4.com>,
        k@vodka.home.kg
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55776
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

Hi Matt,

On Thu, Nov 10, 2016 at 5:36 PM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
>
> I don't see a reason not to do this - I'm taking a look into it.

Great thanks! This is good to hear. If you go into the arch/ directory
and simply grep for "irq_stack", you can pretty easily base your
implementation on a variety of other architectures' implementations.

Jason
