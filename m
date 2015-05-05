Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 May 2015 14:34:41 +0200 (CEST)
Received: from hofr.at ([212.69.189.236]:55153 "EHLO mail.hofr.at"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026074AbbEEMehTwRA4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 May 2015 14:34:37 +0200
Received: by mail.hofr.at (Postfix, from userid 1002)
        id 63F264F8BE2; Tue,  5 May 2015 14:34:38 +0200 (CEST)
Date:   Tue, 5 May 2015 14:34:38 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Gleb Natapov <gleb@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [BUG ?] MIPS: KVM: condition with no effect
Message-ID: <20150505123438.GA21514@opentech.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <hofrat@hofr.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: der.herr@hofr.at
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


Hi !

 Not sure if this is a bug or maybe a placeholder for
 something... so patch - but maybe someone that knows this code can
 give it a look.

arch/mips/kvm/emulate.c:emulation_result kvm_mips_complete_mmio_load()    
<snip>
2414         case 2:
2415                 if (vcpu->mmio_needed == 2)
2416                         *gpr = *(int16_t *) run->mmio.data;                
2417                 else
2418                         *gpr = *(int16_t *) run->mmio.data;
2419 
2420                 break;
<snip>

 either the if/else is not needed or one of the branches is wrong
 or it is a place-holder for somethign that did not get
 done - in which case a few lines explaining this would be 
 nice (e.g. like in arch/sh/kernel/traps_64.c line 59)

 line numbers refer to 4.1-rc2 

thx!
hofrat
