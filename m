Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 14:26:18 +0100 (CET)
Received: from mail-wj0-x243.google.com ([IPv6:2a00:1450:400c:c01::243]:34853
        "EHLO mail-wj0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991532AbdBFN0LzQI0j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 14:26:11 +0100
Received: by mail-wj0-x243.google.com with SMTP id i7so2910569wjf.2;
        Mon, 06 Feb 2017 05:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=UnPz5wb2CWe9yyajiGM6Baf4NsKDpKG6N0EtatZ0lF0=;
        b=dGWLlsLaMVVQdW9nGUrob1X2OGxB344SQwV8NmU1e56PorhH4kwUC2wl8Td7ghZvkt
         MBbJd5oXKVIS89saNTGXyIgCKaN5iYwKe99bWNVHC3rCezxk0y9JW3FhZHt7i7M+aOOP
         eHNVPHyiJRuwsa7McNqB4QcCkpHX/gAY4e5fGdRi+mdobC/HJt6aXZfY1o/Ahhoqqw+C
         x65zo//0S5FEnZ3WuQcZ3QkHzzmsuYbvIp+cpnqXzUy82zSFGF0CSzsLmHElSYdN0Vae
         urPZZ90j9xIRqhRK+K24Pm8YWkt5wag3xeYzQf7djdtG9KGBmSRW9HwFD5lWeJWDI1O3
         FHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=UnPz5wb2CWe9yyajiGM6Baf4NsKDpKG6N0EtatZ0lF0=;
        b=k0o3m66n0RBilSa6eYfg9zpAqYAw4tKgeRLUx5xTAYXFkRYdJVdpjhBBB67eOuELYu
         hSUZD8Y3mk1SthyYkAWnG74BPGOW3lADYVCisAjZCB9GKhptuZQlVQFvDqS4c/3qr7QE
         DN+tlqM5o6G58cBebaq8PX5PSr6EkdKj8cBWuApkpww3cRonpKgg8QgwtUJM8S3LMT0B
         dXFpmn5CrMtSFcSwvO/3w2a3k5LJ/RBqVi9Rx65xwfR/WzaMDPv6rHDpUMhn2O29xgv/
         5ZAVKEPQIzNyjOTJBBaqHs8OqJykokjhgbXkIxI3Uqo5X/WeJoZVcv0v18EHiD8iL91s
         GItw==
X-Gm-Message-State: AIkVDXJyBrV2gsIqsxq8Y/Rm/mfDYYZoTw8HMEwYCO9eWwWUrLEVBwoLmFYjnap2IPF/Zg==
X-Received: by 10.223.128.5 with SMTP id 5mr9321562wrk.163.1486387566595;
        Mon, 06 Feb 2017 05:26:06 -0800 (PST)
Received: from [192.168.10.165] (94-39-187-56.adsl-ull.clienti.tiscali.it. [94.39.187.56])
        by smtp.googlemail.com with ESMTPSA id v67sm1434926wrc.45.2017.02.06.05.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2017 05:26:05 -0800 (PST)
Subject: Re: [PATCH 4/4] KVM: MIPS: Implement console output hypercall
To:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
References: <cover.3a9aba89648ae37be335c79cc2b18cf6bf57ef08.1486377433.git-series.james.hogan@imgtec.com>
 <7ae3d49bf9ce153a5460a393bfa513a585930487.1486377433.git-series.james.hogan@imgtec.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6ab68b3-4ef1-cb4c-494b-402d22185d27@redhat.com>
Date:   Mon, 6 Feb 2017 14:25:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <7ae3d49bf9ce153a5460a393bfa513a585930487.1486377433.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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



On 06/02/2017 11:46, James Hogan wrote:
> Documentation/virtual/kvm/api.txt seems to suggest that
> KVM_EXIT_HYPERCALL is obsolete. When it suggests using KVM_EXIT_MMIO,
> does it simply mean the guest should use MMIO to some virtio device of
> some sort rather than using hypercalls, or that the hypercall should
> somehow be munged into the mmio exit information?

The former.

But there are cases when using hypercalls is unavoidable.  In that case
the trend is to use other exit reasons than KVM_EXIT_HYPERCALL, such as
KVM_EXIT_PAPR_HCALL in PowerPC.  Feel free to add KVM_EXIT_MIPS_CONOUT
or something like that.

How would you find the character device to write to in QEMU?

Paolo
