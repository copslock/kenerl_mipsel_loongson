Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Nov 2011 14:45:21 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:35452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903600Ab1KTNpP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 20 Nov 2011 14:45:15 +0100
Received: from relay1.suse.de (nat.nue.novell.com [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx2.suse.de (Postfix) with ESMTP id 2415D890B6;
        Sun, 20 Nov 2011 14:45:14 +0100 (CET)
Message-ID: <4EC9046C.3050708@suse.cz>
Date:   Sun, 20 Nov 2011 14:45:16 +0100
From:   Michal Marek <mmarek@suse.cz>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-embedded@vger.kernel.org, x86@kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH RFC 3/5] kbuild/extable: Hook up sortextable into the
 build system.
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com> <1321645068-20475-4-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1321645068-20475-4-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 31819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmarek@suse.cz
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16678

On 18.11.2011 20:37, David Daney wrote:
> +	$(if $(CONFIG_BUILDTIME_EXTABLE_SORT),				\
> +	$(Q)$(if $($(quiet)cmd_sortextable),				\
> +	  echo '  $($(quiet)cmd_sortextable)  vmlinux' &&)		\
> +	  $(cmd_sortextable)  vmlinux)

Why do you opencode $(call cmd,sortextable) here?

Michal
