Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2012 13:11:41 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:37607 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823031Ab2LRMLkChIO- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Dec 2012 13:11:40 +0100
Message-ID: <50D05D02.1090405@openwrt.org>
Date:   Tue, 18 Dec 2012 13:09:38 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Zi Shen Lim <zlim@netlogicmicro.com>,
        Jayachandran C <jchandra@broadcom.com>
Subject: Re: [PATCH v2] MIPS: perf: fix build failure in XLP perf support.
References: <1355729179-5442-1-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1355729179-5442-1-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

On 17/12/12 08:26, Manuel Lauss wrote:
> Commit 4be3d2f3966b9f010bb997dcab25e7af489a841e ("MIPS: perf: Add
> XLP support for hardware perf.") added UNSUPPORTED_PERF_EVENT_ID
> which was removed a while back.
>
> Cc: Zi Shen Lim<zlim@netlogicmicro.com>
> Cc: Jayachandran C<jchandra@broadcom.com>
> Signed-off-by: Manuel Lauss<manuel.lauss@gmail.com>
> ---
>

Hi,

my bad, this commit clashed with on in Ralf's tree...

Acked-by: John Crispin <blogic@openwrt.org
