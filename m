Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 16:28:49 +0200 (CEST)
Received: from mail-we0-f182.google.com ([74.125.82.182]:56705 "EHLO
        mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816417AbaFYO2rNLCxa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 16:28:47 +0200
Received: by mail-we0-f182.google.com with SMTP id q59so2072544wes.41
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 07:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5PnFaDypsAy9FlPtzZmIKiRGhXmp0RSP32bW9Xy+038=;
        b=EmObvPOxvsWX7pEf0i1PG342+/GGvRsgYH0vybaviXNTGhdVq4UjMpz9FcEaRtncGe
         yRH8bqauQIRkMdjMg2yB7tuI5hEk3UYc3tzbKl9//w3lVlqzxcHTME0XS3xSLSMvEyuJ
         JaRN3ijN+nOXWNMJQAKhdksv+frRjxLz+W2sG39zTpYRQ2one68wk3a0sAAcOE+sY9xa
         Q6JVSvDmMnqYLYah253mXt92t9QA5uvvFMhuXnTAXHiFeUX1ovXx2UrZAwtB3RH3wrdy
         c6RI5rDlsMvOIGoGprJRHu+QIwCO9TA59oyXSt7ouP7uSaYu4/8lLdWb+fZ/QYNJkCB0
         2FDQ==
X-Gm-Message-State: ALoCoQlAjaBsNBUOX4GikbfWgaFfCsq9PVl/FENRr3l1kzbQ0qIvdL/K1Vl0FPG6J75u3ZiPCd8t
MIME-Version: 1.0
X-Received: by 10.194.90.106 with SMTP id bv10mr10599259wjb.20.1403706519127;
 Wed, 25 Jun 2014 07:28:39 -0700 (PDT)
Received: by 10.194.121.228 with HTTP; Wed, 25 Jun 2014 07:28:39 -0700 (PDT)
In-Reply-To: <1403685578-25170-1-git-send-email-markos.chandras@imgtec.com>
References: <53AA85E8.5090403@imgtec.com>
        <1403685578-25170-1-git-send-email-markos.chandras@imgtec.com>
Date:   Wed, 25 Jun 2014 07:28:39 -0700
Message-ID: <CAMEtUuwzsWX=JR8PJo=MnX_KG8ActhDPju26wOO-9GUZPg_pwA@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] MIPS: bpf: Use 32 or 64-bit load instruction to
 load an address to register
From:   Alexei Starovoitov <ast@plumgrid.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ast@plumgrid.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ast@plumgrid.com
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

On Wed, Jun 25, 2014 at 1:39 AM, Markos Chandras
<markos.chandras@imgtec.com> wrote:
> When loading a pointer to register we need to use the appropriate
> 32 or 64bit instruction to preserve the pointers' top 32bits.
>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Daniel Borkmann <dborkman@redhat.com>
> Cc: Alexei Starovoitov <ast@plumgrid.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> Changes since v1:
> - Change function name to make it clear that we are loading a
> pointer to a register, not an address

Markos,

when you post v2, please refresh the whole series, add v2 to subject and repost
all patches from scratch.

Thanks
