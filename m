Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 11:04:13 +0200 (CEST)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:43007 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822096AbaGWJELLxBLr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 11:04:11 +0200
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 336CF46471B;
        Wed, 23 Jul 2014 10:04:03 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KkFm1mh+-otL; Wed, 23 Jul 2014 10:04:01 +0100 (BST)
Received: from humdrum (unknown [10.24.1.221])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 47655462DFF;
        Wed, 23 Jul 2014 10:04:01 +0100 (BST)
Date:   Wed, 23 Jul 2014 10:03:58 +0100
From:   Rob Kendrick <rob.kendrick@codethink.co.uk>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: EdgeRouter Pro supported?  Strange FP problems
Message-ID: <20140723090357.GN30723@humdrum>
References: <20140722130616.GJ30723@humdrum>
 <53CE736E.1060009@imgtec.com>
 <20140722143311.GK30723@humdrum>
 <53CE8570.8020404@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53CE8570.8020404@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <rob.kendrick@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob.kendrick@codethink.co.uk
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

On Tue, Jul 22, 2014 at 04:38:24PM +0100, Markos Chandras wrote:
> a quick bisect between v3.15 and v3.16-rc1, which is the first tag with
> all the new FPU changes, leads to the following bad commit:
> 
> 08a07904e182895e1205f399465a3d622c0115b8
> MIPS: math-emu: Remove most ifdefery.

This appears to fix the problem:

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 736c17a..bf0fc6b 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1827,7 +1827,7 @@ dcopuop:
        case -1:
 
                if (cpu_has_mips_4_5_r)
-                       cbit = fpucondbit[MIPSInst_RT(ir) >> 2];
+                       cbit = fpucondbit[MIPSInst_FD(ir) >> 2];
                else
                        cbit = FPU_CSR_COND;
                if (rv.w)

Sadly I am totally ignorant of kernel patch processes.  What would be
approach to having this properly submitted?

-- 
Rob Kendrick, Senior Consulting Developer                Codethink Ltd.
Telephone: +44 7880 657 193              302 Ducie House, Ducie Street,
http://www.codethink.co.uk/         Manchester, M1 2JW, United Kingdom.
