Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2016 15:11:12 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:47900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992279AbcJTNLFHd-vy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Oct 2016 15:11:05 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4246E3D970;
        Thu, 20 Oct 2016 13:10:58 +0000 (UTC)
Received: from potion (dhcp-1-100.brq.redhat.com [10.34.1.100])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u9KDAtmZ025142;
        Thu, 20 Oct 2016 09:10:55 -0400
Received: by potion (sSMTP sendmail emulation); Thu, 20 Oct 2016 15:10:54 +0200
Date:   Thu, 20 Oct 2016 15:10:54 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: MIPS: Add missing uaccess.h include
Message-ID: <20161020131054.GF8573@potion>
References: <d852b5f35e84e60c930589eeb14a6df21ea9b1cb.1476834183.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d852b5f35e84e60c930589eeb14a6df21ea9b1cb.1476834183.git-series.james.hogan@imgtec.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 20 Oct 2016 13:10:58 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkrcmar@redhat.com
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

2016-10-19 00:45+0100, James Hogan:
> MIPS KVM uses user memory accessors but mips.c doesn't directly include
> uaccess.h, so include it now.
> 
> This wasn't too much of a problem before v4.9-rc1 as asm/module.h
> included asm/uaccess.h, however since commit 29abfbd9cbba ("mips:
> separate extable.h, switch module.h to it") this is no longer the case.
> 
> This resulted in build failures when trace points were disabled, as
> trace/define_trace.h includes trace/trace_events.h only ifdef
> TRACEPOINTS_ENABLED, which goes on to include asm/uaccess.h via a couple
> of other headers.
> 
> Fixes: 29abfbd9cbba ("mips: separate extable.h, switch module.h to it")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> ---

We'd like to have this patch in 4.9-rc2 and I see it in kvm-mips/next.
Would you prefer to send a pull request?
(I can apply it directly just as well.)

Thanks.
