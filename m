Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2012 20:21:30 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12725 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903567Ab2E3SV0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 May 2012 20:21:26 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4fc663050000>; Wed, 30 May 2012 11:12:26 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 30 May 2012 11:10:23 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 30 May 2012 11:10:23 -0700
Message-ID: <4FC6628F.9060807@cavium.com>
Date:   Wed, 30 May 2012 11:10:23 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Refactor 'clear_page' and 'copy_page' functions.
References: <1337891904-24093-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1337891904-24093-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2012 18:10:23.0821 (UTC) FILETIME=[7B94D7D0:01CD3E8F]
X-archive-position: 33488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

On 05/24/2012 01:38 PM, Steven J. Hill wrote:
> From: "Steven J. Hill"<sjhill@mips.com>
>
> Remove usage of the '__attribute__((alias("...")))' hack that aliased
> to integer arrays containing micro-assembled instructions. This hack
> breaks when building a microMIPS kernel. It also makes the code much
> easier to understand.
>
> Signed-off-by: Steven J. Hill<sjhill@mips.com>

Looks good to (and even works for) me:

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/mm/Makefile     |    4 +--
>   arch/mips/mm/page-funcs.S |   49 +++++++++++++++++++++++++++++++++
>   arch/mips/mm/page.c       |   67 ++++++++++++---------------------------------
>   3 files changed, 69 insertions(+), 51 deletions(-)
>   create mode 100644 arch/mips/mm/page-funcs.S
>
