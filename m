Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2017 14:44:29 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993871AbdAJNoVyjvxS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Jan 2017 14:44:21 +0100
Received: from localhost (unknown [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A3B4B2F;
        Tue, 10 Jan 2017 13:44:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: [PATCH 4.9 022/206] KVM: MIPS: Dont clobber CP0_Status.UX
Date:   Tue, 10 Jan 2017 14:35:05 +0100
Message-Id: <20170110131503.724412936@linuxfoundation.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110131502.767555407@linuxfoundation.org>
References: <20170110131502.767555407@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 4c881451d3017033597ea186cf79ae41a73e1ef8 upstream.

On 64-bit kernels, MIPS KVM will clear CP0_Status.UX to prevent the
guest (running in user mode) from accessing the 64-bit memory segments.
However the previous value of CP0_Status.UX is never restored when
exiting from the guest.

If the user process uses 64-bit addressing (the n64 ABI) this can result
in address error exceptions from the kernel if it needs to deliver a
signal before returning to user mode, as the kernel will need to write a
sigframe to high user addresses on the user stack which are disallowed
by CP0_Status.UX=0.

This is fixed by explicitly setting SX and UX again when exiting from
the guest, and explicitly clearing those bits when returning to the
guest. Having the SX and UX bits set when handling guest exits (rather
than only when exiting to userland) will be helpful when we support VZ,
since we shouldn't need to directly read or write guest memory, so it
will be valid for cache management IPIs to access host user addresses.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kvm/entry.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -521,6 +521,9 @@ void *kvm_mips_build_exit(void *addr)
 	uasm_i_and(&p, V0, V0, AT);
 	uasm_i_lui(&p, AT, ST0_CU0 >> 16);
 	uasm_i_or(&p, V0, V0, AT);
+#ifdef CONFIG_64BIT
+	uasm_i_ori(&p, V0, V0, ST0_SX | ST0_UX);
+#endif
 	uasm_i_mtc0(&p, V0, C0_STATUS);
 	uasm_i_ehb(&p);
 
@@ -643,7 +646,7 @@ static void *kvm_mips_build_ret_to_guest
 
 	/* Setup status register for running guest in UM */
 	uasm_i_ori(&p, V1, V1, ST0_EXL | KSU_USER | ST0_IE);
-	UASM_i_LA(&p, AT, ~(ST0_CU0 | ST0_MX));
+	UASM_i_LA(&p, AT, ~(ST0_CU0 | ST0_MX | ST0_SX | ST0_UX));
 	uasm_i_and(&p, V1, V1, AT);
 	uasm_i_mtc0(&p, V1, C0_STATUS);
 	uasm_i_ehb(&p);
