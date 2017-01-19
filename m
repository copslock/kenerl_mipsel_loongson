Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 11:22:07 +0100 (CET)
Received: from mout.web.de ([212.227.15.4]:52407 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993179AbdASKWAhmrg0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Jan 2017 11:22:00 +0100
Received: from [192.168.1.2] ([77.181.224.32]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqlRS-1bzkh22l7q-00eM5v; Thu, 19
 Jan 2017 11:20:46 +0100
Subject: [PATCH v2] MIPS: KVM: Return directly after a failed copy_from_user()
 in kvm_arch_vcpu_ioctl()
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>
References: <87aac8b8-4f30-2edd-4688-42d32d815cd1@users.sourceforge.net>
 <88b008c5-552b-7314-94d8-02214f38a456@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <7a6b5858-9137-9d20-78fe-6b466081920f@users.sourceforge.net>
Date:   Thu, 19 Jan 2017 11:20:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <88b008c5-552b-7314-94d8-02214f38a456@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:D5h9mowCzh9bvvrBJu0ts6XJrtWNxbqzcDoQhKpfKA8iYm5pM6j
 wsW87hO9gyznCyFphysMvfyldLLN8sHJUE6T439K7Qwy8rYeceiCTYI7IfsR2iDJrxR5JYy
 mLgteONGeBbF9IjLFeaispLwmwWJjlTP6cunxaVWbPclNpHnyp2/Hu9GzCrzOte/TCIaIbo
 ufZnJRvxK6BH8Aht8JzAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PF977fpb7pE=:rTT+mDd2xE1qTBlt7kBa0i
 mQGV9+2xR7wa1BACUEliFsle6tLroi6kK2cM4LK6cSU9IJ092kXVZvZeqbk3CiMlxEhVQ/avo
 OdcEo5+VSSstVDQmsh5HSq2GnXDnzj3Mu6H6G5rq7s3bqLHATmw3effUG0LTCoDJuLh6ojtLc
 08L1R92LoKalbRcU+Jp3Mg0MAbJWjRkurwVZkA/9jhL1JJeOWHPItHWS2Pjub98Dg+6aruZKX
 hfjL6L0EwGMYybpm7JYLX3sC+ipGt8e6EoAzfE/xq4pMSKuc2uO1SkVGSAJ6aFpVpWoKtzZD4
 YnqhrujNQ55AF7NP3lTZpQVv8mqXIME7oCUsBV3emYugCeMwm5fvxVa0O7lrKLGDew5QubIti
 992k4Zqzvy5dnAEJFhRptl5ij6px05sEHIP9mb7jQvrgJ8aa9acD3w8H/hT7bvuJSLlaeYRGV
 KGBo2EnCKedMyRCu8EceFn7vEwnNPyaw2eQUx4zgNApqPG+GRxiHBWglKM4v09oBhHr5LI+QJ
 34YNzpKV9tjI9PgKWGVmKSkljGkTryKHsd5vDAqAXUgGm9T5mS+iEwf7Chx/2hbNcoNImwcrW
 r/fFD41VU09bpU8ytujXToAVmoNLLKCetYRkJneDUcr23cfBtsCRX8lfI93TnUjhfjaN3R0N0
 KdQ4SHbNjEHlNhui/ixEgvbythrhuTjCkid5mHl3zG883G5o0fiFVibjFkMJI9wNRhAYszn75
 Uj+A1Aq0qBRAqmIQNtfjpUxaz6Q2+8SuhRth0UPfI4kNwlhZi9W9OnB3ZHW7MJ09k2U8e2Gpy
 tedkEQO
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 19 Jan 2017 11:10:26 +0100

* Return directly after a call of the function "copy_from_user" failed
  in a case block.

* Delete the jump label "out" which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

V2:
A label was also removed at the end.

 arch/mips/kvm/mips.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 06a60b19acfb..3534a0b9efed 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1152,10 +1152,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
 		{
 			struct kvm_mips_interrupt irq;
 
-			r = -EFAULT;
 			if (copy_from_user(&irq, argp, sizeof(irq)))
-				goto out;
-
+				return -EFAULT;
 			kvm_debug("[%d] %s: irq: %d\n", vcpu->vcpu_id, __func__,
 				  irq.irq);
 
@@ -1165,17 +1163,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
 	case KVM_ENABLE_CAP: {
 		struct kvm_enable_cap cap;
 
-		r = -EFAULT;
 		if (copy_from_user(&cap, argp, sizeof(cap)))
-			goto out;
+			return -EFAULT;
 		r = kvm_vcpu_ioctl_enable_cap(vcpu, &cap);
 		break;
 	}
 	default:
 		r = -ENOIOCTLCMD;
 	}
-
-out:
 	return r;
 }
 
-- 
2.11.0
