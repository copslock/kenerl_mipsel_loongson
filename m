Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2015 09:59:39 +0200 (CEST)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35188 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007058AbbEYH7fU2hQk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 May 2015 09:59:35 +0200
Received: by pdea3 with SMTP id a3so64972668pde.2
        for <linux-mips@linux-mips.org>; Mon, 25 May 2015 00:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4M/S/QFrtu7g+q4nPZcfmDncun1+8gaMO/ZoK8/wk9A=;
        b=GpdoSFPyIFsk7d4i3bVPDsAKtDLWxenNjLmy9Agp3HKOKW6cQT3lY+HxclsSr8BqNR
         YNEOBazE297foak22FG0HYXg8PwwhfClv7gDIl7dmlOdBdUivpB+y1MDgENSMMErQRoW
         2TsYFTkNAwkyOZ4sS3bGeEkcAnXjosa6J1eG0mjN0QvqYaRW+cUKKG1/rYD/a77To7eH
         z2cWkTeC0R1KjsFwMShcBhFhwLjgwYHrG8v1QyHXaAWa9aT0FoR4yAq+WjorABBSAttJ
         w4FBKy2mAU+b4vZR1blMgyU1QxlT80+o8l8BWlPi3qMgkiKS2MVelfhVqo2Af+UDQKt+
         711A==
X-Gm-Message-State: ALoCoQmo8teH9c3FdIfwZ8h03quObLM92UBCURWjzTbOZ4/aqPxFBMDcEBab4/XASI+N7YGY76/Q
MIME-Version: 1.0
X-Received: by 10.68.68.166 with SMTP id x6mr37286586pbt.161.1432540771558;
 Mon, 25 May 2015 00:59:31 -0700 (PDT)
Received: by 10.66.135.44 with HTTP; Mon, 25 May 2015 00:59:31 -0700 (PDT)
X-Originating-IP: [153.142.246.119]
In-Reply-To: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
Date:   Mon, 25 May 2015 02:59:31 -0500
Message-ID: <CAOS_Y6TRN2b5PGxWdO6SD5W2Wmo33Z88DeHw7Jrxw4TzzVYLcA@mail.gmail.com>
Subject: Re: [PATCH 00/15] MIPS Malta DT Conversion
From:   Rob Landley <rob@landley.net>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, Jiri Slaby <jslaby@suse.cz>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Hannes Reinecke <hare@suse.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        linux-serial@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        Christoph Hellwig <hch@lst.de>, Michal Marek <mmarek@suse.cz>,
        Jason Cooper <jason@lakedaemon.net>,
        "David S. Miller" <davem@davemloft.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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

On Fri, May 22, 2015 at 10:50 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> This series begins converting the MIPS Malta board to use device tree,
> which is done with a few goals in mind:
>
>   - To modernise the Malta board support, providing a cleaner example to
>     people referencing it when bringing up new boards and reducing the
>     amount of code they need to write.
>
>   - To make the code at the board level more generic with the eventual
>     aim of sharing it between multiple boards & allowing for
>     multi-platform kernel binaries. Although this series doesn't result
>     in the kernel reaching those goals, it is a step in that direction.
>
>   - To result in a more maintainable kernel through a combination of the
>     above.

How would I go about testing this under qemu?

(Especially the "more than 256 megs ram" part. :)

Rob
