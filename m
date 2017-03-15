Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 16:28:23 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39170 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990514AbdCOP1vbT0xV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Mar 2017 16:27:51 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2FEFhQg009003;
        Wed, 15 Mar 2017 15:15:43 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2FEFgme009002;
        Wed, 15 Mar 2017 15:15:42 +0100
Date:   Wed, 15 Mar 2017 15:15:42 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: MIPS/Emulate: Fix preemption warning
Message-ID: <20170315141542.GF5512@linux-mips.org>
References: <20170314000515.26573-1-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170314000515.26573-1-james.hogan@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Mar 14, 2017 at 12:05:15AM +0000, James Hogan wrote:

> Host kernels with preemption enabled will emit the following preemption
> warning when the guest FPU is used:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: qemu-system-mip/1495
> caller is kvm_mips_emulate_CP0+0xa48/0xea0 [kvm]
> ...
> Call Trace:
> [<ffffffff81122d50>] show_stack+0x88/0xa8
> [<ffffffff814307ac>] dump_stack+0x9c/0xd0
> [<ffffffff81459f24>] check_preemption_disabled+0x124/0x130
> [<ffffffffc000e908>] kvm_mips_emulate_CP0+0xa48/0xea0 [kvm]
> [<ffffffffc000f9f0>] kvm_mips_emulate_inst+0x190/0x268 [kvm]
> [<ffffffffc0016220>] kvm_trap_emul_handle_cop_unusable+0x48/0x160 [kvm]
> [<ffffffffc000c120>] kvm_mips_handle_exit+0x520/0x7e0 [kvm]
> 
> This is due to the use of current_cpu_data.fpu_id from a preemptible
> context to read the MIPS_FPIR_F64 bit. We don't currently support
> asymmetric FPU capabilities with KVM, so just use boot_cpu_data instead
> to silence the warning.
> 
> Fixes: 6cdc65e31d4f ("MIPS: KVM: Emulate FPU bits in COP0 interface")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> Cc: <stable@vger.kernel.org> # 4.1.x-

Acked-by: Ralf Baechle <ralf@linux-mips.org>

James, we've fixed too many of these warnings over the past years, we
should look for a solution to kill this whole class of bugs.

  Ralf
