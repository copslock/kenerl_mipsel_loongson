Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 03:32:15 +0100 (CET)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:42349
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992212AbeB1CcDpk8Nk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 03:32:03 +0100
Received: by mail-pg0-x242.google.com with SMTP id y8so397085pgr.9
        for <linux-mips@linux-mips.org>; Tue, 27 Feb 2018 18:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jDE8pTQJYsrUdQq7HROFA8qzn0moT581Sssze1gd7ng=;
        b=u8WzbsgeiZaXKTTJD/UDDJNKr4GYmoxrY+HvftK+39yuKpdWJ3srRqFw92ASZl/lp0
         L1EclgGkZ1JJLvcsd+3r1Kr+7krcAUWplE+x16raz5WWawlTuYP0DF4HDi3kvu/Ej4n1
         rHaPrecqLTayBzmR5UCkDyusKvwX/sI26YxOejtzMOaXLeLI2uZ84dLk0+3VBeFrsJXO
         nSXhe0/YDBBwAv51XuniTIb/t+wh7Ph4noFOuOgWkc3N9+FXIj2I5XeaHHZvP2cprOGi
         /hbbMfBtCwkW24s/+VhgtmloIYwCriPsgfxNycSs0+2kpCrgNoorSyVvdfj14aWc9/41
         WKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jDE8pTQJYsrUdQq7HROFA8qzn0moT581Sssze1gd7ng=;
        b=ATooGteh92b5OpMafSoXh/ddyU+GQHs7sWQ9cF8N5YH2Sw2Qynoc8w4wtVxSsQh7D2
         eO+d1LEHAJIoauqFxJTRJv9BXWDArIEkSmuV4/OZHktJS3WfKMO1jgKwEYYfh9appwk/
         HpjMOD737lSy5+fHzz6+UJ7bk4S/Ctp/X+GEZUnl2AFSIMrRN/X9BAM+oLGbXmmIIxrt
         u9gTyx5b3Tjz3HG9FygvuELSByQHX9KO06BKjAjfQAErU0VE+hrZPIf6qYbyaF0mL6Y6
         Y8FXxHmFdmMj/jxmA/Yjg3P8dic91b5T5TzGlfooQ1jvPpTirjkmmlw7hwLrWfyq7gZH
         dS/w==
X-Gm-Message-State: APf1xPBYaLF7N7lNAEveGjHFKLFD6mnjyVzj4lRerdmJkf7eJ5Oml8hf
        xByGP4HlxgsxiphruTzemHg=
X-Google-Smtp-Source: AH8x226iFus/miQUgX+4R4SHgqs2O8wUqrc7sWPuBdTgvjKKuBauGggKbbxzS0JX/N44iPihnUX8UQ==
X-Received: by 10.98.210.70 with SMTP id c67mr16032822pfg.164.1519785116882;
        Tue, 27 Feb 2018 18:31:56 -0800 (PST)
Received: from simonLocalRHEL7.cn.ibm.com ([112.73.0.86])
        by smtp.gmail.com with ESMTPSA id i1sm714154pfi.116.2018.02.27.18.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 18:31:56 -0800 (PST)
From:   wei.guo.simon@gmail.com
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, Paolo Bonzini <pbonzini@redhat.com>,
        Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH] KVM: surround kvm_arch_vcpu_async_ioctl() with #ifdef
Date:   Wed, 28 Feb 2018 10:31:39 +0800
Message-Id: <1519785099-13808-1-git-send-email-wei.guo.simon@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Return-Path: <wei.guo.simon@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wei.guo.simon@gmail.com
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

From: Simon Guo <wei.guo.simon@gmail.com>

Although CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL is usually on, logically
kvm_arch_vcpu_async_ioctl() definition should be wrapped with
CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL #ifdef.

This patch adds the #ifdef surround.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/mips/kvm/mips.c       | 2 ++
 arch/powerpc/kvm/powerpc.c | 2 ++
 arch/s390/kvm/kvm-s390.c   | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 2549fdd..4d593e5 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -903,6 +903,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	return r;
 }
 
+#ifdef CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL
 long kvm_arch_vcpu_async_ioctl(struct file *filp, unsigned int ioctl,
 			       unsigned long arg)
 {
@@ -922,6 +923,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp, unsigned int ioctl,
 
 	return -ENOIOCTLCMD;
 }
+#endif
 
 long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
 			 unsigned long arg)
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 403e642..2adca3c 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1757,6 +1757,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	return -EINVAL;
 }
 
+#ifdef CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL
 long kvm_arch_vcpu_async_ioctl(struct file *filp,
 			       unsigned int ioctl, unsigned long arg)
 {
@@ -1771,6 +1772,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
 	}
 	return -ENOIOCTLCMD;
 }
+#endif
 
 long kvm_arch_vcpu_ioctl(struct file *filp,
                          unsigned int ioctl, unsigned long arg)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 77d7818..c499396 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3784,6 +3784,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
 	return r;
 }
 
+#ifdef CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL
 long kvm_arch_vcpu_async_ioctl(struct file *filp,
 			       unsigned int ioctl, unsigned long arg)
 {
@@ -3811,6 +3812,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
 	}
 	return -ENOIOCTLCMD;
 }
+#endif
 
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
-- 
1.8.3.1
