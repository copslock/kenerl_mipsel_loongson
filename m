Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2017 19:13:45 +0100 (CET)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:34117
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993874AbdAYSNjKMJCG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2017 19:13:39 +0100
Received: by mail-it0-x241.google.com with SMTP id o185so2800252itb.1;
        Wed, 25 Jan 2017 10:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OzoZ/7XbF7k3A+GGoE5ZUDK6/hbGVa+SjMMPYlKqtY4=;
        b=FN3FKVM3o3Yjx/KoymYs66VML9/JUH2LmqBBPzj/v3mUVBcU2XH3Tviqnl3ziUBD29
         A3baz/sv3vB8VTwsNllcdPwBoKAW64wGtTxZREcTpydpWdjtvFjn0PJ2e4n721roHbbt
         XnXqKkB9RaQ9RVsf9gnecaH/aEWt5fiwn1qokPOkW8Cx+j+bwA6PWpzN4yEWGMOXKrRx
         aod32JlywWt0smMP71DBFgRPaoNx0o5iGDwE+y4xpTyAciYusVRVDa43qqd7LTvFv6+2
         PgyQ2ZLHxtM+HRFxqf6X5WOwtFWodIBhZb2mcrV7zdiDA1siyC/k+b9CjUhjcLeOrHBq
         IiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OzoZ/7XbF7k3A+GGoE5ZUDK6/hbGVa+SjMMPYlKqtY4=;
        b=gyPjFIyQCcP5fFyO24MfHap9IWC3OthO/v5AuKW/q/C4YhC0LXX0LgVqQqNmRexDR0
         l286CRtxAQLEkpCDI7MfKXhfymZetFDZAPPMiBjK/7W8UCTwJBzYVS3kE2Rm+s6sZJju
         QY/LC3gpPFxr0RwG7UZfb7djP1thuh6ye1agASX5s5YHVuflVuOrdQMXu33hQzkcSYVj
         8qtRqdY59Fi+crRldqXYey6ZB3otHY5cWJVJFkxEJUdjNycZ1gE85DbGs20HE5B3tt7j
         KrMHyqlAxlGfJ7MekOOkQ+XMdOvN1fjZ1ZjRON5reYyw12I4YM1jzoFSmDrQrNfAssUh
         rvWg==
X-Gm-Message-State: AIkVDXJTOabA5f0g1Feg6TgpcQSWgrzZHmDCbgbr5VkimQonnfOE7dLWdrQoejsT35ZsYBDHwbgY5l787xHCng==
X-Received: by 10.36.65.105 with SMTP id x102mr24551901ita.32.1485368013365;
 Wed, 25 Jan 2017 10:13:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.36.69.41 with HTTP; Wed, 25 Jan 2017 10:13:32 -0800 (PST)
In-Reply-To: <CAEbrdOCo9DeOa=rXYBxCEERNu_Cq=7N+5dDOwLwuZy87D3M6bA@mail.gmail.com>
References: <CAEbrdOCo9DeOa=rXYBxCEERNu_Cq=7N+5dDOwLwuZy87D3M6bA@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 25 Jan 2017 10:13:32 -0800
Message-ID: <CAKgT0UdBkqsUmp5y2d4fbi4MopW=6rxge_YzAwVvaKCqLj11_Q@mail.gmail.com>
Subject: Re: [Bug fix]mips 64bits checksum error -- csum_tcpudp_nofold
To:     Mark Zhang <bomb.zhang@gmail.com>
Cc:     ralf@linux-mips.org, David Miller <davem@davemloft.net>,
        Alexander Duyck <aduyck@mirantis.com>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <alexander.duyck@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.duyck@gmail.com
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

On Tue, Jan 24, 2017 at 8:35 PM, Mark Zhang <bomb.zhang@gmail.com> wrote:
> If the input parameters as saddr = 0xc0a8fd60,daddr = 0xc0a8fda1,len =
> 80, proto = 17, sum =0x7eae049d.
> The correct result should be 1, but original function return 0.
>
> Attached the correction patch.

I've copied your patch here:
