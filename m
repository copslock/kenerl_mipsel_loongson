Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2012 08:06:50 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:48936 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820610Ab2LNHGtK9QUF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Dec 2012 08:06:49 +0100
Message-ID: <50CACF97.5020402@phrozen.org>
Date:   Fri, 14 Dec 2012 08:04:55 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] OF: MIPS: sead3: Implement OF support.
References: <1355464558-11787-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1355464558-11787-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 14/12/12 06:55, Steven J. Hill wrote:
> From: "Steven J. Hill"<sjhill@mips.com>
>
> Activate USE_OF for SEAD-3 platform. Add basic DTS file and convert
> memory detection and reservations to use OF.
>
> Signed-off-by: Steven J. Hill<sjhill@mips.com>
> ---
>   arch/mips/Kconfig                        |    1 +
>   arch/mips/include/asm/mips-boards/prom.h |    2 +
>   arch/mips/mti-sead3/Makefile             |   14 ++-
>   arch/mips/mti-sead3/sead3-init.c         |    5 +-
>   arch/mips/mti-sead3/sead3-memory.c       |  138 ------------------------------
>   arch/mips/mti-sead3/sead3-setup.c        |   31 +++++++
>   arch/mips/mti-sead3/sead3.dts            |   26 ++++++
>   7 files changed, 76 insertions(+), 141 deletions(-)
>   delete mode 100644 arch/mips/mti-sead3/sead3-memory.c
>   create mode 100644 arch/mips/mti-sead3/sead3.dts
>



Hi Steven,

this patch still has the 2 problems i mentioned in the V1 inside it.

	John
