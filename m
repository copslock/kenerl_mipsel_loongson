Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2016 16:09:12 +0200 (CEST)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34382 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990516AbcISOJFrrh1O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Sep 2016 16:09:05 +0200
Received: by mail-wm0-f66.google.com with SMTP id l132so14014501wmf.1;
        Mon, 19 Sep 2016 07:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=dwfjyZSO9yb5IO95+6m2q6ov4pjYiHprYQeH5+HYsNk=;
        b=B6yE4SwfBV+Xc+2do1mpJ/dvoP74Eu/nWaXKCyDCIS8cT1xoeKfOYobE3Qg2/3l1V/
         K0cRJRHG5AbGWQUn3G+9oc8gJ6xsQ7YzPdtVIKYxfrrAmclFPsacWiuqeFmko/LdY6mu
         XSVZj4kLKe5OqZk2AHMb1f0hBMIoNLVWyW8QbEgGP30ljkhiATOaqLe7XcoPC7JgrqZn
         +IhHp3Zo3qT1Xj81WgpoPaCDi6Va8enQrPO6UEGbmNyKSeesRcT8BvEu8Ly+YTbMU0us
         BpdZSTV8+C+odfJ+4YzPhUHyNs3CyfBeMDiBhfN5Ntfu0m76Fmg3OnAKOIQeYkIyJdDG
         vYeg==
X-Gm-Message-State: AE9vXwO2kTjzcNZ+Wf1sDE+bVY3UYyw4vosSWEbdgesbGVaptP1SnwibK7mI7qXkNqEQzw==
X-Received: by 10.28.216.211 with SMTP id p202mr8991578wmg.85.1474294140460;
        Mon, 19 Sep 2016 07:09:00 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::19f? (f.9.1.0.0.0.0.0.0.0.0.0.a.a.a.a.5.8.d.a.7.2.e.2.0.4.2.4.1.0.a.2.v6.cust.nbox.cz. [2a01:4240:2e27:ad85:aaaa::19f])
        by smtp.gmail.com with ESMTPSA id 190sm22280385wmk.13.2016.09.19.07.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Sep 2016 07:08:59 -0700 (PDT)
Subject: Re: [PATCH BACKPORT 3.10-3.16] MIPS: KVM: Check for pfn noslot case
To:     James Hogan <james.hogan@imgtec.com>, stable@vger.kernel.org
References: <8d00898f91834454a4daf5c4944ddace9c6866f4.1473975914.git-series.james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <d8d671b3-5d53-3038-bf1c-a8dd9a002a76@suse.cz>
Date:   Mon, 19 Sep 2016 16:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <8d00898f91834454a4daf5c4944ddace9c6866f4.1473975914.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

On 09/15/2016, 11:51 PM, James Hogan wrote:
> commit ba913e4f72fc9cfd03dad968dfb110eb49211d80 upstream.
> 
> When mapping a page into the guest we error check using is_error_pfn(),
> however this doesn't detect a value of KVM_PFN_NOSLOT, indicating an
> error HVA for the page. This can only happen on MIPS right now due to
> unusual memslot management (e.g. being moved / removed / resized), or
> with an Enhanced Virtual Memory (EVA) configuration where the default
> KVM_HVA_ERR_* and kvm_is_error_hva() definitions are unsuitable (fixed
> in a later patch). This case will be treated as a pfn of zero, mapping
> the first page of physical memory into the guest.
> 
> It would appear the MIPS KVM port wasn't updated prior to being merged
> (in v3.10) to take commit 81c52c56e2b4 ("KVM: do not treat noslot pfn as
> a error pfn") into account (merged v3.8), which converted a bunch of
> is_error_pfn() calls to is_error_noslot_pfn(). Switch to using
> is_error_noslot_pfn() instead to catch this case properly.
> 
> Fixes: 858dd5d45733 ("KVM/MIPS32: MMU/TLB operations for the Guest.")

Applied to 3.12, thanks!

-- 
js
suse labs
