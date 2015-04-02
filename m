Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2015 17:27:52 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:59096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006802AbbDBP1vDG0-h (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Apr 2015 17:27:51 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1099EACF1;
        Thu,  2 Apr 2015 15:27:50 +0000 (UTC)
Message-ID: <551D5FF5.7070503@suse.cz>
Date:   Thu, 02 Apr 2015 17:27:49 +0200
From:   Michal Marek <mmarek@suse.cz>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
CC:     linux-mips@linux-mips.org, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-ia64@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        Jeff Dike <jdike@addtoit.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@arm.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-user@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] kbuild: refactor Makefile inclusion
References: <1427456618-23830-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1427456618-23830-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <mmarek@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmarek@suse.cz
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

On 2015-03-27 12:43, Masahiro Yamada wrote:
> Masahiro Yamada (4):
>   kbuild: use relative path to include Makefile
>   kbuild: use relative path more to include Makefile
>   kbuild: include $(src)/Makefile rather than $(obj)/Makefile
>   kbuild: ia64: use $(src)/Makefile.gate rather than particular path

Applied to kbuild.git#kbuild.

Michal
