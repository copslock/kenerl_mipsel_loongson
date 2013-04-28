Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Apr 2013 12:25:14 +0200 (CEST)
Received: from mail-bk0-f51.google.com ([209.85.214.51]:47684 "EHLO
        mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827517Ab3D1KYlx6OVo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Apr 2013 12:24:41 +0200
Received: by mail-bk0-f51.google.com with SMTP id y7so1237625bkt.10
        for <linux-mips@linux-mips.org>; Sun, 28 Apr 2013 03:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:sender:x-originating-ip:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:x-gm-message-state;
        bh=kJKsLMEOHVL55LqF5yZhmvOisQMPtnBxcGgCFsizPjM=;
        b=DbTRUyXg9lndYRlrnDc9tmXXXnj5zTb+aqrbMWByiRrjb2vpEEidWUzVdH27OWH06Q
         8Nhxpl+Zoet6He88wDCx0TFTy3fKLVJfa1/Wjn8cbvvWTdNxEuPDyMZkbKBFlpcPFLJV
         92Q8vyaPC8QEfFRwXVl46yuD7fgEtugo7GS3x0tl7n4zs9nnGulWNGXNmuStrOInMc6v
         njtTlf94+5xXvdlWO3XP2NNZrHhGnLfKNq6wzB5lgivg4LKP38EnDYd7el6QsNB3CkMc
         q6OEI0ZmvBDHT72Hsof7vtcnCRQTD3XHsRp5pdLu7RD0pujVVcuzysTObx5zCDQRSHLX
         2gsQ==
MIME-Version: 1.0
X-Received: by 10.204.162.8 with SMTP id t8mr20269709bkx.95.1367144675877;
 Sun, 28 Apr 2013 03:24:35 -0700 (PDT)
Received: by 10.205.120.200 with HTTP; Sun, 28 Apr 2013 03:24:35 -0700 (PDT)
X-Originating-IP: [212.159.75.221]
In-Reply-To: <1367086831-10740-1-git-send-email-geert@linux-m68k.org>
References: <1367086831-10740-1-git-send-email-geert@linux-m68k.org>
Date:   Sun, 28 Apr 2013 11:24:35 +0100
X-Google-Sender-Auth: Kfgb-1Ul6dXXrwdYDTFJrHhVTf8
Message-ID: <CAAG0J982gbca3XHHSpTHgqPgeGyJRtG8Lm1cWsT0HsThqdFeMw@mail.gmail.com>
Subject: Re: [PATCH -next] ia64, metag: Do not export min_low_pfn in
 arch-specific code
From:   James Hogan <james.hogan@imgtec.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sanjay Lal <sanjayl@kymasys.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQl9c+EDgJJj3NEjm9rC600pUIhnlMBbvczC690hZ6ZLdBYEoTB3ZalUiN4TQdZU2mr20SvH
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 27 April 2013 19:20, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> As of commit 787dcbe6984b3638e94f60d807dcb51bb8a07211 ("MIPS: Export
> symbols used by KVM/MIPS module"), min_low_pfn is already exported by
> the generic mm/bootmem.c, causing:
>
> WARNING: vmlinux: 'min_low_pfn' exported twice. Previous export was in vmlinux
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

This has been pointed out several times and needs fixing in the mips
tree where the warning was introduced.

Acked-by: James Hogan <james.hogan@imgtec.com>

Cheers
James
