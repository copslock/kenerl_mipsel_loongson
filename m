Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2014 10:59:23 +0100 (CET)
Received: from mail.linux-iscsi.org ([67.23.28.174]:34830 "EHLO
        linux-iscsi.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823075AbaA2J7SymnJz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Jan 2014 10:59:18 +0100
Received: from [192.168.1.68] (75-37-193-228.lightspeed.lsatca.sbcglobal.net [75.37.193.228])
        (using SSLv3 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nab)
        by linux-iscsi.org (Postfix) with ESMTPSA id E1E8822D9A6;
        Wed, 29 Jan 2014 09:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=linux-iscsi.org;
        s=default.private; t=1390988304; bh=+kHj+ovqUasn/Eu6RF+umuFc/kT/7JJ
        l/epFaRG23u0=; h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:Mime-Version:Content-Transfer-Encoding;
        b=srEXhKROv9c94nA7bnAot7/XCD6f7k52m88oCoPJiZjegAoAOeghU/RZ899vOccG4
        dGOqLFzGhPWwfO0QR5hcWGPuFp9GFH2ok2NYgAliiDlH2+EMbIgWAuPcBI2d16deQvq
        s9VRfAVoy3IifikY7mTAX/VmP8wYAzMnZZkOSyY=
Message-ID: <1390989698.17325.73.camel@haakon3.risingtidesystems.com>
Subject: Re: [target:for-next 51/51] ERROR:
 "__cmpxchg_called_with_bad_pointer" undefined!
From:   "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To:     kbuild test robot <fengguang.wu@intel.com>
Cc:     kbuild-all@01.org, target-devel <target-devel@vger.kernel.org>,
        linux-mips@linux-mips.org
Date:   Wed, 29 Jan 2014 02:01:38 -0800
In-Reply-To: <52e8a4ef.ROAJSlpOaZtBxfoG%fengguang.wu@intel.com>
References: <52e8a4ef.ROAJSlpOaZtBxfoG%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <nab@linux-iscsi.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nab@linux-iscsi.org
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

On Wed, 2014-01-29 at 14:51 +0800, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/nab/target-pending.git for-next
> head:   7769401d351d54d5cbcb6400ec60c0b916e87a7e
> commit: 7769401d351d54d5cbcb6400ec60c0b916e87a7e [51/51] target: Fix percpu_ref_put race in transport_lun_remove_cmd
> config: make ARCH=mips allmodconfig
> 
> All error/warnings:
> 
> >> ERROR: "__cmpxchg_called_with_bad_pointer" undefined!
> 

So MIPS doesn't like typedef bool as 1-byte char being used for cmpxchg
-> ll/sc instructions..

Fixing this up now by making se_cmd->lun_ref_active use a single word
instead.

Thanks Fengguang!

--nab

diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index d284186..909dacb 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -552,7 +552,7 @@ struct se_cmd {
        void                    *priv;
 
        /* Used for lun->lun_ref counting */
-       bool                    lun_ref_active;
+       int                     lun_ref_active;
 
        /* DIF related members */
        enum target_prot_op     prot_op;
