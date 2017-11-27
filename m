Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Nov 2017 13:36:51 +0100 (CET)
Received: from mail.skyhub.de ([5.9.137.197]:51580 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990417AbdK0MglM0sg7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Nov 2017 13:36:41 +0100
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YXf3bvyOhpsX; Mon, 27 Nov 2017 13:36:34 +0100 (CET)
Received: from pd.tnic (p200300EC2BCA65007D1712CEF30A72D0.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:6500:7d17:12ce:f30a:72d0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 581F21EC00EA;
        Mon, 27 Nov 2017 13:36:34 +0100 (CET)
Date:   Mon, 27 Nov 2017 13:36:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     James Hogan <james.hogan@mips.com>
Cc:     David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Daniel Walker <dwalker@fifo99.com>,
        James Hogan <jhogan@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Steven J . Hill" <steven.hill@cavium.com>,
        linux-edac@vger.kernel.org, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Subject: Re: [PATCH RFC] EDAC: octeon: Fix uninitialized variable warning
Message-ID: <20171127123624.mujctehb6kuvyxrz@pd.tnic>
References: <20171113161206.20990-1-james.hogan@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171113161206.20990-1-james.hogan@mips.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <bp@alien8.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bp@alien8.de
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

On Mon, Nov 13, 2017 at 04:12:06PM +0000, James Hogan wrote:
> From: James Hogan <jhogan@kernel.org>
> 
> Fix uninitialized variable warning in the Octeon EDAC driver, as seen in
> MIPS cavium_octeon_defconfig builds since v4.14 with Codescape GNU Tools
> 2016.05-03:
> 
> drivers/edac/octeon_edac-lmc.c In function ‘octeon_lmc_edac_poll_o2’:
> drivers/edac/octeon_edac-lmc.c:87:24: warning: ‘((long unsigned int*)&int_reg)[1]’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   if (int_reg.s.sec_err || int_reg.s.ded_err) {
>                         ^
> 
> This was introduced in commit 1bc021e81565 ("EDAC: Octeon: Add error
> injection support"), and is fixed by initialising the whole int_reg
> variable to zero before the conditional assignments in the error
> injection case.
> 
> Fixes: 1bc021e81565 ("EDAC: Octeon: Add error injection support")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Steven J. Hill <steven.hill@cavium.com>
> Cc: linux-edac@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 3.15+
> ---
> Comments appreciated. Is this correct?
> 
> I've added the stable tag on the assumption that this might matter. If
> not it can be changed. It'd be nice to have it in 4.14 though to silence
> the warning since the driver was added to cavium_octeon_defconfig in
> commit f922bc0ad08b ("MIPS: Octeon: cavium_octeon_defconfig: Enable more
> drivers").
> ---
>  drivers/edac/octeon_edac-lmc.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
