Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 11:40:13 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35330 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993207AbcHRJkHWN3eP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 11:40:07 +0200
Received: by mail-wm0-f68.google.com with SMTP id i5so4448609wmg.2;
        Thu, 18 Aug 2016 02:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=P3prpvUkh0B49YJTh38DhMilPt12iPRC2irG53c7FF8=;
        b=RHlCqoDQiDrCXecrFTAtWCP3RGHsfuiDFUs2Fqc38xmiUXKeUKWCeGtgFJcZQBiDh8
         tCWFKQmYG927DlQVjZDt3VcapeUC0iTqLIJKl+Naz8FMQ7sD3PgGr2EKu+MAu7nEcKVj
         FdYN0DV4JLOjDCpnh+fW+outxhphtzdD7uvmYuQtYq76TV4Qvw0mBaC2hIIcsIEibYTF
         qfSRa+Cs8UFfv8koGEI6CH5PWz4KfsjBY/2vbZWthXph8XOLDrl1FEolqcKj3MXPl7Fs
         fLwF2UfOhGquYF49ryGCDn4RQDkjSw6oc/8YK1zF1wPCr6yFxhW2REyecOpemjPKFi3Q
         L/AA==
X-Gm-Message-State: AEkooutQFT/lVbBYDrwkuYZa339W2OTpdZV+O1qPKihexi6kAE+P2Jof2wyiaYqW7hsDpA==
X-Received: by 10.28.214.130 with SMTP id n124mr1574607wmg.37.1471513202092;
        Thu, 18 Aug 2016 02:40:02 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::19f? (f.9.1.0.0.0.0.0.0.0.0.0.a.a.a.a.5.8.d.a.7.2.e.2.0.4.2.4.1.0.a.2.v6.cust.nbox.cz. [2a01:4240:2e27:ad85:aaaa::19f])
        by smtp.gmail.com with ESMTPSA id p71sm4341143wmf.9.2016.08.18.02.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2016 02:40:01 -0700 (PDT)
Subject: Re: [PATCH BACKPORT 3.10-3.15 0/4] MIPS: KVM: Fix MMU/TLB management
 issues
To:     James Hogan <james.hogan@imgtec.com>, stable@vger.kernel.org
References: <cover.04bc2e89e693aeb69bf6e36d1d7b18ffb591bd31.1471021142.git-series.james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <17ecba53-e7f7-c341-0522-74eec7d1ca56@suse.cz>
Date:   Thu, 18 Aug 2016 11:39:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <cover.04bc2e89e693aeb69bf6e36d1d7b18ffb591bd31.1471021142.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54595
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

On 08/18/2016, 11:22 AM, James Hogan wrote:
> These patches backport fixes for several issues in the management of
> MIPS KVM TLB faults to 3.15, and should apply back to 3.10 too.

Applied to 3.12, thanks!

-- 
js
suse labs
