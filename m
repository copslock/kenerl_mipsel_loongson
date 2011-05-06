Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2011 12:56:30 +0200 (CEST)
Received: from cantor.suse.de ([195.135.220.2]:56711 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491056Ab1EFK41 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 May 2011 12:56:27 +0200
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTP id 9F74A94746;
        Fri,  6 May 2011 12:56:22 +0200 (CEST)
Message-ID: <4DC3D3D5.6060007@suse.cz>
Date:   Fri, 06 May 2011 12:56:21 +0200
From:   Michal Marek <mmarek@suse.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/6] of: Allow scripts/dtc/libfdt to be used from
 kernel code
References: <1304614949-30460-1-git-send-email-ddaney@caviumnetworks.com> <1304614949-30460-2-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1304614949-30460-2-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mmarek@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmarek@suse.cz
Precedence: bulk
X-list: linux-mips

On 5.5.2011 19:02, David Daney wrote:
> --- /dev/null
> +++ b/drivers/of/libfdt/Makefile
> @@ -0,0 +1,8 @@
> +ccflags-y := -include linux/libfdt_env.h -I$(src)/../../../scripts/dtc/libfdt
> +
> +obj-y = fdt.o fdt_wip.o fdt_ro.o
> +
> +
> +$(obj)/%.o: $(src)/../../../scripts/dtc/libfdt/%.c FORCE
> +	$(call cmd,force_checksrc)
> +	$(call if_changed_rule,cc_o_c)

It's just three source files, so you could use three one-line wrappers 
that #include ../../../scripts/dtc/libfdt/<file>.c instead of copying 
the %.c -> %.o rule here.

Michal
