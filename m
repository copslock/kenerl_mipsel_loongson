Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 23:50:51 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:50378 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835001Ab3FSVuir1JT6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jun 2013 23:50:38 +0200
Message-ID: <51C227A5.4030902@imgtec.com>
Date:   Wed, 19 Jun 2013 16:50:29 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/3] MIPS: Don't try to decode microMIPS branch instructions
 where they cannot exist.
References: <1369432450-13583-1-git-send-email-ddaney.cavm@gmail.com> <1369432450-13583-3-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1369432450-13583-3-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.150.195]
X-SEF-Processed: 7_3_0_01192__2013_06_19_22_50_33
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 05/24/2013 04:54 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> In mm_isBranchInstr() we can short circuit the entire function if
> !cpu_has_mmips.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: Steven J. Hill <Steven.Hill@imgtec.com>
>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
