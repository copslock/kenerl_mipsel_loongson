Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 09:20:40 +0200 (CEST)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38648 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006999AbaIEHUjTmsuT convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Sep 2014 09:20:39 +0200
Received: by mail-ig0-f182.google.com with SMTP id a13so2563109igq.3
        for <multiple recipients>; Fri, 05 Sep 2014 00:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=OUiHWrc5Va/V007XLUnyezw6wOO7W6eI4IfNHYdBC7A=;
        b=ciZC9oMUEVTB0SbgvvyjwLFYLpqdDV4ReLJ3gNBdmyzZ2Hx4fQHh/SmOBF2YVHbC4m
         B8/3OTOP6WtIhEStfti+vCM1d+8+GNzVTpwT5os5jW5JMu1DHHsx2xhSJA7IHOz3VMH8
         gY3UYqE10OYbjhcEEUTE57DLlpUT/bkI4pgtNxaTh75SCgHeHC8W8zmC6fLKYJzgRfm9
         130ZxYPI56qg0v0/IrNmhAiLL1d7XxNrnZwktsYN6nGppMLCLx+0LCwEwp7Lu+4QX0We
         jGDAl1Xq5J96PBXpgeFrB+Xs5I8WXQ8OIUZMZtyXfoTs9xzFLCDBkYS1WhIQMNc9jNvw
         QrgQ==
MIME-Version: 1.0
X-Received: by 10.51.17.2 with SMTP id ga2mr1683202igd.2.1409901632695; Fri,
 05 Sep 2014 00:20:32 -0700 (PDT)
Received: by 10.107.10.133 with HTTP; Fri, 5 Sep 2014 00:20:32 -0700 (PDT)
In-Reply-To: <20140905010124.15448.53707.stgit@linux-yegoshin>
References: <20140905010124.15448.53707.stgit@linux-yegoshin>
Date:   Fri, 5 Sep 2014 09:20:32 +0200
Message-ID: <CACna6rzPWU3t8-jNhYFeKRCYCNm8oYxf2Gm8s6mijP1qeX9xhg@mail.gmail.com>
Subject: Re: [PATCH 0/3] PTE formats changes
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>, yanh@lemote.com,
        Ralf Baechle <ralf@linux-mips.org>, alex.smith@imgtec.com,
        taohl@lemote.com, chenhc@lemote.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 5 September 2014 03:03, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com> wrote:
> The following series implements bugfix of PTE formats for swap and file entries
> and changes PTE bit position to fixed, which is more better for analysing of
> tracer and HW debugger logs.
>
> Hardcoded bits positions and offsets in PTE effectively causes a miss of
> relationship between PTE format for TLB and PTE formats for swap and file
> entries. This patch series introduces a symbolic relation between both and
> also fixes a current mismatch of formats. It can crash kernel or application
> in heavy paging environment.
>
> Fixed bit positions helps much in analysing of tracer and HW debugger logs and
> improves performance and code size a little due to absence of variable masks
> in kernel.

Well, this is definitely above my low-level-arch skills to review
this. FWIW kernel with these patches still boots on my BCM5357B0
(router with 32 MiB of RAM).

This pgtable* reminds me of highmem support for bcm47xx, unfortunately
I don't have any device with 256 MiB of RAM to test it.

-- 
Rafał
