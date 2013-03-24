Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Mar 2013 09:52:41 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:40778 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820514Ab3CXIwkOg9im (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 24 Mar 2013 09:52:40 +0100
Message-ID: <514EBDFA.4030903@phrozen.org>
Date:   Sun, 24 Mar 2013 09:48:58 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 9/9] MIPS: Netlogic: Fix oprofile compile on XLR uniprocessor
References: <cover.1364062916.git.jchandra@broadcom.com> <f0a97197480a23f447bc5e135c4ffb46eb8ab0ba.1364062916.git.jchandra@broadcom.com>
In-Reply-To: <f0a97197480a23f447bc5e135c4ffb46eb8ab0ba.1364062916.git.jchandra@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35964
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

On 23/03/13 19:28, Jayachandran C wrote:
> cpu_logical_map is only defined if CONFIG_SMP is set, so use it
> only when compiling for SMP.
>
> Signed-off-by: Jayachandran C<jchandra@broadcom.com>

Hi,

You might want to reference the commit that introduced the bug just for 
the sake of correctness. I recall that this code was only added recently.

	John
